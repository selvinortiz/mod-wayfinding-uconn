<?php

namespace modules\feeds\controllers;

use Craft;
use craft\web\Controller;
use modules\feeds\queue\Feed;

class FeedsController extends Controller
{
    public $allowAnonymous = true;

    public function actionPlaces()
    {
        $config = Craft::$app->config->getConfigFromFile('feeds');

        // Enqueue feed job
        Craft::$app->queue->push(new Feed(
            [
                'id'     => 'places',
                'config' => $config['places']
            ]
        ));

        // Run the garbage collector
        Craft::$app->gc->run(true);

        return $this->asJson('Feed queued up👍');
    }
}
