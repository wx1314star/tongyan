<?php
namespace Topxia\Service\Pay\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\Pay\Dao\PayDao;

class PayDaoImpl extends BaseDao implements PayDao
{
    protected $table = 'pay';
    protected $twoTable = 'pay_log';

    public function addPay($pay, $pay_log)
    {
        $em = $this->getConnection();
        $em->beginTransaction();
        try{
            $pay['payID'] = time().mt_rand(10000,99999);
            $affected = $em->insertNew($this->table, $pay);
            //$this->clearCached();
            $newPay = $em->lastInsertId();
            $pay_log['pay_id'] = $newPay['id'];
            $em->insertNew($this->twoTable, $pay_log);
            
            // if ($affected <= 0) {
            //     throw $this->createDaoException('Insert pay error.');
            // }
            // $em->rollBack();
        }
        catch(Exception $e)
        {
            // $em->rollBack();
        }
       

        //return $this->getPay($this->getConnection()->lastInsertId());

    }

    public function updatePay($id, $pay)
    {
        $affected = $this->getConnection()->update($this->table, $pay, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Update pay error.');
        }

        return $this->getPay($id);
    }

    public function getPay($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    public function getPayByStuId($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE student_id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    public function getPayBySms($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE smsContent = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    public function findAllPay()
    { 
        $sql = "SELECT * FROM {$this->table} where status = 1 ORDER BY createTime DESC LIMIT 10";
        return $this->getConnection()->fetchAll($sql) ? : array();
    }

    public function deletePay($id)
    {
        
    }

    public function findPay($pay_id)
    {
        $that = $this;
        return $this->fetchCached("pay:{$pay_id}", $pay_id, function ($pay_id) use ($that) {
            $sql = "SELECT name,phone,IDcards,reportedCourse,createTime FROM {$this->table} WHERE pay_id = ? ORDER BY createTime LIMIT 10";
            return $this->getConnection()->fetchAll($sql, array($pay_id)) ? : array();
        }
        );
    }

}
