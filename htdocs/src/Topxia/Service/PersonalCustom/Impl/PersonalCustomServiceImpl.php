<?php
namespace Topxia\Service\PersonalCustom\Impl;

use Topxia\Service\PersonalCustom\PersonalCustomService;
use Topxia\Service\Common\BaseService;

class PersonalCustomServiceImpl extends BaseService implements PersonalCustomService
{
    protected function getPersonalCustomDao()
    {
        return $this->createDao('PersonalCustom.PersonalCustomDao');
    }

    public function addPersonalCustom($personals)
    {
        return $this->getPersonalCustomDao().addPersonalCustom($personals);
    }
}
