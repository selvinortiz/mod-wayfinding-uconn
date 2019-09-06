<?php

namespace modules\sys\services;

use Craft;
use craft\base\Component;
use craft\helpers\Json;
use craft\web\Response;

class WebService extends Component
{
    private $_params;

    public function init()
    {
        parent::init();

        $this->_params = Json::decode(Craft::$app->request->getRawBody());
    }

    public function param($key, $default = null)
    {
        return $this->_params[$key] ?? $default;
    }

    public function asJson($message, $data = [])
    {
        $data['success']  = $data['success'] ?? true;
        $data['message']  = $data['message'] ?? $message;
        $data['received'] = $data['received'] ?? $this->_params;

        $response         = Craft::$app->getResponse();
        $response->format = Response::FORMAT_JSON;
        $response->data   = $data;

        return $response;
    }

    public function asJsonWithError($message, $data = [])
    {
        $data['success']  = $data['success'] ?? false;
        $data['message']  = $data['message'] ?? $message;
        $data['received'] = $data['received'] ?? $this->_params;

        $response         = Craft::$app->getResponse();
        $response->format = Response::FORMAT_JSON;
        $response->data   = $data;

        return $response;
    }

    public function asSvg($data)
    {
        $response         = Craft::$app->getResponse();
        $response->format = Response::FORMAT_RAW;
        $response->data   = $data;

        $response->getHeaders()->add('Content-Type', 'image/svg+xml');

        return $response;
    }
}
