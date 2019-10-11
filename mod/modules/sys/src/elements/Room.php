<?php
namespace modules\sys\elements;

/**
 * Class Room
 *
 * @package modules\sys\elements
 */
class Room extends Place
{
    const TYPE_HANDLE    = 'room';
    const SECTION_HANDLE = 'places';

    public $typeId    = 7;
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

            $place->values['ancestors'] = array_map(
                function($ancestor)
                {
                    return
                        Floor::touch(
                            Building::touch(
                                Campus::touch($ancestor)
                            )
                        )
                        ->values();
                },
                $place->getAncestors()
                    ->with([
                        'campusMap',
                        'campusPhoto',
                        'buildingPhoto',
                        'roomPhoto',
                        'floorMap'
                    ])
                    ->orderBy('typeId desc')
                    ->limit(3)
                    ->all()
            );

            $place->values['descendants'] = [];

            unset($place->values['campusMap']);
            unset($place->values['campusPhoto']);
            unset($place->values['buildingPhoto']);
            unset($place->values['floorMap']);
        }

        return $place;
    }
}
