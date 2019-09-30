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
    public $sectionId = 1;

    public static function getQuery()
    {
        $query = parent::getQuery();

        // $query->with(['personSettings:roomSettingsBlock']);

        return $query;
    }

    public function getFieldValues(array $fieldHandles = null): array
    {
        $values = parent::getFieldValues($fieldHandles);

        foreach ($values as $handle => &$value)
        {
            // Replace value with previously eager loaded one
            if ($this->hasEagerLoadedElements($handle))
            {
                $value = $this->getEagerLoadedElements($handle);
            }

            // Clean up what is returned for asset fields
            if (is_array($value))
            {
                foreach ($value as &$item)
                {
                    if ($item instanceof Asset)
                    {
                        $item = [
                            'url'    => $item->getUrl(),
                            'width'  => $item->getWidth(),
                            'height' => $item->getHeight(),
                        ];
                    }
                }

                if ($handle == 'personRelatedPlace' && $item->id)
                {
                    $place = Place::query()->id($item->id)->one();


                    $item = $place ? $place->values() : [];
                }
            }
        }

        return $values;
    }
}
