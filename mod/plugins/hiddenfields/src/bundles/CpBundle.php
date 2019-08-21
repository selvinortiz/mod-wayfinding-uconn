<?php
namespace selvinortiz\hiddenfields\bundles;

use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

class CpBundle extends AssetBundle
{
    public function init()
    {
        $this->sourcePath = '@selvinortiz/hiddenfields/resources';

        // Will ensure that jQuery is available for DOM traversal
        $this->depends = [
            CpAsset::class,
        ];

        $this->js = [
            'cp.js',
        ];

        parent::init();
    }
}
