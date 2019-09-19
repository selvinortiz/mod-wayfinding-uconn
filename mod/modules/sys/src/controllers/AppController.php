<?php

namespace modules\sys\controllers;

use craft\elements\Asset;
use craft\elements\GlobalSet;
use craft\helpers\Json;
use craft\web\Controller;
use modules\sys\elements\Building;
use modules\sys\elements\Campus;

class AppController extends Controller
{
    protected $allowAnonymous = true;

    public function actionIndex(int $kioskId = null)
    {
        $kiosk  = [];
        $campus = [];

        if ($kioskId)
        {
            $kiosk = Building::query()
                ->id($kioskId)
                ->with(['buildingPhoto'])
                ->one() ?? new Building();

            $kiosk = $kiosk->values();
        }
        else
        {
            $campus = Campus::query()
            ->with(['campusMap', 'campusPhoto'])
            ->one() ?? new Campus();

            $campus = $campus->values();
        }

        $theme    = $this->getTheme();
        $kiosk    = Json::encode($kiosk);
        $campus   = Json::encode($campus);
        $settings = Json::encode($this->getGlobalSettings());

        return $this->renderTemplate('index', compact('theme', 'campus', 'kiosk', 'settings'));
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

    private function getTheme()
    {
        return file_get_contents(dirname(__DIR__, 5).'/theme.json');
    }
}
