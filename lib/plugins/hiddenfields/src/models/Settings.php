<?php
namespace selvinortiz\hiddenfields\models;

use craft\base\Model;


class Settings extends Model
{
    /**
     * A list of content field handles to hide from non-admins
     *
     * @example
     * [
     *   'stripeKey'
     * ]
     * @var array
     */
    public $contentFields = [];

    /**
     * A list of sidebar field handles to hide from non-admins
     *
     * @example
     * [
     *   'slug',
     *   'author'
     * ]
     *
     * @var array
     */
    public $sidebarFields = [];

    /**
     * All fields namespaced for JS context
     *
     * @var array
     */
    private $fields;


    /**
     * Returns a flat list of field names to use in the JS context
     *
     * @return array
     */
    public function fields()
    {
        if ($this->fields === null)
        {
            $this->fields = [];

            foreach ($this->contentFields as $contentField)
            {
                array_push($this->fields, sprintf('fields-%s-field', $contentField));
            }

            foreach ($this->sidebarFields as $sidebarField)
            {
                array_push($this->fields, sprintf('%s-field', $sidebarField));
            }
        }

        return $this->fields;
    }

    public function hasFields()
    {
        return (bool) count($this->fields());
    }
}
