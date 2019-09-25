<?php

namespace modules\sys\controllers;

use craft\elements\Asset;
use craft\web\Controller;
use craft\elements\Category;
use modules\sys\elements\Building;
use modules\sys\elements\Campus;
use modules\sys\elements\Floor;
use modules\sys\elements\Place;
use modules\sys\elements\Person;
use modules\sys\elements\Room;
use yii\db\Query;
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

        $markers = $this->generateMarkers($map, $buildings);

        return sys()->web->asSvg($this->generateImage($map, $markers));
    }

    public function actionGenerateFloorMap(int $floorId, string $roomIds)
    {
        $floor = Floor::query()
            ->with(['floorMap'])
            ->id($floorId)
            ->one();

        if (!$floor || !($map = $floor->floorMap[0] ?? null))
        {
            throw new HttpException(404, 'Floor map not found');
        }

        $rooms = Room::query()
            ->id($roomIds)
            ->all();

        $markers = $this->generateMarkers($map, $rooms);

        return sys()->web->asSvg($this->generateImage($map, $markers));
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPlace()
    {
        $id    = sys()->web->param('id');
        $place = Place::query()
        ->with(['children', 'campusMap', 'campusPhoto', 'buildingPhoto', 'floorMap'])
        ->id($id)
        ->one();

        if (!$place)
        {
            return sys()->web->asJsonWithError('Did not find a place');
        }

        $place = $place->values();

        return sys()->web->asJson(
            'Place',
            ['place' => $place]
        );
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPlaceFirst()
    {
        $place = Place::query()
        ->with(['children', 'campusMap', 'campusPhoto', 'buildingPhoto', 'floorMap'])
        ->one();

        if (!$place)
        {
            return sys()->web->asJsonWithError('Did not find a place');
        }

        $place = $place->values();

        return sys()->web->asJson(
            'Place',
            ['place' => $place]
        );
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

        $person = Person::query()
            ->with([
                'personPhoto',
                'personRelatedPlace',
                'personRelatedDepartments',
                'personRoles.role:roleDepartment'
            ])
            ->id($id)
            ->one();

        if (!$person)
        {
            return sys()->web->asJsonWithError('Did not find a person');
        }

        return sys()->web->asJson(
            'Found person',
            ['person' => $person->getFieldValues()]
        );
    }

    /**
     * @return Response
     * @throws HttpException
     */
    public function actionPeople()
    {
        $filters = sys()->web->param('filters');

        $query = Person::query();

        $query->with([
            'personRoles.role:roleDepartment'
        ]);

        if (!empty($filters))
        {
            $letter = $filters['letter'] ?? null;

            if (mb_strlen(trim($letter)) == 1)
            {
                $query->search(sprintf('personLastName:%s*', $letter));
            }

            $department = $filters['department'] ?? null;

            if ($department && ($department = Category::find()->groupId(1)->id($department)->one()))
            {
                $query->relatedTo([
                    'targetElement' => $department
                ]);
            }
        }

        $people = $query->limit(50)->all();

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

    private function generateMarkers(Asset $image, array $places)
    {
        return array_map(function($place) use ($image)
        {
            // 8 half of the circle marker width/height
            $x = round(($place->placeMarker['x']/100) * $image->getWidth());
            $y = round(($place->placeMarker['y']/100) * $image->getHeight());

            return compact('x', 'y');
        }, $places);
    }

    private function generateImage(Asset $image, array $markers)
    {
        // Is it an SVG?
        if (mb_stripos($image->getUrl(), '.svg') !== false)
        {
            return sys()->svg->fromSvg(
                $image->getUrl(),
                $markers,
                $image->getWidth(),
                $image->getHeight()
            );
        }

        return sys()->svg->fromImage(
            $image->getUrl(),
            $markers,
            $image->getWidth(),
            $image->getHeight()
        );
    }
}
