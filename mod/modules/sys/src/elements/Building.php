<?php

namespace modules\sys\elements;

/**
 * Class Building
 *
 * @package modules\sys\elements
 *
 * @property int $screens
 * @property int $itemsPerPage
 * @property int $displayOrientation
 */
class Building extends Place
{
    const TYPE_HANDLE    = 'building';
    const SECTION_HANDLE = 'places';

    public $typeId    = 5;
    public $sectionId = 2;

    public static function getQuery()
    {
        $query = parent::getQuery();

        return $query;
    }

    public static function unpack(Place $place): Place
    {
        if ($place->type->handle == self::TYPE_HANDLE)
        {
            $place->values = array_merge(
                $place->getAttributes(['id', 'title', 'type']),
                $place->getFieldValues()
            );

            $place->values['ancestors'] = Campus::touch(
                $place->getAncestors()
                    ->with([
                        'campusMap',
                        'campusPhoto',
                    ])
                    ->one()
                )
                ->values();

            $descendants = $place->getDescendants(2)->all();

            $place->values['descendants'] = array_map(
                function($descendant)
                {
                    return Floor::touch(Room::touch($descendant))->values;
                },
                $descendants
            );

            unset($place->values['campusMap']);
            unset($place->values['campusPhoto']);
            unset($place->values['floorMap']);
        }

        return $place;
    }

}
