<?php

namespace modules\utility\controllers;

use craft\web\Controller;

class ImportController extends Controller
{
    public $allowAnonymous = true;

    public function actionIndex()
    {
        return $this->asJson('Hey there 👋');
    }
}
