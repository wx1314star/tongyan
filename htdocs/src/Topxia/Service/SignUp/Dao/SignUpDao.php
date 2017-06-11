<?php
namespace Topxia\Service\SignUp\Dao;

interface SignUpDao
{
    public function findAll($id);

    public function getSignUp($id);

    public function addSignUp($signUp);

    public function getSignUpByOrderNum($id);

    public function updateSignUp($signUp);

    public function getSignUpByStuId($id);  
}