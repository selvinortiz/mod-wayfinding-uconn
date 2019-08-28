<?php

namespace modules\feeds\queue;

use Craft;
use craft\elements\Category;
use craft\helpers\App;
use modules\sys\elements\Person;
use Throwable;

class PeopleFeed extends Feed
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

        foreach ($root as $element)
        {
            $step++;

            /*
            <person uid="mca00003">
                <first-name>Michael</first-name>
                <last-name>Abate</last-name>
                <building-name/>
                <building-street>UConn Health</building-street>
                <building-city>FARMINGTON</building-city>
                <building-state>CT</building-state>
                <building-postal-zip>060306325</building-postal-zip>
                <campus>Health Center</campus>
                <floor>None</floor>
                <room-number>None</room-number>
                <title>Technical Analyst 2</title>
                <phone>+1 860 679 5478</phone>
                <email>michael.abate@uconn.edu</email>
                <department>Comm Med And Hlth Care</department>
            </person>
            */

            // ROOM
            // $roomFromXml    = $this->str($element, 'room-number');
            // $roomKeyFromXml = $this->str($element, 'room-uid');

            // if (empty($roomFromXml) || mb_strtolower($roomFromXml) == 'none')
            // {
            //     $roomFromXml = null;
            // }

            // // Give the feed a chance to define the room id
            // $roomKey = $this->str($element, 'room-uid', $roomKey);

            $emailFromXml      = $this->str($element, 'email');
            $titleFromXml      = $this->str($element, 'title');
            $departmentFromXml = $this->str($element, 'department');

            if (empty($emailFromXml))
            {
                // Skip
                continue;
            }

            $roles = null;

            if (!empty($departmentFromXml))
            {
                $department = Category::find()
                    ->title($departmentFromXml)
                    ->one();

                if (!$department)
                {
                    $department = new Category([
                        'groupId' => 1,
                        'title'   => $departmentFromXml
                    ]);

                    Craft::$app->getElements()->saveElement($department);
                }

                $roles = [
                    'new1' => [
                        'type' => 'role',
                        'fields' => [
                            'roleTitle'      => $titleFromXml,
                            'roleDepartment' => [$department->id]
                        ]
                    ]
                ];
            }

            $person = Person::query()
                ->personEmail($emailFromXml)
                ->one();

            if (!$person)
            {
                $person = new Person([
                    'personKey'       => $this->str($element, 'uid', $emailFromXml),
                    'personFirstName' => $this->str($element, 'first-name'),
                    'personLastName'  => $this->str($element, 'last-name'),
                    'personEmail'     => $this->str($element, 'email'),
                    'personPhone'     => $this->str($element, 'phone'),
                ]);

                if ($roles)
                {
                    $person->setFieldValue('personRoles', $roles);
                    $person->setFieldValue('personRelatedDepartments', [$department->id]);
                }

                $elements->saveElement($person);
            }

            $this->setProgress($queue, $step / $total);
        }

        // feeds()->info('Done importing {total} {id} 👍', compact('total', 'id'));

        return true;
    }

    public function behaviors()
    {
        return [
            FeedBehavior::class,
        ];
    }

    protected function defaultDescription()
    {
        return sprintf('People Feed');
    }
}
