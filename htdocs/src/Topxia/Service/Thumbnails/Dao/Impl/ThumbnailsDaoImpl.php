<?php
namespace Topxia\Service\Thumbnails\Dao\Impl;

use Topxia\Service\Common\BaseDao;
use Topxia\Service\Thumbnails\Dao\ThumbnailsDao;

class ThumbnailsDaoImpl extends BaseDao implements ThumbnailsDao
{
    protected $table = 'thumbnails';

    public function findAll()
    {
        $sql = "SELECT * FROM {$this->table} LIMIT 1";
        return $this->getConnection()->fetchAll($sql, array());
        
    }

    public function getThumbnails($id)
    {
        $that = $this;
        return $this->fetchCached("id:{$id}", $id, function ($id) use ($that) {
            $sql = "SELECT * FROM {$that->getTable()} WHERE id = ? LIMIT 1";
            return $that->getConnection()->fetchAssoc($sql, array($id)) ?: null;
        }
        );
    }

    public function addThumbnails($thumbnails)
    {
        $affected = $this->getConnection()->insert($this->table, $thumbnails);
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Insert thumbnails error.');
        }

        return 1;
    }

    public function deleteThumbnails($id)
    {
        $affected = $this->getConnection()->delete($this->table, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Delete thumbnails error.');
        }

        return $affected;
        
    }

    public function updateThumbnails($id, $thumbnails)
    {
        $affected = $this->getConnection()->update($this->table, $thumbnails, array('id' => $id));
        $this->clearCached();

        if ($affected <= 0) {
            throw $this->createDaoException('Update thumbnails error.');
        }

        return $affected;
    } 
}
