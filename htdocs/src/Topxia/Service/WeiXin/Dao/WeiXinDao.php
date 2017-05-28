<?php
namespace Topxia\Service\WeiXin\Dao;

interface WeiXinDao
{
  //public function addStudent($id, $student);

  public function getWeiXin($id);

  public function updateWeiXin($id, $weixin);

  //public function deleteStudent($id);

  // public function findStudents($school_id);

  // public function findStudentsByTeacher($id);

  // public function findTeachersByIds(array $ids);

  public function findAllWeiXin();
}