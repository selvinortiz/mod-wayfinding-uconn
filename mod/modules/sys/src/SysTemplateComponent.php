<?php

namespace modules\sys;

class SysTemplateComponent
{
    public function isMobile()
    {
        return (new \Mobile_Detect())->isMobile();
    }
}
