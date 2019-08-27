<?php

namespace modules\feeds\queue;

use Craft;
use craft\elements\Entry;
use craft\helpers\App;
use craft\queue\BaseJob;
use Throwable;
use function modules\feeds\feeds;
use modules\feeds\transformers\Place;

class Feed extends BaseJob
{
    /**
     * Unique ID for this feed as defined in the config
     *
     * @var string
     */
    public $id;

    public function init()
    {
        parent::init();
    }

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
        App::maxPowerCaptain();

        $feeds    = feeds();
        $elements = Craft::$app->getElements();
        $settings = feeds()->setting($this->id);

        // @todo Pull xml file path/URL from config
        $node = simplexml_load_file($settings->file)->{$settings->node};

        $step  = 0;
        $total = $node->count();

        $feeds->info('Ready to import {total} {id} 🚀', compact('total', 'id'));

        Craft::dd($total);
        foreach ($node as $element) {
            $step++;

            $caseAttributes = [
                'title'                   => $feeds->str($element, 'CourtCaseHeaderGroup.CaseTitle'),
                'caseKey'                 => $feeds->str($element, 'caseKey'),
                'caseCourtKey'            => $feeds->str($element, 'HearingTrialSetting.CourtName.code'),
                'caseCourtText'           => $feeds->str($element, 'HearingTrialSetting.CourtName'),
                'caseStatusText'          => $feeds->str($element, 'HearingTrialSetting.Setting.SettingStatus'),
                'caseTypeText'            => $feeds->str($element, 'CourtCaseHeaderGroup.CaseTypeText'),
                'caseCategoryText'        => $feeds->str($element, 'CourtCaseHeaderGroup.CaseCategoryText'),
                'caseHearingLocationKey'  => $feeds->str($element, 'HearingTrialSetting.Setting.HearingLocation.code'),
                'caseHearingLocationText' => $feeds->str($element, 'HearingTrialSetting.Setting.HearingLocation'),
                'caseHearingDateTime'     => $feeds->str($element, 'HearingTrialSetting.Setting.HearingDateTimes.HearingDatetimeStart'),
                'caseJudgeKey'            => $feeds->str($element, 'HearingTrialSetting.Setting.PresidingJudge.JudgeID.ID'),
                'caseJudgeName'           => $feeds->str($element, 'HearingTrialSetting.Setting.PresidingJudge.PersonFullName'),
                'caseJudgeGivenName'      => $feeds->str($element, 'HearingTrialSetting.Setting.PresidingJudge.PersonGivenName'),
                'caseJudgeSurname'        => $feeds->str($element, 'HearingTrialSetting.Setting.PresidingJudge.PersonSurName'),
                'caseInterpreterRequired' => $feeds->boolean($element, 'HearingTrialSetting.Setting.InterpreterRequired'),
            ];

            $case = $this->makeCase(Place::transform($caseAttributes));

            $elements->saveElement($case);

            $this->setProgress($queue, $step / $total);
        }

        $feeds->info('Done importing {total} {id} 👍', compact('total', 'id'));

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
}
