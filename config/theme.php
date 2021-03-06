<?php

return [
    'bg' => '#fff',
    'fg' => '#333',
    'font' => [
        'family' => '"Work Sans", sans-serif'
    ],
    'header' => [
        'bg' => [
            'colors' => ['#000E2F', '#000E2F'],
            'direction' => 'to bottom'
        ],
        'logo' => [
            'url' => '/static/img/logo-light.svg'
        ],
        'clock' => [
            'fg' => '#fff'
        ]
    ],
    'nav' => [
        'fg' => [],
        'bg' => '#fff',
        'styles' => [],
        'classes' => ['border-t', 'border-gray-300'],
        'links' => [
            ['id' => 'places', 'type' => 'route', 'title' => 'Places', 'route' => 'places', 'icon' => 'places.svg'],
            ['id' => 'people', 'type' => 'route', 'title' => 'People', 'route' => 'people', 'icon' => 'people.svg'],
            ['id' => 'search', 'type' => 'action', 'title' => 'Search', 'icon' => 'search.svg'],
            ['id' => 'service1', 'type' => 'url', 'title' => 'Service One', 'url' => 'https://uconn-test.modolabs.net/myuconn/bus_tracker_transloc/index', 'icon' => 'settings.svg'],
            ['id' => 'service2', 'type' => 'url', 'title' => 'Service Two', 'url' => 'https://uconn-test.modolabs.net/myuconn/bus_tracker_transloc/index', 'icon' => 'settings.svg'],
            ['id' => 'service3', 'type' => 'url', 'title' => 'Service Three', 'url' => 'https://uconn-test.modolabs.net/myuconn/bus_tracker_transloc/index', 'icon' => 'settings.svg']
        ],
        'link' => [
            'bg' => '#fff',
            'fg' => '#000E2F',
            'styles' => [],
            'classes' => ['uppercase'],
            'active' => [
                'bg' => '#eee',
                'fg' => '#666'
            ],
        ]
    ],
    'footer' => [
        'bg' => '#000E2F',
        'fg' => 'white'
    ]
];
