<?php
namespace Topxia\Service\WeiXin\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\WeiXin\Dao\WeiXinDao;

class WeiXinDaoImpl extends BaseDao implements WeiXinDao
{
    protected $table = 'weixin';

    // public function addStudent($id, $student)
    // {
    //     $affected = $this->getConnection()->insert($this->table, $student);
    //     $this->clearCached();

    //     if ($affected <= 0) {
    //         throw $this->createDaoException('Insert pay_log error.');
    //     }

    //     return $this->getStudent($this->getConnection()->lastInsertId());

    // }

    public function updateWeiXin($id, $weiXin)
    {
        $affected = $this->getConnection()->update($this->table, $weiXin, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Update weixin error.');
        }

        return $this->getWeiXin($id);
    }

    public function getWeiXin($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }


    public function findAllWeiXin()
    { 
        $sql = "SELECT * FROM {$this->table} LIMIT 1";
        return $this->getConnection()->fetchAll($sql) ? : array();
    }

}
