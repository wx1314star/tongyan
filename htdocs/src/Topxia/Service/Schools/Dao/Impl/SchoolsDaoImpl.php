<?php
namespace Topxia\Service\Schools\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\Schools\Dao\SchoolsDao;

class SchoolsDaoImpl extends BaseDao implements SchoolsDao
{
    protected $table = 'schools';

    /*根据学校类型查询学校(0,学校;1,培训机构)*/
    public function findAll($institutionsType)
    {
        $that = $this;
        return $this->fetchCached("institutionsType:{$institutionsType}", $institutionsType, function ($institutionsType) use ($that) {
            $sql = "SELECT * FROM {$this->table} WHERE institutionsType = ? LIMIT 10";
            return $this->getConnection()->fetchAll($sql, array($institutionsType)) ? : array();
        }
        );
    }

    public function findAllByNum($number)
    {
            $sql = "SELECT * FROM {$this->table} LIMIT {$number}";
            return $this->getConnection()->fetchAll($sql, array($number)) ? : array();  
    }

    /*首页加载根据最新的时间显示4所学校或机构*/
    public function findSchoolByNewTime()
    { 
        $sql = "SELECT id,logo FROM {$this->table} where status = 0 ORDER BY createTime DESC LIMIT 4";
        return $this->getConnection()->fetchAll($sql) ? : array();
    }

    /*根据市表ID查询学校列表*/
    public function findSchoolByCity($city_id)
    {
        $that = $this;
        return $this->fetchCached("city_id:{$city_id}", $city_id, function ($city_id) use ($that) {
            $sql = "SELECT * FROM {$this->table} WHERE city_id = ? LIMIT 4";
            return $this->getConnection()->fetchAll($sql, array($city_id)) ? : array();
        }
        );
    }

    public function getSchool($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    public function getSchoolByCName($CName)
    {
        $that = $this;

        return $this->fetchCached("CName:{$CName}", $CName, function ($CName) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE chineseName = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($CName));
        }

        );
    }

    public function addSchool($school)
    {
        $affected = $this->getConnection()->insert($this->table, $school);
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Insert school error.');
        }

        return $this->getSchool($this->getConnection()->lastInsertId());
    }

    public function deleteSchool($id)
    {
        $affected = $this->getConnection()->delete($this->table, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Delete school error.');
        }

        return $affected;
        
    }

    public function updateSchool($id, $school)
    {
        $affected = $this->getConnection()->update($this->table, $school, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Update school error.');
        }

        return $this->getSchool($id);
    } 
}
