<?php
namespace Topxia\Service\Level\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\Level\Dao\LevelDao;

class LevelDaoImpl extends BaseDao implements LevelDao
{
    protected $table = 'level';

    public function addLevel($level)
    {
        $affected = $this->getConnection()->insert($this->table, $level);
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Insert level error.');
        }

        return $this->getLevel($this->getConnection()->lastInsertId());

    }

    public function updateLevel($id, $level)
    {
        $affected = $this->getConnection()->update($this->table, $level, array('id' => $id));
        $this->clearCached();

        // if ($affected <= 0) {
        //     throw $this->createDaoException('Update level error.');
        // }

        return $this->getLevel($id);
    }

    public function getLevel($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    public function getTagByLikeName($name)
    {
        $name = "%{$name}%";
        $sql  = "SELECT * FROM {$this->table} WHERE name LIKE ?";
        return $this->getConnection()->fetchAll($sql, array($name));
    }

    public function deleteLevel($id, $level)
    {
        $affected = $this->getConnection()->delete($this->table, $level, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Delete level error.');
        }

        return 1;
    }

    public function findAll()
    {
        $that = $this;
        $sql = "SELECT * from {$that->getTable()} order by next";
        return $this->getConnection()->fetchAll($sql) ? : array();
        
    }

}
