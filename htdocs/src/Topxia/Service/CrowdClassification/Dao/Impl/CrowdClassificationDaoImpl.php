<?php
namespace Topxia\Service\CrowdClassification\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\CrowdClassification\Dao\CrowdClassificationDao;

class CrowdClassificationDaoImpl extends BaseDao implements CrowdClassificationDao
{
    protected $table = 'crowd_classification';

    public function findAll()
    {
        $sql = "SELECT * FROM {$this->table} LIMIT 10";
        return $this->getConnection()->fetchAll($sql) ? : array();
    }

     public function getCrowdClassification($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? AND status = 1 LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    public function addCrowdClassification($crowd_classification)
    {
        $affected = $this->getConnection()->insert($this->table, $crowd_classification);
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Insert school error.');
        }

        return $this->getSchool($this->getConnection()->lastInsertId());
    }

    public function deleteCrowdClassification($id)
    {
        $affected = $this->getConnection()->delete($this->table, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Delete school error.');
        }

        return $affected;
        
    }

    public function updateCrowdClassification($id, $school)
    {
        $affected = $this->getConnection()->update($this->table, $school, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Update school error.');
        }

        return $this->getSchool($id);
    } 
}
