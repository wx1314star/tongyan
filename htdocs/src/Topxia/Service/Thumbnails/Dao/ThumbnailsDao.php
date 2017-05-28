<?php
namespace Topxia\Service\Thumbnails\Dao;

interface ThumbnailsDao
{
    public function findAll();

    public function getThumbnails($id);

    public function addThumbnails($thumbnails);

    public function deleteThumbnails($id);

    public function updateThumbnails($thumbnails);
}