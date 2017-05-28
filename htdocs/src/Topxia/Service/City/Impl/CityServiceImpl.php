<?php
namespace Topxia\Service\City\Impl;

use Topxia\Service\City\CityService;
use Topxia\Service\Common\BaseService;

class CityServiceImpl extends BaseService implements CityService
{
    protected function getCityDao()
    {
        return $this->createDao('City.CityDao');
    }

    public function findAll()
    {
        return $this->getCityDao()->findAll();
    }

    public function getCityById($city_id)
    {
        return $this->getCityDao()->getCityById($city_id);
    }

    public function findCityByProvinceId($province_id)
    {
        return $this->getCityDao()->findCityByProvinceId($province_id);
    }

     public function findCityBySchoolIdOrSchoolAll($city_id)
     {
         return $this->getCityDao()->findCityBySchoolIdOrSchoolAll($city_id);
     }
}
