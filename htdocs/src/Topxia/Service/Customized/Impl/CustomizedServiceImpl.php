<?php
namespace Topxia\Service\Customized\Impl;

use Topxia\Service\Customized\CustomizedService;
use Topxia\Service\Common\BaseService;

class CustomizedServiceImpl extends BaseService implements CustomizedService
{
   
    protected function getCustomizedDao()
    {
        return $this->createDao('Customized.CustomizedDao');
    }

    public function findAll()
    {
        return $this->getCustomizedDao()->findAll();
    }

    public function getCustomized($id)
    {
        return $this->getCustomizedDao()->getCustomized($id);
    }

    public function addCustomized($customized)
    {
        $customized['createTime'] = time();
        return $this->getCustomizedDao()->addCustomized($customized);;
    }

    public function deleteCustomized($id, $customized)
    {
        return $this->getCustomizedDao()->deleteCustomized($id, $customized);
    }

    public function updateCustomized($id, $customized)
    {
        return $this->getCustomizedDao()->updateCustomized($id, $customized);
    }

}
