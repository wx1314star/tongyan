<?php
namespace Topxia\Service\SchoolAuth\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\SchoolAuth\Dao\SchoolAuthDao;

class SchoolAuthDaoImpl extends BaseDao implements SchoolAuthDao
{
    protected $table = 'school_authentication';

    /*根据学校类型查询学校认证表(0,学校;1,培训机构)*/
     public function findAll($institutionsType)
     {
        $that = $this;
        return $this->fetchCached("institutionsType:{$institutionsType}", $institutionsType, function ($institutionsType) use ($that) {
            $sql = "SELECT * FROM {$this->table} WHERE type = ? LIMIT 10";
            return $this->getConnection()->fetchAll($sql, array($institutionsType)) ? : array();
        }
        );
     }

    /*根据学校ID查询学校认证表*/
    public function getSchoolAuthBySchoolId($school_id)
    {
        $that = $this;
        return $this->fetchCached("school_id:{$school_id}", $school_id, function ($school_id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE school_id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($school_id)) ?: null;
        }
        );
    }

    public function getSchoolAuth($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    public function addSchoolAuth($fields)
    {
        $affected = $this->getConnection()->insert($this->table, $fields);
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Insert school_auth error.');
        }

        return $this->getSchoolAuth($this->getConnection()->lastInsertId());
    }

    public function deleteSchoolAuth($id)
    {
        $affected = $this->getConnection()->delete($this->table, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Delete school_auth error.');
        }

        return $affected;
        
    }

    public function updateSchoolAuth($id, $fields)
    {
        $affected = $this->getConnection()->update($this->table, $fields, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Update school_auth error.');
        }

        return $this->getSchoolAuth($id);
    }

}