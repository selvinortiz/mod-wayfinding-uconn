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
class Building extends Element
{
    const TYPE_HANDLE    = 'building';
    const SECTION_HANDLE = 'places';

    public static function getQuery()
    {
        $query = parent::getQuery();

        // $query->with(['buildingSettings:settingsBlock']);

        return $query;
    }
}
