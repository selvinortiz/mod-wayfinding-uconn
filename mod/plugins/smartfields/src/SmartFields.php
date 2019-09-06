<?php
namespace selvinortiz\smartfields;

use yii\base\Event;

use craft\base\Plugin;
use craft\services\Fields;
use craft\events\RegisterComponentTypesEvent;

use selvinortiz\smartfields\fields\MarkerCoordinatesField;

class SmartFields extends Plugin
{
    public function init()
    {
        parent::init();

        Event::on(
            Fields::class,
            Fields::EVENT_REGISTER_FIELD_TYPES,
            function(RegisterComponentTypesEvent $event)
            {
                $event->types[] = MarkerCoordinatesField::class;
            }
        );
    }
}
