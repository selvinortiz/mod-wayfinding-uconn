<?php

namespace modules\sys\elements;

/**
 * Class Person
 *
 * @package modules\sys\elements
 */
class Person extends Element
{
    const TYPE_HANDLE    = 'person';
    const SECTION_HANDLE = 'people';

    public $typeId    = 3;
    public $sectionId = 2;

    public static function getQuery()
    {
        $query = parent::getQuery();

        // $query->with(['personSettings:roomSettingsBlock']);

        return $query;
    }
}
