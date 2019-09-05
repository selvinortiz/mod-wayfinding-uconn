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
        $theme = file_get_contents(dirname(__DIR__, 5).'/theme.json');

        return $this->renderTemplate('index', compact('kiosk', 'theme'));
    }
}
