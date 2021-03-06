<?php

namespace modules\feeds;

use Craft;
use craft\console\Application as Console;
use yii\base\Module;
use yii\log\Logger;

/**
 * Class FeedsModule
 *
 * @package modules\feeds
 */
class FeedsModule extends Module
{
    protected $settings;

    /**
     * @throws \yii\base\InvalidConfigException
     */
    public function init()
    {
        parent::init();

        Craft::setAlias('@modules/feeds', __DIR__);

        $this->controllerNamespace = 'modules\feeds\controllers';

        if (Craft::$app instanceof Console)
        {
            $this->controllerNamespace = 'modules\feeds\console\controllers';
        }

        $this->settings = Craft::$app->config->getConfigFromFile('feeds');
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
 * @return Module|FeedsModule
 */
function feeds()
{
    return Craft::$app->getModule('feeds');
}
