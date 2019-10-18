<?php

/**
 * Site URL Rules
 *
 * You can define custom site URL rules here, which Craft will check in addition
 * to any routes you’ve defined in Settings → Routes.
 *
 * See http://www.yiiframework.com/doc-2.0/guide-runtime-routing.html for more
 * info about URL rules.
 *
 * In addition to Yii’s supported syntaxes, Craft supports a shortcut syntax for
 * defining template routes:
 *
 *     'blog/archive/<year:\d{4}>' => ['template' => 'blog/_archive'],
 *
 * That example would match URIs such as `/blog/archive/2012`, and pass the
 * request along to the `blog/_archive` template, providing it a `year` variable
 * set to the value `2012`.
 */

return [
    'maps/<type:(floor|room)+>/<floorId:\d+><ext:(.svg)?>'                              => 'sys/wayfinding/generate-floor-map',
    'maps/<type:(floor|room)+>/<floorId:\d+>/<roomIds:[0-9@,]+><ext:(.svg)?>'           => 'sys/wayfinding/generate-floor-map',
    'maps/<type:(campus|building)+>/<campusId:\d+><ext:(.svg)?>'                        => 'sys/wayfinding/generate-campus-map',
    'maps/<type:(campus|building)+>/<campusId:\d+>/<buildingIds:[0-9@,]+><ext:(.svg)?>' => 'sys/wayfinding/generate-campus-map',
    '@mobile'                                                                           => 'sys/app/mobile',
    '@mobile/<mobile:.*>'                                                               => 'sys/app/mobile',
    '@<kioskId:\d+>'                                                                    => 'sys/app/index',
    '@<kioskId:\d+>/<app:.*>'                                                           => 'sys/app/index',
    '<all:.*>'                                                                          => 'sys/app/index',
];
