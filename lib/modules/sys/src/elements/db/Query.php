<?php

namespace modules\sys\elements\db;

use craft\db\Connection;
use craft\elements\db\EntryQuery;
use modules\sys\elements\Building;
use modules\sys\elements\Room;

/**
 * Class Query
 *
 * @package modules\sys\elements\db
 *
 * @method Campus[]|Building[]|Floor[]|Room[]|array all($db = null)
 * @method Campus|Building|Floor|Room|array|null one($db = null)
 * @method Campus|Building|Floor|Room|array|null nth(int $n, Connection $db = null)
 */
class Query extends EntryQuery
{
}
