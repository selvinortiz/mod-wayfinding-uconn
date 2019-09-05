<?php

namespace modules\sys\controllers;

use craft\web\Controller;

class AppController extends Controller
{
    protected $allowAnonymous = true;

    public function actionIndex()
    {
        $vars = [
            'theme' => file_get_contents(dirname(__DIR__, 5).'/theme.json')
        ];

        return $this->renderTemplate('index', $vars);
    }
}
