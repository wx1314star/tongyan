<?php
namespace Topxia\Service\City;

interface CityService
{
    public function findAll();

    public function getCityById($city_id);

    public function findCityByProvinceId($province_id);

     public function findCityBySchoolIdOrSchoolAll($city_id);
}