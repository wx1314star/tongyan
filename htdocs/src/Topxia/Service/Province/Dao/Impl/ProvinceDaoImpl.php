<?php
namespace Topxia\Service\Province\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\Province\Dao\ProvinceDao;

class ProvinceDaoImpl extends BaseDao implements ProvinceDao
{
    protected $table = 'province';

    public function findAll()
    {
        $sql = "SELECT * FROM {$this->table}";
        return $this->getConnection()->fetchAll($sql) ? : array();
    }

    public function getProvince($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }
}
