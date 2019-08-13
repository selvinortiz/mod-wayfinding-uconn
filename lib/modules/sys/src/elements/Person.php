<?php
namespace modules\sys\elements;

/**
 * Class Room
 *
 * @package modules\sys\elements
 */
class Room extends Element
{
    const TYPE_HANDLE    = 'people';
    const SECTION_HANDLE = 'people';

    public static function getQuery()
    {
        $query = parent::getQuery();

        // $query->with(['peopleSettings:roomSettingsBlock']);

        return $query;
    }
}
