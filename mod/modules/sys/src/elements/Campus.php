<?php

namespace modules\sys\elements;

/**
 * Class Campus
 *
 * @package modules\sys\elements
 *
 */
class Campus extends Element
{
    const TYPE_HANDLE    = 'campus';
    const SECTION_HANDLE = 'places';

    public $typeId    = 2;
    public $sectionId = 2;

    public static function getQuery()
    {
        $query = parent::getQuery();

        // $query->with(['campusSettings:settingsBlock']);

        return $query;
    }
}
