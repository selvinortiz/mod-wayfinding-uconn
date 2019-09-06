<?php

namespace modules\sys\elements;

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

    public function mapUrl()
    {
        if (!$this->parent) {
            return null;
        }

        $type = $this->type->handle;

        $url = sprintf('maps/%s/%s/%s.svg', $type, $this->parent->id, $this->id);

        return UrlHelper::url($url);
    }
}
