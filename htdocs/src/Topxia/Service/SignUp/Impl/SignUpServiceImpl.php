<?php
namespace Topxia\Service\SignUp\Impl;

use Topxia\Service\SignUp\SignUpService;
use Topxia\Service\Common\BaseService;

class SignUpServiceImpl extends BaseService implements SignUpService
{
   
    protected function getSignUpDao()
    {
        return $this->createDao('SignUp.SignUpDao');
    }

    public function findAll($id)
    {
        return $this->getSignUpDao()->findAll($id);
    }

    public function getSignUp($id)
    {
        return $this->getSignUpDao()->getSignUp($id);
    }

    public function addSignUp($signUp)
    {
        return $this->getSignUpDao()->addSignUp($signUp);
    }

    public function updateSignUp($signUp)
    {
        return $this->getSignUpDao()->updateSignUp($signUp);
    }

    public function getSignUpByOrderNum($id)
    {
        return $this->getSignUpDao()->getSignUpByOrderNum($id);
    }

    public function getSignUpByStuId($id)
    {
        return $this->getSignUpDao()->getSignUpByStuId($id);
    }
}
