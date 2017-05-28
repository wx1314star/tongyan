<?php
namespace Topxia\Service\Level;

interface LevelService
{
    public function findAll();

    public function getLevel($id);

    public function addLevel($level);

    public function deleteLevel($id, $level);

    public function updateLevel($id, $level);

    public function getTagByLikeName($name);
}