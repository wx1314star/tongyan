<?php
namespace Topxia\Service\SchoolAuth\Dao;

interface SchoolAuthDao
{
    public function findAll($institutionsType);

    public function getSchoolAuthBySchoolId($school_id);

    public function getSchoolAuth($id);

    public function addSchoolAuth($fields);

    public function deleteSchoolAuth($id);

    public function updateSchoolAuth($id, $fields);

}