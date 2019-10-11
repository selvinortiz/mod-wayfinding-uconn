<?php
namespace modules\sys\elements;

/**
 * Class Floor
 *
 * @package modules\sys\elements
 */
class Floor extends Place
{
    const TYPE_HANDLE    = 'floor';
    const SECTION_HANDLE = 'places';

    public $typeId    = 6;
    public $sectionId = 2;

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
                        Building::touch(
                            Campus::touch($ancestor)
                        )
                        ->values();
                },
                $place->getAncestors()
                    ->with([
                        'campusMap',
                        'campusPhoto',
                        'buildingPhoto',
                        'roomPhoto',
                    ])
                    ->orderBy('typeId desc')
                    ->limit(2)
                    ->all()
            );

            if (is_array($place->children))
            {
                $place->values['descendants'] = array_map(
                    function($descendant)
                    {
                        return Room::touch($descendant)->values();
                    },
                    (array) $place->children
                );
            }

            unset($place->values['campusMap']);
            unset($place->values['campusPhoto']);
            unset($place->values['buildingPhoto']);
            unset($place->values['roomPhoto']);
        }

        return $place;
    }
}
