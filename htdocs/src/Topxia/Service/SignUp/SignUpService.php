<?php
namespace Topxia\Service\SignUp;

interface SignUpService
{
    public function findAll($id);

    public function getSignUp($id);

    public function addSignUp($signUp);

    public function getSignUpByOrderNum($id); 

    public function updateSignUp($signUp);

    public function getSignUpByStuId($id); 
}