<?php

namespace modules\sys\console\controllers;

use craft\console\Controller;
use DOMDocument;
use yii\console\ExitCode;

class SvgController extends Controller
{
    public function actionPrepare()
    {
        $svg = file_get_contents(dirname(__DIR__, 6).'/campus.svg');

        $svg = str_replace('id="pin-', 'class="pin" id="pin-', $svg);

        $output = $svg;

        $this->stdout(print_r($output, true));
        $this->stdout(PHP_EOL);

        return ExitCode::OK;
    }

    public function actionDisplay()
    {
        $dom = new DOMDocument();

        $dom->load(dirname(__DIR__, 6).'/campus.svg');

        $output = '';

        $circles = $dom->getElementsByTagNameNS();

        $output = $circles;

        $this->stdout(print_r($output, true));
        $this->stdout(PHP_EOL);

        return ExitCode::OK;
    }
}
