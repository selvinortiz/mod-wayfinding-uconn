<?php

namespace modules\sys;

use Craft;
use craft\events\RegisterTemplateRootsEvent;
use craft\web\View;
use modules\sys\services\SvgService;
use yii\base\Event;
use yii\base\Exception;
use yii\base\Module;
use modules\sys\services\WebService;
use craft\console\Application as Console;

/**
 * @property WebService $web
 * @property SvgService $svg
 */
class SysModule extends Module
{
    /**
     * @throws \yii\base\InvalidConfigException
     */
    public function init()
    {
        parent::init();

        Craft::setAlias('@modules/sys', dirname(__DIR__, 1));

        Craft::$app->set('web', WebService::class);
        Craft::$app->set('svg', SvgService::class);

        $this->controllerNamespace = 'modules\sys\controllers';

        if (Craft::$app instanceof Console)
        {
            $this->controllerNamespace = 'modules\sys\console\controllers';
        }

        if (Craft::$app->config->general->devMode)
        {
            // Ensure that functions such as:
            // - file_get_contents
            // - getimagesize
            // do not raise SSL warnings
            stream_context_set_default([
                'ssl' => [
                    'verify_peer'      => false,
                    'verify_peer_name' => false,
                ]
            ]);
        }
    }

    /**
     * @param string $template
     * @param array  $variables
     *
     * @return string
     * @throws Exception
     * @throws \Throwable
     */
    public function renderTemplate(string $template, array $variables = [])
    {
        $file = __DIR__.'/templates/'.ltrim($template, '/').'.html';

        if (!is_readable($file))
        {
            throw new Exception('Did not find template: '.$file);
        }

        $fileContent = file_get_contents($file);

        return Craft::$app->view->renderObjectTemplate($fileContent, $variables);
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
 * @return SysModule
 */
function sys()
{
    static $module;

    if ($module === null)
    {
        $module = Craft::$app->getModule('sys');
    }

    return $module;
}
