<?php

namespace modules\feeds\queue;

use craft\queue\BaseJob;

abstract class Feed extends BaseJob
{
    /**
     * Unique ID for this feed as defined in the config
     *
     * @var string
     */
    public $id;

    /**
     * Configs for this Feed
     *
     * @var array
     */
    public $config;

    public function get($key, $default = null)
    {
        return $this->val($this->config, $key, $default);
    }

    public function val($node, $key, $default = null)
    {
        $asArray = is_array($node);

        if (strpos($key, '.') !== false && count(($keys = explode('.', $key))))
        {
            foreach ($keys as $key)
            {
                $node = $asArray ? ($node[$key] ?? null) : ($node->{$key} ?? null);

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
}
