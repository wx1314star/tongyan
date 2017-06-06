<?php
namespace Topxia\Service\Customized\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\Customized\Dao\CustomizedDao;

class CustomizedDaoImpl extends BaseDao implements CustomizedDao
{
    protected $table = 'customized';

    public function addCustomized($customized)
    {
        $affected = $this->getConnection()->insert($this->table, $customized);
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Insert customized error.');
        }

        return $this->getCustomized($this->getConnection()->lastInsertId());

    }

    public function updateCustomized($id, $customized)
    {
        $affected = $this->getConnection()->update($this->table, $customized, array('id' => $id));
        $this->clearCached();

        // if ($affected <= 0) {
        //     throw $this->createDaoException('Update level error.');
        // }

        return $affected;
    }

    public function getCustomized($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    public function deleteCustomized($id, $customized)
    {
        $affected = $this->getConnection()->delete($this->table, $customized, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Delete customized error.');
        }

        return $affected;
    }

    public function findAll()
    {
        $that = $this;
        $sql = "SELECT * FROM {$that->getTable()} ORDER BY createTime DESC LIMIT 20";
        return $this->getConnection()->fetchAll($sql) ? : array();
        
    }

}
