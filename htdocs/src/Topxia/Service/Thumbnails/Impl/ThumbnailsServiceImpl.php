<?php
namespace Topxia\Service\Thumbnails\Impl;

use Topxia\Service\Thumbnails\ThumbnailsService;
use Topxia\Service\Common\BaseService;

class ThumbnailsServiceImpl extends BaseService implements ThumbnailsService
{
   
    protected function getThumbnailsDao()
    {
        return $this->createDao('Thumbnails.ThumbnailsDao');
    }

    public function findAll()
    {
        return $this->getThumbnailsDao()->findAll();
    }

    public function getThumbnails($id)
    {
        return $this->getThumbnailsDao()->getThumbnails($id);
    }

    public function addThumbnails($thumbnails)
    {
        return $this->getThumbnailsDao()->addThumbnails($thumbnails);
    }

    public function deleteThumbnails($id)
    {
        //return $this->getSchoolsDao()->deleteSchool($id);
        $school = $this->getThumbnailsDao().getThumbnails($id);
        return $this->getThumbnailsDao()->updateThumbnails($id, $school);
    }

    public function updateThumbnails($thumbnails)
    {
        return $this->getThumbnailsDao()->updateThumbnails($thumbnails);
    }
}
