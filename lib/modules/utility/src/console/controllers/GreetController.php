<?php

namespace modules\utility\controllers;

use yii\console\Controller;

class ImportController extends Controller
{
    public $allowAnonymous = true;

    public function actionIndex()
    {
        echo 'Hey there 👋';
    }
}
