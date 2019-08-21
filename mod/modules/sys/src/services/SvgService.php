<?php

namespace modules\sys\services;

use Craft;
use craft\base\Component;

class SvgService extends Component
{
    public function generate()
    {
        $markers = [
            ['x' => 626, 'y' => 296],
            ['x' => 493, 'y' => 375],
            ['x' => 72, 'y' => 225],
            ['x' => 345, 'y' => 459],
        ];

        $markers = array_map(function($marker) {
            return Craft::$app->getView()->renderPageTemplate('_marker', $marker);
        }, $markers);

        return $this->renderTemplate(
            '_svg',
            [
                'width' => 1390,
                'height' => 835,
                'base64EncodedImage' => base64_encode(file_get_contents(dirname(__DIR__, 5).'/web/img/map.png')),
                'content' => Template::raw(implode(PHP_EOL, $pins))
            ]
        );
    }
}
