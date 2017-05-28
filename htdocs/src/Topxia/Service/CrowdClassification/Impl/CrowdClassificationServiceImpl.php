<?php
namespace Topxia\Service\CrowdClassification\Impl;

use Topxia\Service\CrowdClassification\CrowdClassificationService;
use Topxia\Service\Common\BaseService;

class CrowdClassificationServiceImpl extends BaseService implements CrowdClassificationService
{
    protected function getCrowdClassificationDao()
    {
        return $this->createDao('CrowdClassification.CrowdClassificationDao');
    }

    public function findAll()
    {
        return $this->getCrowdClassificationDao()->findAll();
    }

    
}
