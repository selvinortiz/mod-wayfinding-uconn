<?php

/**
 * Provide a list of field handles you want to hide for non-admins
 *
 * @note File must be copied to /config as hidden-fields.php
 */
return [
    'contentFields' => [
        'stripeKey',
    ],
    'sidebarFields' => [
        'slug',
        'author',
    ]
];
