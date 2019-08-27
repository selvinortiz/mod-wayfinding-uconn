<?php
namespace modules\sys\elements;

/**
 * Class Room
 *
 * @package modules\sys\elements
 */
class Room extends Element
{
    const TYPE_HANDLE    = 'room';
    const SECTION_HANDLE = 'places';

    public $typeId    = 5;
    public $sectionId = 2;

    public static function getQuery()
    {
        $query = parent::getQuery();

        // $query->with(['roomSettings:roomSettingsBlock']);

        return $query;
    }
}
