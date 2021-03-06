<?php

namespace modules\sys\controllers;

use craft\elements\Asset;
use craft\elements\Category;
use craft\web\Controller;
use modules\sys\elements\Building;
use modules\sys\elements\Campus;
use modules\sys\elements\Floor;
use modules\sys\elements\Person;
use modules\sys\elements\Place;
use modules\sys\elements\Room;
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

    /**
     * @param int         $campusId
     * @param string|null $buildingIds
     *
     * @return Response
     * @throws HttpException
     * @throws \yii\base\Exception
     */
    public function actionGenerateCampusMap(int $campusId, string $buildingIds = null)
    {
        $campus = Campus::query()
            ->with(['campusMap'])
            ->id($campusId)
            ->one();

        if (!$campus || !($map = $campus->campusMap[0] ?? null))
        {
            throw new HttpException(404, 'Campus map not found');
        }

        // Set this if if any of the building IDs are prefixed with an @ sign
        $locationId = null;

        if (!empty($buildingIds))
        {
            $buildingIds = explode(',', $buildingIds);

            foreach ($buildingIds as $key => $buildingId)
            {
                if (stripos($buildingId, '@') !== false)
                {
                    $buildingIds[$key] = $locationId = ltrim($buildingId, '@');
                }
            }

            $buildings = Building::query()
                ->id($buildingIds)
                ->all();

            $markers = $this->generateMarkers($map, $buildings, $locationId);
        }

        return sys()->web->asSvg($this->generateImage($map, $markers ?? []));
    }

    /**
     * @param int         $floorId
     * @param string|null $roomIds
     *
     * @return Response
     * @throws HttpException
     * @throws \yii\base\Exception
     */
    public function actionGenerateFloorMap(int $floorId, string $roomIds = null)
    {
        $floor = Floor::query()
            ->with(['floorMap'])
            ->id($floorId)
            ->one();

        if (!$floor || !($map = $floor->floorMap[0] ?? null))
        {
            throw new HttpException(404, 'Floor map not found');
        }


        if (!empty($buildingIds))
        {
            $buildingIds = explode(',', $buildingIds);

            foreach ($buildingIds as $key => $buildingId)
            {
                if (stripos($buildingId, '@') !== false)
                {
                    $buildingIds[$key] = $locationId = ltrim($buildingId, '@');
                }
            }

            $buildings = Building::query()
                ->id($buildingIds)
                ->all();

            $markers = $this->generateMarkers($map, $buildings, $locationId);
        }

        $locationId = null;

        if (!empty($roomIds))
        {
            $roomIds = explode(',', $roomIds);


            foreach ($roomIds as $key => $roomId)
            {
                if (stripos($roomId, '@') !== false)
                {
                    $roomIds[$key] = $locationId = ltrim($roomId, '@');
                }
            }

            $rooms   = Room::query()
                ->id($roomIds)
                ->all();
        }
        else
        {
            $rooms = Room::query()->limit(1)->all();
        }

        $markers = $this->generateMarkers($map, $rooms, $locationId);

        return sys()->web->asSvg($this->generateImage($map, $markers));
    }

    /**
     * @return Response
     */
    public function actionPlace()
    {
        $id = sys()->web->param('id');

        // Set when the user is at a Kiosk
        $locationId = sys()->web->param('locationId');

        $place = Place::query()
            ->with(['children', 'campusMap', 'campusPhoto', 'buildingPhoto', 'roomPhoto', 'floorMap'])
            ->id($id)
            ->one();

        if (!$place)
        {
            return sys()->web->asJsonWithError('Did not find a place');
        }

        /*
            + User @Kiosk?
                + @Kiosk in same building as target building
                    + @Kiosk in same floor as target floor
                        + Show single floor map with two markers
                        - Show double floor map with 1 marker for source and 1 for target
                    - Show campus map, then single floor map
                - Show campus map, then single floor map
        */

        if ($locationId)
        {
            $location = Place::query()
                ->with(['children', 'campusMap', 'campusPhoto', 'buildingPhoto', 'roomPhoto', 'floorMap'])
                ->id($locationId)
                ->one();

            $place->location = $location;
        }

        $place->prepareMaps();

        $place = $place->values();

        return sys()->web->asJson(
            'Place',
            ['place' => $place]
        );
    }

    /**
     * @return Response
     */
    public function actionPlaceFirst()
    {
        // Set when the user is at a Kiosk
        $locationId = sys()->web->param('locationId');

        $place = Place::query()
            ->with(['children', 'campusMap', 'campusPhoto', 'buildingPhoto', 'roomPhoto', 'floorMap'])
            ->one();

        if (!$place)
        {
            return sys()->web->asJsonWithError('Did not find a place');
        }

        /*
            + User @Kiosk?
                + @Kiosk in same building as target building
                    + @Kiosk in same floor as target floor
                        + Show single floor map with two markers
                        - Show double floor map with 1 marker for source and 1 for target
                    - Show campus map, then single floor map
                - Show campus map, then single floor map
        */

        if ($locationId)
        {
            $location = Place::query()
                ->with(['campusMap', 'campusPhoto', 'buildingPhoto', 'roomPhoto', 'floorMap'])
                ->id($locationId)
                ->one();

            $place->location = $location;
        }

        $place->prepareMaps();

        $place = $place->values();

        return sys()->web->asJson(
            'Place',
            ['place' => $place]
        );
    }

    /**
     * @return Response
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

        $place = null;

        if (!empty($person->personRelatedPlace))
        {
            $place = Place::query()
                ->with(['children', 'campusMap', 'campusPhoto', 'buildingPhoto', 'roomPhoto', 'floorMap'])
                ->id($person->personRelatedPlace[0]->id)
                ->one();

            if ($place)
            {
                $place->prepareMaps();

                $place = $place->values();
            }
        }

        $person          = $person->getFieldValues();
        $person['place'] = $place;

        return sys()->web->asJson(
            'Found person',
            compact('person')
        );
    }

    /**
     * @return Response
     */
    public function actionPeople()
    {
        $filters = sys()->web->param('filters');

        $query = Person::query();

        $query->with([
            'personPhoto',
            'personRoles.role:roleDepartment',
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

        $people = $query
            ->orderBy('personLastName asc')
            ->limit(100)
            ->all();

        if (!$people)
        {
            return sys()->web->asJsonWithError('Did not find any people');
        }

        return sys()->web->asJson('Found people', compact('people'));
    }

    /**
     * @return Response
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

    private function generateMarkers(Asset $image, array $places, $locationId = null)
    {
        return array_map(function($place) use ($image, $locationId)
        {
            // 8 half of the circle marker width/height
            $x = round(($place->placeMarker['x'] / 100) * $image->getWidth());
            $y = round(($place->placeMarker['y'] / 100) * $image->getHeight());

            $id   = $place->id;
            $type = $place->type->handle;
            $here = $locationId && $locationId == $place->id;

            return compact('x', 'y', 'id', 'type', 'here');
        }, $places);
    }

    /**
     * @param Asset $image
     * @param array $markers
     *
     * @return string
     * @throws \yii\base\Exception
     */
    private function generateImage(Asset $image, array $markers = [])
    {
        // Is it an SVG?
        if (mb_stripos($image->getUrl(), '.svg') !== false)
        {
            return sys()->svg->fromSvg(
                $image->getUrl(),
                $markers
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
