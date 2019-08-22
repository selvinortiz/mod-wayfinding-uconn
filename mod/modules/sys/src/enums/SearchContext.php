<?php

namespace modules\sys\enums;

class SearchContext extends Enum
{
    const SEARCH_CONTEXT_PEOPLE   = 'people';
    const SEARCH_CONTEXT_PLACES   = 'places';
    const SEARCH_CONTEXT_PERSON   = 'person';
    const SEARCH_CONTEXT_CAMPUS   = 'campus';
    const SEARCH_CONTEXT_BUILDING = 'building';
    const SEARCH_CONTEXT_FLOOR    = 'floor';
    const SEARCH_CONTEXT_ROOM     = 'room';

    public static function type($context)
    {
        $type = $context;

        if (in_array($context, ['places', 'people']))
        {
            $type = null;
        }

        return $type;
    }

    public static function section($context)
    {
        $section = $context;

        if (!in_array($context, ['places', 'people']))
        {
            $section = null;
        }

        return $section;
    }
}
