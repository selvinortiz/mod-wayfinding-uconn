<?php

namespace modules\sys\services;

use craft\base\Component;
use craft\helpers\Template;
use function modules\sys\sys;
use yii\base\Exception;

/**
 * Class SvgService
 *
 * @package modules\sys\services
 */
class SvgService extends Component
{
    /**
     * @param string $image   Image path (file or URL)
     * @param array  $markers List of individual xy coordinates
     *
     * @return string
     * @throws Exception
     */
    public function fromImage($image, array $markers = [], int $width = null, int $height = null)
    {
        try
        {
            // Turn marker xy coordinates into SVG circles
            if (!empty($markers))
            {
                $markers = array_map(
                    function($marker) {
                        return sys()->renderTemplate('_marker', $marker);
                    },
                    $markers
                );
            }

            if (!$width || !$height)
            {
                list($width, $height) = getimagesize($image);
            }

            return sys()->renderTemplate(
                '_svg',
                [
                    'width'   => $width,
                    'height'  => $height,
                    'image'   => base64_encode(file_get_contents($image)),
                    'content' => Template::raw(implode(PHP_EOL, $markers))
                ]
            );
        }
        catch (\Throwable $e)
        {
            throw new Exception($e->getMessage());
        }
    }

    /**
     * @param string $svg
     * @param array  $markers
     *
     * @return string
     * @throws Exception
     */
    public function fromSvg($svg, array $markers = [])
    {
        try
        {
            // Turn marker xy coordinates into SVG circles
            if (!empty($markers))
            {
                $markers = array_map(
                    function($marker) {
                        return sys()->renderTemplate('_marker', $marker);
                    },
                    $markers
                );
            }

            $svgContent = file_get_contents($svg);
            $append     = implode(PHP_EOL, $markers);

            return str_replace('</svg>', $append.'</svg>', $svgContent);
        }
        catch (\Throwable $e)
        {
            throw new Exception($e->getMessage());
        }
    }
}
