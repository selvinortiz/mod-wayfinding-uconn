<?php

namespace modules\utility;

use Craft;
use craft\console\Application as Console;
use yii\base\Module;
use yii\log\Logger;

/**
 * Class UtilityModule
 *
 * @package modules\utility
 */
class UtilityModule extends Module
{
    /**
     * @throws \yii\base\InvalidConfigException
     */
    public function init()
    {
        parent::init();

        Craft::setAlias('@modules/utility', __DIR__);

        $this->controllerNamespace = 'modules\utility\controllers';

        if (Craft::$app instanceof Console)
        {
            $this->controllerNamespace = 'modules\utility\console\controllers';
        }
    }

    public function log($message, $vars = [], $level = Logger::LEVEL_INFO)
    {
        if (is_string($message))
        {
            $message = Craft::t('site', $message, $vars);
        }
        else
        {
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
 * @return Module|UtilityModule
 */
function utility()
{
    return Craft::$app->getModule('utility');
}
