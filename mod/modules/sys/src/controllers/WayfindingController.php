<?php

namespace modules\sys\controllers;

use craft\web\Controller;
use modules\sys\elements\Place;
use modules\sys\elements\Person;
use yii\helpers\Url;
use yii\web\HttpException;
use yii\web\Response;
use function modules\sys\sys;

/**
 * Class WayfindingController
 *
 * @package modules\sys\controllers
 */
class WayfindingController extends Controller
{
    protected $allowAnonymous = true;

    public function actionIndex()
    {
        $markers = [
            ['x' => 626, 'y' => 296, 'fill' => 'red'],
            ['x' => 493, 'y' => 375, 'fill' => 'green'],
        ];

        // return sys()->svg->fromSvg(Url::to('svg/map.svg'), $markers);
        return sys()->svg->fromImage(Url::to('img/map.png'), $markers);
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
