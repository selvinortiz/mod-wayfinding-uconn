<?php

return [
    'bg' => '#fff',
    'fg' => '#333',
    'font' => [
        'family' => '"Work Sans", sans-serif'
    ],
    'header' => [
        'bg' => [
            'colors' => ['#132455', '#011031'],
            'direction' => 'to bottom'
        ],
        'logo' => [
            'url' => '/img/modcore.png'
        ],
        'clock' => [
            'fg' => '#fff'
        ]
    ],
    'nav' => [
        'fg' => '',
        'bg' => 'white',
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
            'fg' => 'black',
            'active' => [
                'bg' => 'transparent',
                'fg' => 'blue'
            ],
            'class' => 'uppercase',
            'style' => '',
        ]
    ],
    'footer' => [
        'bg' => 'rgba(0, 0, 0, 5)',
        'fg' => 'white'
    ]
];
