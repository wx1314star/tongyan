<?php
namespace Topxia\Service\PayLog\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\PayLog\Dao\PayLogDao;

class PayLogDaoImpl extends BaseDao implements PayLogDao
{
    protected $table = 'pay_log';

    // public function addStudent($id, $student)
    // {
    //     $affected = $this->getConnection()->insert($this->table, $student);
    //     $this->clearCached();

    //     if ($affected <= 0) {
    //         throw $this->createDaoException('Insert pay_log error.');
    //     }

    //     return $this->getStudent($this->getConnection()->lastInsertId());

    // }

    public function updatePayLog($id, $pay_log)
    {
        $affected = $this->getConnection()->update($this->table, $pay_log, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Update school error.');
        }

        return $this->getPayLog($id);
    }

    public function getPayLog($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }


    public function findAllPayLog()
    { 
        $sql = "SELECT * FROM {$this->table} where status = 1 ORDER BY createTime DESC LIMIT 10";
        return $this->getConnection()->fetchAll($sql) ? : array();
    }

}
