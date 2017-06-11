<?php
namespace Topxia\Service\SignUp\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\SignUp\Dao\SignUpDao;

class SignUpDaoImpl extends BaseDao implements SignUpDao
{
    protected $table = 'sign_up_stu';

    public function addSignUp($signUp)
    {
        $affected = $this->getConnection()->insert($this->table, $signUp);
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Insert SignUp error.');
        }

        return $this->getSignUp($this->getConnection()->lastInsertId());

    }

    public function updateSignUp($signUp)
    {
        $affected = $this->getConnection()->update($this->table, $signUp, array('id' => $signUp['id']));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Update signUp error.');
        }

        return $this->getSchool($signUp['id']);
    } 


    public function getSignUp($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    public function getSignUpByStuId($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE student_id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    public function getSignUpByOrderNum($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE orderNum = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    
    public function findAll($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * from {$that->getTable()} where student_id = ? order by createTime desc";
            return $this->getConnection()->fetchAll($sql, array($id)) ? : array();
        }
        );
    }

}
