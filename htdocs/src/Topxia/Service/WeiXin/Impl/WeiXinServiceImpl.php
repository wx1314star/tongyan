<?php
namespace Topxia\Service\WeiXin\Impl;

use Topxia\Service\WeiXin\WeiXinService;
use Topxia\Service\Common\BaseService;

class WeiXinServiceImpl extends BaseService implements WeiXinService
{
    
    // public function addPayLog($id, $student)
    // {  
    //     return $this->getPayLogDao()->addStudent($id, $students);
    // }

    public function updateWeiXin($id, $weixin)
    {
        return $this->getWeiXinDao()->updateWeiXin($id, $weixin);
    }

    // public function deleteStudent($id)
    // {
    //     //return $this->getSchoolsDao()->deleteSchool($id);
    //     $student = $this->getStudentsDao().getStudent($id);
    //     $student['status']                = empty($fields['status']) ? 0 : $fields['status'];
    //     return $this->getStudentsDao()->updateStudent($id, $school);

    // }

    public function getWeiXin($id)
    {
         return $this->getWeiXinDao()->getWeiXin($id);
    }

    public function findAllWeiXin()
    {
        return $this->getWeiXinDao()->findAllWeiXin();
    }

    public function getWeiXinDao()
    {
        return $this->createDao('WeiXin.WeiXinDao');
    }

}
