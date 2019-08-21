<?php

namespace modules\sys\elements;

use craft\elements\db\ElementQueryInterface;
use craft\elements\Entry;
use craft\helpers\Json;
use modules\sys\elements\db\Query;

class Element extends Entry
{
    const TYPE_HANDLE    = null;
    const SECTION_HANDLE = 'places';

    /**
     * A list of attribute names to be included when converting object asArray()
     * If set to null, all attributes will be included
     *
     * @var null|array
     */
    public $asArrayAttributeNames = null;

    /**
     * A list of attribute names to be included when converting object asJson()
     * If set to null, all attributes will be included
     *
     * @var null|array
     */
    public $asJsonAttributeNames = null;

    /**
     * @return Query
     */
    public static function find(): ElementQueryInterface
    {
        return new Query(static::class);
    }

    public static function query()
    {
        return static::getQuery();
    }

    public static function getQuery()
    {
        $config = [
            'siteId'  => 1,
            'section' => static::SECTION_HANDLE,
            'type'    => static::TYPE_HANDLE,
        ];

        return new Query(static::class, $config);
    }

    public function asArray(array $attributes = null): array
    {
        return $this->getAttributes($attributes ?? $this->asArrayAttributeNames);
    }

    public function asJson(array $attributes = null): string
    {
        return Json::encode($this->getAttributes($attributes ?? $this->asJsonAttributeNames));
    }
}
