<?php
namespace Topxia\Service\PersonalCustom\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\PersonalCustom\Dao\PersonalCustomDao;

class PersonalCustomDaoImpl extends BaseDao implements PersonalCustomDao
{
    protected $table = 'personal_custom';

    public function addPersonalCustom($personals)
    {
        $affected = $this->getConnection()->insert($this->table, $personals);
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Insert personal_custom error.');
        }

        return $this->getSchool($this->getConnection()->lastInsertId());
    }
}
