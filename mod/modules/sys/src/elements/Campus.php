<?php

namespace modules\sys\elements;

/**
 * Class Campus
 *
 * @package modules\sys\elements
 *
 */
class Campus extends Place
{
    const TYPE_HANDLE    = 'campus';
    const SECTION_HANDLE = 'places';

    public $typeId    = 4;
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

            $place->values['ancestors'] = [];

            if (is_array($place->children))
            {
                $place->values['descendants'] = array_map(
                    function($ancestor)
                    {
                        return
                            Room::touch(
                                Floor::touch(
                                    Building::touch($ancestor)
                                )
                            )
                            ->values();
                    },
                    $place->children
                );
            }

            $place->values['maps'] = [
                [
                    'image' => $place->campusMap[0]['url'] ?? null,
                    'markers' => ['x' => 10, 'y' => 10]
                ]
            ];

            unset($place->values['buildingPhoto']);
            unset($place->values['floorMap']);
        }

        return $place;
    }
}
