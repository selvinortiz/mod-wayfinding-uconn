<?php

namespace modules\sys\controllers;

use Craft;
use craft\web\Controller;
use craft\helpers\Template;
use modules\sys\elements\Place;
use modules\sys\elements\Person;
use yii\web\HttpException;
use yii\web\Response;
use function modules\sys\sys;

class WayfindingController extends Controller
{
    protected $allowAnonymous = true;

    public function actionIndex()
    {
        $pins = [
            ['x' => 626, 'y' => 296],
            ['x' => 493, 'y' => 375],
            ['x' => 72, 'y' => 225],
            ['x' => 345, 'y' => 459],
        ];

        $pins = array_map(function($pin) {
            return Craft::$app->getView()->renderPageTemplate('_pin', $pin);
        }, $pins);

        return $this->renderTemplate(
            '_svg',
            [
                'width' => 1390,
                'height' => 835,
                'base64EncodedImage' => base64_encode(file_get_contents(dirname(__DIR__, 5).'/web/img/map.png')),
                'content' => Template::raw(implode(PHP_EOL, $pins))
            ]
        );
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPlace()
    {
        $id = sys()->web->param('id');

        $place = Place::query()->id($id)->one();

        if (!$place)
        {
            return sys()->web->asJsonWithError('Did not find a place');
        }

        return sys()->web->asJson('Found place', compact('place'));
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPlaces()
    {
        $places = Place::query()->all();

        if (!$places)
        {
            return sys()->web->asJsonWithError('Did not find any place');
        }

        return sys()->web->asJson('Found places', compact('places'));
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPerson()
    {
        $id = sys()->web->param('id');

        $person = Person::query()->id($id)->one();

        if (!$person)
        {
            return sys()->web->asJsonWithError('Did not find a person');
        }

        return sys()->web->asJson('Found person', compact('person'));
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPeople()
    {
        $people = Person::query()->all();

        if (!$people)
        {
            return sys()->web->asJsonWithError('Did not find any people');
        }

        return sys()->web->asJson('Found people', compact('people'));
    }
}
