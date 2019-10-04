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
                        'zoom'   => 2,
                        'title'  => $this->campusName,
                        'type'   => 'campus',
                        'images' => [
                            [
                                'src' => $this->createMapUrl('campus', $this->id)
                            ]
                        ],
                    ];
                }
            }
            case 'building':
            {
                if ($this->parent && $this->parent->campusMap)
                {
                    $maps[] = [
                        'zoom'     => 2,
                        'type'     => 'campus',
                        'title'    => $this->buildingName,
                        'images'   => [
                            [
                                'src' => $this->createMapUrl('campus', $this->parent->id, [$this->id])
                            ]
                        ]
                    ];

                    $maps[] = [
                        'type'     => 'building',
                        'title'    => $this->buildingName,
                        'subtitle' => $this->descendants[0]->title,
                        'images'   => [
                            [
                                'src' => $this->createMapUrl('floor', $this->descendants[0]->id)
                            ]
                        ],
                    ];
                }
            }
            case 'room':
            {
                if ($this->parent && $this->parent->floorMap)
                {
                    // When user is at a Kiosk
                    if ($this->location)
                    {
                        $floor = $this->location->descendants->one();
                        $room  = $floor->descendants->one();

                        if ($floor->id != $this->ancestors[2]->id)
                        {
                            $image = [
                                'title'    => $this->location->buildingName,
                                'subtitle' => $floor->title,
                                'src'      => $this->createMapUrl('room', $floor->id, [$room->id])
                            ];
                        }
                    }

                    $maps[] = [
                        'zoom'   => 2,
                        'type'   => 'campus',
                        'title'  => $this->ancestors[1]->buildingName,
                        'images' => [
                            [
                                'src' => $this->createMapUrl('campus', $this->ancestors[0]->id, [$this->ancestors[1]->id])
                            ]
                        ],
                    ];

                    $maps[] = [
                        'type'     => 'building',
                        'title'    => $this->ancestors[1]->buildingName,
                        'subtitle' => $this->ancestors[2]->title,
                        'images'   => [
                            [
                                'src' => $this->createMapUrl('room', $this->ancestors[2]->id, [$this->id])
                            ],
                            $image ?? null
                        ],
                    ];
                }
            }
        }

        $this->values['maps'] = $maps;

        return $this;
    }

    /**
     * @param string $mapType (campus|floor|room)
     * @param int    $mapId ID of the place with the map (Campus or Floor)
     * @param array  $markerIds IDs of places marked on the map
     *
     * @return string
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
