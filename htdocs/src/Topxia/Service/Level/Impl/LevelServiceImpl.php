<?php
namespace Topxia\Service\Level\Impl;

use Topxia\Service\Level\LevelService;
use Topxia\Service\Common\BaseService;

class LevelServiceImpl extends BaseService implements LevelService
{
   
    protected function getLevelDao()
    {
        return $this->createDao('Level.LevelDao');
    }

    public function findAll()
    {
        return $this->getLevelDao()->findAll();
    }

    public function getLevel($id)
    {
        return $this->getLevelDao()->getLevel($id);
    }

    public function addLevel($level)
    {
        return $this->getLevelDao()->addLevel($level);;
    }

    public function deleteLevel($id, $level)
    {
        //return $this->getSchoolsDao()->deleteSchool($id);
        $level = $this->getLevelDao()->getLevel($id);
      
        return $this->getLevelDao()->deleteLevel($id, $level);

    }

    public function updateLevel($id, $level)
    {
        return $this->getLevelDao()->updateLevel($id, $level);
    }

    public function getTagByLikeName($name)
    {
        return $this->getLevelDao()->getTagByLikeName($name);
    }
}
