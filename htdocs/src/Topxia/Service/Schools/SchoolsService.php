<?php
namespace Topxia\Service\Schools;

interface SchoolsService
{
    public function findAll($institutionsType);

    public function findAllByNum($number);

    public function findSchoolByNewTime();

    public function findSchoolByCity($city_id);

    public function getSchool($id);

    public function getSchoolByCName($CName);

    public function addSchool($id, $fields);

    public function deleteSchool($id);

    public function updateSchool($id, $fields);
}