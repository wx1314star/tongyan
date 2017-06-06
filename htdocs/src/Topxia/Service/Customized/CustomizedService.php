<?php
namespace Topxia\Service\Customized;

interface CustomizedService
{
    public function findAll();

    public function getCustomized($id);

    public function addCustomized($customized);

    public function deleteCustomized($id, $customized);

    public function updateCustomized($id, $customized);

}