<?php

namespace modules\sys\controllers;

use Craft;
use craft\web\Controller;
use modules\sys\elements\Element;
use modules\sys\enums\SearchContext;
use function modules\sys\sys;

class SearchController extends Controller
{
    protected $allowAnonymous = true;

    /**
     * @return \yii\web\Response
     * @throws \yii\web\BadRequestHttpException
     */
    public function actionIndex()
    {
        $this->requirePostRequest();
        $this->requireAcceptsJson();

        $query   = sys()->web->param('searchQuery', Craft::$app->request->getQueryParam('qry'));
        $context = sys()->web->param('searchContext', Craft::$app->request->getQueryParam('ctx'));

        $elements = Element::query()
            ->type(SearchContext::type($context))
            ->section(SearchContext::section($context))
            ->search($this->prepareSearchQueryString($query))
            ->limit(100)
            ->with(['personRoles.role:roleDepartment'])
            ->all();

        $results = $this->elementsToArrays($elements);

        return sys()->web->asJson('Results', compact('results'));
    }

    private function prepareSearchQueryString(string $query)
    {
        return sprintf('title:%s', trim($query));
    }

    /**
     * Convert entries to JSON friendly objects for the JS side
     *
     * @param Element[] $elements
     *
     * @return array
     */
    private function elementsToArrays(array $elements = null)
    {
        if (empty($elements))
        {
            return [];
        }

        return array_map(
            function($element) {
                return [
                    'id'    => $element->id,
                    'title' => $this->getTitleByType($element),
                    'info'  => $this->getInfoByType($element),
                    'type'  => $element->type->handle,
                    'url'   => $element->url
                ];
            },
            $elements
        );
    }

    private function getTitleByType(Element $element)
    {
        switch ($element->type->handle)
        {
            case 'campus':
                return $element->campusName.' Campus';
            case 'building':
                return $element->buildingName.' Building';
            default:
                return $element->title;
        }
    }

    private function getInfoByType(Element $element)
    {
        switch ($element->type->handle)
        {
            case 'building':
                return [$element->parent->campusName.' Campus'];
            case 'room':
                return [
                    $element->parent->parent->buildingName.' Building',
                ];
            case 'person':
                $roleTitle      = $element->personRoles[0]['roleTitle'] ?? null;
                $roleDepartment = $element->personRoles[0]['roleDepartment'][0]->title ?? null;

                return array_filter([
                    $roleTitle,
                    $roleDepartment
                ]);
            default:
                return [];
        }
    }
}
