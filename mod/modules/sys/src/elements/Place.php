<?php
namespace modules\sys\elements;

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

    public static function getQuery()
    {
        $query = parent::getQuery();

        // $query->with(['roomSettings:roomSettingsBlock']);

        return $query;
    }
}
