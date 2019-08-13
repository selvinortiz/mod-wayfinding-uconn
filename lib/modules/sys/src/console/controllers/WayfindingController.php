<?php

namespace modules\sys\console\controllers;

use yii\console\Controller;
use yii\console\ExitCode;
use yii\web\HttpException;
use yii\web\Response;
use function modules\sys\sys;

class WayfindingController extends Controller
{
    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPlace(int $id): int
    {
        $this->stdout('Int provided was: '.$id);
        $this->stdout(PHP_EOL);

        return ExitCode::OK;
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
