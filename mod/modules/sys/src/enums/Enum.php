<?php

namespace modules\sys\enums;

use ReflectionClass;

class Enum
{
    /**
     * @return null|array
     */
    public static function values()
    {
        return array_values((new ReflectionClass(static::class))->getConstants());
    }
}
