<?php
namespace selvinortiz\hiddenfields;

use craft\helpers\Json;
use yii\base\Event;

use Craft;
use craft\web\View;
use craft\base\Plugin;

use selvinortiz\hiddenfields\models\Settings;
use selvinortiz\hiddenfields\bundles\CpBundle;

class HiddenFields extends Plugin
{
    public function init()
    {
        parent::init();

        // Include hidden fields bundle if:
        // 1. We're responding to a CP request
        // 2. Logged in user is not an admin
        // 3. There are fields to hide

        if ($this->shouldIncludeAssetBundle()) {
            Event::on(
                View::class,
                View::EVENT_BEFORE_RENDER_TEMPLATE,
                function () {
                    // Hide the body as soon as possible to avoid the flash of unhidden fields)
                    Craft::$app->getView()->registerCss('body {display: none;}');

                    // JSON encode the list of fields to pass to the JS side
                    $fields = Json::encode($this->getSettings()->fields());

                    // Set JSON encoded fields before loading the bundle that uses them (POS_BEGIN)
                    Craft::$app->getView()->registerJs(
                        sprintf('window.hiddenFields = %s;', $fields),
                        View::POS_BEGIN
                    );

                    // Load the JS bundle after JSON encode fields have been set (POS_END)
                    Craft::$app->getView()->registerAssetBundle(CpBundle::class, View::POS_END);
                }
            );
        }
    }

    protected function shouldIncludeAssetBundle()
    {
        $isAdmin = Craft::$app->getUser()->getIsAdmin();
        $isCpRequest = Craft::$app->getRequest()->getIsCpRequest();
        $hasFieldsToHide = $this->getSettings()->hasFields();

        if ($isAdmin || !$isCpRequest || !$hasFieldsToHide)
        {
            return false;
        }

        $url = Craft::$app->getRequest()->getUrl();

        // Only on entry editing URLs
        return preg_match('/entries\/[^\/]+\/[^\/]+/i', $url);
    }

    protected function createSettingsModel()
    {
        return new Settings();
    }
}
