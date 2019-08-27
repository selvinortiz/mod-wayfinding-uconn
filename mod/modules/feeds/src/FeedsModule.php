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

    public function setting($key, $default = null)
    {
        return $this->val($this->settings, $key, $default);
    }

    public function val($node, $key, $default = null)
    {
        if (strpos($key, '.') !== false && count(($keys = explode('.', $key))))
        {
            foreach ($keys as $key)
            {
                $node = $node[$key] ?? $node->{$key} ?? null;

                if ($node === null)
                {
                    return $default;
                }
            }

            return $node;
        }

        return $node[$key] ?? $node->{$key} ?? $default;
    }

    public function str($node, $key, $default = null)
    {
        return (string)$this->val($node, $key, $default);
    }

    public function boolean($node, $key, $default = null)
    {
        $val = $this->str($node, $key, $default);

        return in_array($val, ['1', 'true', 'yes']) ? true : false;
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
    static $module;

    if ($module === null)
    {
        $module = Craft::$app->getModule('feeds');
    }

    return $module;
}
