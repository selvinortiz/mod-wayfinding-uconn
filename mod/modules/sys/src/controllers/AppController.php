<?php

namespace modules\sys\controllers;

use craft\elements\Asset;
use craft\elements\GlobalSet;
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

        $kiosk    = Json::encode($kiosk);
        $theme    = file_get_contents(dirname(__DIR__, 5).'/theme.json');
        $settings = $this->getGlobalSettings();

        return $this->renderTemplate('index', compact('kiosk', 'theme', 'settings'));
    }

    private function getGlobalSettings()
    {
        $settings  = [];
        $globalSet = GlobalSet::find()
            ->with(['logo', 'images'])
            ->handle('settings')
            ->one();

        if ($globalSet)
        {
            $settings = $globalSet->getFieldValues();

            foreach ($settings as $handle => &$value)
            {
                // Replace value with previously eager loaded one
                if ($globalSet->hasEagerLoadedElements($handle))
                {
                    $value = $globalSet->getEagerLoadedElements($handle);
                }

                // Clean up what is returned for asset fields
                if (is_array($value))
                {
                    foreach ($value as &$item)
                    {
                        if ($item instanceof Asset)
                        {
                            $item = [
                                'url'    => $item->getUrl(),
                                'width'  => $item->getWidth(),
                                'height' => $item->getHeight(),
                            ];
                        }
                    }
                }
            }
        }

        return $settings;
    }
}
