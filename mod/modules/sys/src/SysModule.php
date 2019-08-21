<?php

namespace modules\sys;

use Craft;
use yii\base\Module;
use modules\sys\services\WebService;
use craft\console\Application as Console;

/**
 * @property WebService $web
 */
class SysModule extends Module
{
    public function init()
    {
        Craft::setAlias('@modules/sys', dirname(__DIR__, 1));

        Craft::$app->set('web', WebService::class);

        $this->controllerNamespace = 'modules\sys\controllers';

        if (Craft::$app instanceof Console)
        {
            $this->controllerNamespace = 'modules\sys\console\controllers';
        }

        parent::init();
    }

    public function log($message, $vars = [], $level = Logger::LEVEL_INFO)
    {
        if (is_string($message)) {
            $message = Craft::t('site', $message, $vars);
        } else {
            $message = print_r(compact('message', 'vars'), true);
        }

        Craft::getLogger()->log($message, $level);
    }

    public function info($message, $vars = [])
    {
        $this->log($message, $vars, Logger::LEVEL_INFO);
    }

    public function error($message, $vars = [])
    {
        $this->log($message, $vars, Logger::LEVEL_ERROR);
    }
}

/**
 * @return SysModule
 */
function sys()
{
    static $module;

    if ($module === null) {
        $module = Craft::$app->getModule('sys');
    }

    return $module;
}
