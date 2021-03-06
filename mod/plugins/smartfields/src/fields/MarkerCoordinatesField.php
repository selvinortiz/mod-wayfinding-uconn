<?php
namespace selvinortiz\smartfields\fields;

use Craft;
use craft\base\Field;
use craft\elements\Entry;
use craft\helpers\Json;
use craft\base\ElementInterface;

class MarkerCoordinatesField extends Field
{
    public $x;
    public $y;

    public static function displayName(): string
    {
        return Craft::t('app', 'Marker Coordinates');
    }

    public function normalizeValue($value, ElementInterface $element = null)
    {
        if ($value === null)
        {
            return ['x' => 0, 'xr' => 0.0, 'y' => 0, 'yr' => 0.0, 'width' => 0, 'height' => 0];
        }

        return Json::decode($value);
    }

    public function serializeValue($value, ElementInterface $element = null)
    {
        if ($value === null)
        {
            $value = '{"x": 0, "xr": 0.0, "y": 0, "yr": 0.0, "width": 0, "height": 0}';
        }

        return Json::encode($value);
    }

    /**
     * @inheritdoc
     */
    public function getInputHtml($value, ElementInterface $element = null): string
    {
        $image = null;

        /**
         * @var Entry $parent
         */
        $parent = $element->getParent();

        if ($parent)
        {
            if ($parent->type->handle == 'campus')
            {
                $map   = $parent->campusMap->one() ?? null;
                $image = $map ? $map->getUrl() : null;
            }
            else
            {
                $map   = $parent->floorMap->one() ?? null;
                $image = $map ? $map->getUrl() : null;
            }
        }

        return empty($image) ? '' : Craft::$app
            ->getView()
            ->renderTemplate('smart-fields/_fields/marker-coordinates',
                [
                    'id'    => Craft::$app->getView()->namespaceInputId($this->handle),
                    'name'  => $this->handle,
                    'value' => $value,
                    'field' => $this,
                    'image' => $image,
                ]);
    }
}
