<?php
namespace Topxia\Service\PayLog\Impl;

use Topxia\Service\PayLog\PayLogService;
use Topxia\Service\Common\BaseService;

class PayLogServiceImpl extends BaseService implements PayLogService
{
    

    // public function addPayLog($id, $student)
    // {  
    //     return $this->getPayLogDao()->addStudent($id, $students);
    // }

    public function updatePayLog($id, $pay_log)
    {
        return $this->getPayLogDao()->updatePayLog($id, $pay_log);
    }

    // public function deleteStudent($id)
    // {
    //     //return $this->getSchoolsDao()->deleteSchool($id);
    //     $student = $this->getStudentsDao().getStudent($id);
    //     $student['status']                = empty($fields['status']) ? 0 : $fields['status'];
    //     return $this->getStudentsDao()->updateStudent($id, $school);

    // }

    public function getPayLog($id)
    {
         return $this->getPayLogDao()->getPayLog($id);
    }

    public function findAllPayLog()
    {
        return $this->getPayLogDao()->findAllPayLog();
    }

    public function getPayLogDao()
    {
        return $this->createDao('PayLog.PayLogDao');
    }

}
