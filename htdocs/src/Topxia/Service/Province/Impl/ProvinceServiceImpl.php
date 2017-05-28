<?php
namespace Topxia\Service\Province\Impl;

use Topxia\Service\Province\ProvinceService;
use Topxia\Service\Common\BaseService;

class ProvinceServiceImpl extends BaseService implements ProvinceService
{
    protected function getProvinceDao()
    {
        return $this->createDao('Province.ProvinceDao');
    }

    public function findAll()
    {
        return $this->getProvinceDao()->findAll();
    }

    public function getProvince($id)
    {
        return $this->getProvinceDao()->getProvince($id);
    }
}
