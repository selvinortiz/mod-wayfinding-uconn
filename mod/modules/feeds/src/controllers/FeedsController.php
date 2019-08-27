<?php

namespace modules\feeds\controllers;

use Craft;
use craft\web\Controller;
use modules\feeds\queue\Feed;

Class FeedsController extends Controller
{
    public $allowAnonymous = true;

    public function actionPlaces()
    {
        // Enqueue feed job
        Craft::$app->queue->push(new Feed(['id' => 'places']));

        // Run the garbage collector
        Craft::$app->gc->run(true);

        return $this->asJson('Feed queued up👍');
    }
}
