<?php

namespace modules\feeds\queue;

use Craft;
use craft\helpers\App;
use craft\helpers\ElementHelper;
use modules\sys\elements\Building;
use modules\sys\elements\Campus;
use modules\sys\elements\Floor;
use modules\sys\elements\Room;
use Throwable;

class PlacesFeed extends Feed
{
    /**
     * @param \craft\queue\QueueInterface|\yii\queue\Queue $queue
     *
     * @return bool
     * @throws Throwable
     * @throws \craft\errors\ElementNotFoundException
     * @throws \yii\base\Exception
     */
    public function execute($queue)
    {
        // Increase resource limits as much as it is allowed
        App::maxPowerCaptain();

        // Setup elements service for reuse
        $elements = Craft::$app->getElements();

        // Load the feed
        $root = simplexml_load_file($this->get('file'));

        // If the feed defines a node, set it as the root node
        if (($node = $this->get('node')))
        {
            $root = $root->{$node};
        }

        $step  = 0;
        $total = $root->count();

        foreach ($root as $element)
        {
            $step++;

            // CAMPUS
            $campus = Campus::query()
                ->campusName($this->str($element, 'campus'))
                ->one();

            if (!$campus)
            {
                $campus = new Campus([
                    'campusName' => $this->str($element, 'campus'),
                ]);

                $elements->saveElement($campus);
            }

            // BUILDING
            $buildingName = $this->str($element, 'building-name');

            $building = Building::query()
                ->buildingName($buildingName)
                ->one();

            if (!$building)
            {
                $buildingKey = sprintf('c%sb%s', $campus->id, ElementHelper::createSlug($buildingName));

                // Give the feed a chance to define the building key
                $building = new Building([
                    'newParentId'     => $campus->id,
                    'buildingKey'     => $buildingKey,
                    'buildingName'    => $buildingName,
                    'buildingAddress' => $this->str($element, 'building-street-address'),
                    'buildingCity'    => $this->str($element, 'building-city'),
                    'buildingState'   => $this->str($element, 'building-state'),
                    'buildingZipcode' => $this->str($element, 'building-postal-zip')
                ]);

                $elements->saveElement($building);
            }

            // FLOOR
            $floorFromXml = $this->str($element, 'floor');

            if (empty($floorFromXml))
            {
                // Skip this floor
                continue;
            }

            $floorKey = sprintf('c%sb%sf%s', $campus->id, $building->id, $floorFromXml);

            // Give the feed a chance to define the floor key
            $floorKey = $this->str($element, 'floor-uid', $floorKey);

            $floor = Floor::query()
                ->floorKey($floorKey)
                ->one();

            if (!$floor)
            {
                $floor = new Floor([
                    'newParentId' => $building->id,
                    'floorKey'    => $floorKey,
                    'floorNumber' => $floorFromXml,
                ]);

                $elements->saveElement($floor);
            }

            // ROOM
            $roomFromXml = $this->str($element, 'room-number');

            if (empty($roomFromXml))
            {
                // Skip this puppy
                continue;
            }

            $roomKey   = sprintf('c%sb%sf%sr%s', $campus->id, $building->id, $floor->id, $roomFromXml);
            $roomTitle = sprintf('Room - %s', $roomFromXml);

            // Give the feed a chance to define the room key and title
            $roomKey   = $this->str($element, 'room-uid', $roomKey);
            $roomTitle = $this->str($element, 'destination-name', $roomTitle);

            $room = Room::query()
                ->roomKey($roomKey)
                ->one();

            if (!$room)
            {
                $room = new Room([
                    'newParentId' => $floor->id,
                    'title'       => $roomTitle,
                    'roomKey'     => $roomKey,
                    'roomNumber'  => $roomFromXml,
                    'roomDisplay' => $this->boolean($element, 'display-on-directory', false)
                ]);

                $elements->saveElement($room);
            }

            $this->setProgress($queue, $step / $total);
        }

        return true;
    }

    protected function defaultDescription()
    {
        return sprintf('Places Feed');
    }
}
