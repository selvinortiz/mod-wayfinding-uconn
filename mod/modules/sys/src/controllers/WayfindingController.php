<?php

namespace modules\sys\controllers;

use craft\helpers\UrlHelper;
use craft\web\Controller;
use craft\elements\Category;
use modules\sys\elements\Building;
use modules\sys\elements\Campus;
use modules\sys\elements\Place;
use modules\sys\elements\Person;
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

        // return sys()->svg->fromSvg(UrlHelper::to('svg/map.svg'), $markers);
        return sys()->svg->fromImage(UrlHelper::to('img/map.png'), $markers);
    }

    public function actionGenerateCampusMap(int $campusId, string $buildingIds)
    {
        $campus = Campus::query()
            ->with(['campusMap'])
            ->id($campusId)
            ->one();

        if (!$campus || !($map = $campus->campusMap[0] ?? null))
        {
            throw new HttpException(404, 'Campus map not found');
        }

        $buildings = Building::query()
            ->id($buildingIds)
            ->all();

        $markers = array_map(function($building) use ($map)
        {
            // 8 half of the circle marker width/height
            $x = round(($building->placeMarker['xr']/100) * $map->getWidth()) + 32 + 8;  // 32 subtracted at save time
            $y = round(($building->placeMarker['yr']/100) * $map->getHeight()) + 64 + 8; // 64 subtracted at save time

            return compact('x', 'y');
        }, $buildings);

        return sys()->web->asSvg(
            sys()->svg->fromImage($map->getUrl(), $markers, $map->getWidth(), $map->getHeight())
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

        // $markers = array_map(function($building) use ($map)
        // {
        //     // 8 half of the circle marker width/height
        //     $x = round(($building->placeMarker['xr']/100) * $map->getWidth()) + 32 + 8;  // 32 subtracted at save time
        //     $y = round(($building->placeMarker['yr']/100) * $map->getHeight()) + 64 + 8; // 64 subtracted at save time

        //     return compact('x', 'y');
        // }, [$place->parent]);

        // return sys()->web->asSvg(
        //     sys()->svg->fromImage($map->getUrl(), $markers, $map->getWidth(), $map->getHeight())
        // );

        $response = $place->asArray([
            'id',
            'title',
        ]);

        $response['maps'] = [
            [
                'markers' => [$place->placeMarker],
                'image' => UrlHelper::url(sprintf('maps/campus/%s/%s.svg', $place->parent->id, $place->id))
            ]
        ];

        return sys()->web->asJson('Place', ['place' => $response]);
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPlaces()
    {
        $places = Place::query()->limit(100)->all();

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
        $people = Person::query()->limit(100)->all();

        if (!$people)
        {
            return sys()->web->asJsonWithError('Did not find any people');
        }

        return sys()->web->asJson('Found people', compact('people'));
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionDepartments()
    {
        $departments = Category::find()->groupId(1)->limit(100)->all();

        if (!$departments)
        {
            return sys()->web->asJsonWithError('Did not find any departments');
        }

        return sys()->web->asJson('Found departments', compact('departments'));
    }
}
