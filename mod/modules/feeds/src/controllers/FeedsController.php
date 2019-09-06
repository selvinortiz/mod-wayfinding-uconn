<?php

namespace modules\feeds\controllers;

use Craft;
use craft\web\Controller;
use modules\feeds\queue\PlacesFeed;
use modules\feeds\queue\PeopleFeed;

class FeedsController extends Controller
{
    public $allowAnonymous = true;

    public function actionPlaces()
    {
        $config = Craft::$app->config->getConfigFromFile('feeds');

        // Enqueue feed job
        Craft::$app->queue->push(new PlacesFeed(
            [
                'id'     => 'places',
                'config' => $config['places']
            ]
        ));

        // Run the garbage collector
        Craft::$app->gc->run(true);

        return $this->asJson('Feed queued up👍');
    }

    public function actionPeople()
    {
        $config = Craft::$app->config->getConfigFromFile('feeds');

        // Enqueue feed job
        Craft::$app->queue->push(new PeopleFeed(
            [
                'id'     => 'people',
                'config' => $config['people']
            ]
        ));

        // Run the garbage collector
        Craft::$app->gc->run(true);

        return $this->asJson('Feed queued up👍');
    }
}
