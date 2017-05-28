<?php
namespace Topxia\Service\Province\Dao;

interface ProvinceDao
{
    public function findAll();

    public function getProvince($id);
}