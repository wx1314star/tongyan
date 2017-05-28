<?php
namespace Topxia\Service\City\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\City\Dao\CityDao;

class CityDaoImpl extends BaseDao implements CityDao
{
    protected $table = 'city';

    public function findAll()
    {
        $sql = "SELECT * FROM {$this->table}";
        return $this->getConnection()->fetchAll($sql) ? : array();
    }

    public function getCityById($city_id)
    {
        $that = $this;
        return $this->fetchCached("id:{$city_id}", $city_id, function ($city_id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($city_id)) ?: null;
        }
        );
    }

    public function findCityByProvinceId($province_id)
    {
        $that = $this;
        return $this->fetchCached("province_id:{$province_id}", $province_id, function ($province_id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE province_id = ?";
            return $that->getConnection()->fetchAll($sql, array($province_id)) ?: null;
        }
        );
    }

    public function findCityBySchoolIdOrSchoolAll($city_id)
    {
        $that = $this;
        if($city_id != null){
                return $this->fetchCached("city_id:{$city_id}", $city_id, function ($city_id) use ($that) {
                $sql = "SELECT id,name FROM {$that->getTable()} WHERE id in(SELECT city_id FROM schools WHERE city_id = ? GROUP BY city_id)";
                return $that->getConnection()->fetchAll($sql, array($city_id)) ?: null;
                }
            );
        }else{
                return $this->fetchCached("city_id:{$city_id}", $city_id, function ($city_id) use ($that) {
                $sql = "SELECT id,name FROM {$that->getTable()} WHERE id in(SELECT city_id FROM schools GROUP BY city_id)";
                return $that->getConnection()->fetchAll($sql) ?: null;
                }
            );
        }
    }


}
