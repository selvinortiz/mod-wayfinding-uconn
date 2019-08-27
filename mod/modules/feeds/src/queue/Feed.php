<?php

namespace modules\feeds\queue;

use Craft;
use craft\elements\Entry;
use craft\helpers\App;
use craft\queue\BaseJob;
use Throwable;
use modules\sys\elements\Building;
use modules\sys\elements\Campus;
use modules\sys\elements\Floor;
use modules\sys\elements\Room;

class Feed extends BaseJob
{
    /**
     * Unique ID for this feed as defined in the config
     *
     * @var string
     */
    public $id;

    /**
     * Configs for this Feed
     *
     * @var array
     */
    public $config;

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
        $file = $this->get('file');

        $root = simplexml_load_file($this->get('file'));

        // If the feed defines a node, set it as the root node
        if (($node = $this->get('node')))
        {
            $root = $root->{$node};
        }

        $step  = 0;
        $total = $root->count();

        // feeds()->info('Ready to import {total} items 🚀', compact('total'));

        /*
        <campus>Storrs</campus>
        <building-city>Storrs</building-city>
        <building-name>Information Technology Services</building-name>
        <building-postal-zip>06269</building-postal-zip>
        <building-state>CT</building-state>
        <building-street-address>25 Gampel Service Dr</building-street-address>
        <destination-name>Office 101A</destination-name>
        <display-on-directory>FALSE</display-on-directory>
        <floor>1</floor>
        <room-number>101A</room-number>
        <room-uid>TAB-1-1101A</room-uid>
        */

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
            $building = Building::query()
                ->buildingName($this->str($element, 'building-name'))
                ->one();

            if (!$building)
            {
                $building = new Building([
                    'parentId'     => $campus->id,
                    'buildingName' => $this->str($element, 'building'),
                ]);

                $elements->saveElement($building);
            }

            // FLOOR
            $floorFromXml = $this->str($element, 'floor');

            if (empty($floorFromXml))
            {
                // Skip this puppy
                continue;
            }

            $floorId = sprintf('uid%s%s%s', $campus->id, $building->id, $this->str($element, 'floor'));

            $floor = Floor::query()
                ->floorId(sprintf('c%sb%sf%s', $campus->id, $building->id, $floorFromXml))
                ->one();

            if (!$floor)
            {
                $floor = new Floor([
                    'parentId'    => $building->id,
                    'floorId'     => $floorId,
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

            $roomId = sprintf('c%sb%sf%sr%s', $campus->id, $building->id, $floor->id, $roomFromXml);

            // Give the feed a chance to define the room id
            $roomId = $this->str($element, 'room-uid', $roomId);

            $room = Room::query()
                ->roomId(sprintf('c%sb%sf%s', $campus->id, $building->id, $roomFromXml))
                ->one();

            if (!$room)
            {
                $room = new Room([
                    'parentId'    => $floor->id,
                    'roomId'     => $roomId,
                    'roomNumber' => $roomFromXml,
                ]);

                $elements->saveElement($room);
            }

            $this->setProgress($queue, $step / $total);
        }

        feeds()->info('Done importing {total} {id} 👍', compact('total', 'id'));

        return true;
    }

    protected function defaultDescription()
    {
        return sprintf('Feeds');
    }

    private function makeCase($caseAttributes)
    {
        $case = Entry::find()
            ->typeId(1)
            ->sectionId(1)
            ->caseKey($caseAttributes['caseKey'])
            ->limit(1)
            ->one()
            ?? new Entry([
                'typeId'    => 1,
                'sectionId' => 1,
            ]);

        $case->setAttributes($caseAttributes, false);

        return $case;
    }

    private function get($key, $default = null)
    {
        return $this->val($this->config, $key, $default);
    }

    private function val($node, $key, $default = null)
    {
        $asArray = is_array($node);

        if (strpos($key, '.') !== false && count(($keys = explode('.', $key))))
        {
            foreach ($keys as $key)
            {
                $node = $asArray ? ($node[$key] ?? null) : ($node->{$key} ?? null);

                if ($node === null)
                {
                    return $default;
                }
            }

            return $node;
        }

        return $node[$key] ?? $node->{$key} ?? $default;
    }

    private function str($node, $key, $default = null)
    {
        return (string)$this->val($node, $key, $default);
    }

    private function boolean($node, $key, $default = null)
    {
        $val = $this->str($node, $key, $default);

        return in_array($val, ['1', 'true', 'yes']) ? true : false;
    }
}
