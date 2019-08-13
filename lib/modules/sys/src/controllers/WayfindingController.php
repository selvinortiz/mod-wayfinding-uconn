<?php

namespace modules\sys\controllers;

use craft\web\Controller;
use modules\sys\elements\Person;
use yii\web\HttpException;
use yii\web\Response;
use function modules\sys\sys;

class WayfindingController extends Controller
{
    protected $allowAnonymous = true;

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPlace()
    {
        $id = sys()->web->param('id');

        $person = Person::findOne($id);

        return sys()->web->asJson('Person', compact('person'));
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPlaces()
    {
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPerson()
    {
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPeople()
    {
    }
}
