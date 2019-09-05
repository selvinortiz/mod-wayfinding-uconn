<?php

namespace modules\sys\controllers;

use Craft;
use craft\helpers\Json;
use craft\web\Controller;
use modules\sys\elements\Building;

class AppController extends Controller
{
    protected $allowAnonymous = true;

    public function actionIndex(int $kioskId = null)
    {
        $kiosk = [];

        if ($kioskId)
        {
            $kiosk = Building::query()
                ->id($kioskId)
                ->with(['buildingPhoto'])
                ->asArray()
                ->one();

            $kiosk = $kiosk ?: [];
        }

        $kiosk = Json::encode($kiosk);
        $theme = Json::encode(Craft::$app->config->getConfigFromFile('theme'));

        return $this->renderTemplate('index', compact('kiosk', 'theme'));
    }
}
