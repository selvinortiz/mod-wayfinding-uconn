<?php

namespace modules\sys\elements;

use craft\elements\Asset;
use craft\helpers\UrlHelper;

/**
 * Class Place
 *
 * @package modules\sys\elements
 */
class Place extends Element
{
    const TYPE_HANDLE    = null;
    const SECTION_HANDLE = 'places';

    public $sectionId = 2;

    /**
     * When a user is at a Kiosk
     *
     * @var Place
     */
    public $location = null;

    /**
     * When converting a place to array, its values will be stored here
     *
     * @var array
     */
    public $values = [];

    public static function getQuery()
    {
        $query = parent::getQuery();

        return $query;
    }

    public static function touch(Place $place): Place
    {
        if ($place->type->handle == static::TYPE_HANDLE) {
            $place->values = array_merge(
                $place->getAttributes(['id', 'title', 'type']),
                $place->getFieldValues()
            );
        }

        return $place;
    }

    public function values()
    {
        return
            Room::unpack(
                Floor::unpack(
                    Building::unpack(
                        Campus::unpack($this)
                    )
                )
            )
            ->values;
    }

    /**
     * Ensures that fields do not overwrite eager loaded values
     *
     * @param array $fieldHandles
     *
     * @return array
     */
    public function getFieldValues(array $fieldHandles = null): array
    {
        $values = parent::getFieldValues($fieldHandles);

        foreach ($values as $handle => &$value)
        {
            // Replace value with previously eager loaded one
            if ($this->hasEagerLoadedElements($handle))
            {
                $value = $this->getEagerLoadedElements($handle);
            }

            // Clean up what is returned for asset fields
            if (is_array($value))
            {
                foreach ($value as &$item)
                {
                    if ($item instanceof Asset)
                    {
                        $item = [
                            'url'    => $item->getUrl(),
                            'width'  => $item->getWidth(),
                            'height' => $item->getHeight(),
                        ];
                    }
                }
            }
        }

        $values['maps'] = $this->values['maps'] ?? [];

        return $values;
    }

    public function prepareMaps()
    {
        $maps = [];

        switch($this->type->handle)
        {
            case 'campus':
            {
                if ($this->campusMap)
                {
                    $maps[] = [
                        'image'   => $this->createMapUrl('campus', $this->id),
                        'markers' => []
                    ];
                }
            }
            case 'building':
            {
                if ($this->parent && $this->parent->campusMap)
                {
                    $markerIds = [$this->id];

                    if ($this->location && $this->location->id !== $this->id)
                    {
                        $markerIds[] = $this->location->id;
                    }

                    $maps[] = [
                        'image'   => $this->createMapUrl('campus', $this->parent->id),
                        'markers' => [$this->placeMarker ?? null]
                    ];

                    $maps[] = [
                        'image'   => $this->createMapUrl('building', $this->parent->id, $markerIds),
                        'markers' => []
                    ];
                }
            }
            case 'room':
            {
                if ($this->parent && $this->parent->floorMap)
                {
                    $markerIds = [$this->id];

                    if ($this->location)
                    {
                        $markerIds[] = $this->location->id;
                    }

                    $maps[] = [
                        'image'   => $this->createMapUrl('room', $this->parent->id, $markerIds),
                        'markers' => [$this->placeMarker ?? null]
                    ];
                }
            }
        }

        // if (($mapUrl = $this->mapUrl()))
        // {
        //     $values['maps'] = [
        //         [
        //             'image'   => $mapUrl,
        //             'markers' => [$this->placeMarker ?? null],
        //         ]
        //     ];
        // }

        $this->values['maps'] = $maps;

        return $this;
    }

    /**
     * @param string $mapType (campus|floor|room)
     * @param int    $mapId ID of the place with the map (Campus or Floor)
     * @param array  $markerIds IDs of places marked on the map
     *
     * @return void
     */
    private function createMapUrl($mapType, $mapId, $markerIds = [])
    {
        if (empty($markerIds))
        {
            $url = sprintf('maps/%s/%s.svg', $mapType, $mapId);
        }
        else
        {
            $url = sprintf('maps/%s/%s/%s.svg', $mapType, $mapId, implode(',', array_filter($markerIds)));
        }

        return UrlHelper::url($url);
    }
}
