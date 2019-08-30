<?php

namespace modules\sys\elements;

use craft\helpers\UrlHelper;

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

    public function mapUrl()
    {
        $type = $this->type->handle;

        if (in_array($type, ['campus', 'floor']))
        {
            return null;
        }

        $url = sprintf('maps/%s/%s/%s.svg', $type, $this->parent->id, $this->id);

        return UrlHelper::url($url);
    }

    public function fields()
    {
        $fields = [];

        switch ($this->type->handle)
        {
            case 'room':
                $fields['floor']    = $this->parent->asArray(['id', 'title']);
                $fields['building'] = $this->parent->parent->asArray(['id', 'title']);
                $fields['campus']   = $this->parent->parent->parent->asArray(['id', 'title']);
            break;
            case 'building':
                $fields['campus']   = $this->parent->asArray(['id', 'title']);
            break;
        }

        return $fields;
    }
}
