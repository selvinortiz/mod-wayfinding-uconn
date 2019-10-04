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
            ->limit(48)
            ->with(['relatedDepartments'])
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
                    'title' => $element->title,
                    'info'  => $this->getInfoByType($element),
                    'type'  => $element->type->handle,
                    'url'   => $element->url
                ];
            },
            $elements
        );
    }

    private function getInfoByType(Element $element)
    {
        return '';
    }
}
