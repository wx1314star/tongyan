<?php
namespace Topxia\Service\SchoolAuth;

interface SchoolAuthService
{
    public function findAll($institutionsType);

    public function getSchoolAuthBySchoolId($school_id);

    public function getSchoolAuth($id);

    public function addSchoolAuth($id, $fields);

    public function deleteSchoolAuth($id);

    public function updateSchoolAuth($id, $fields);

}