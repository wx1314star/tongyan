<?php
namespace Topxia\Service\PayLog;

interface PayLogService
{
//   public function addStudent($id, $student);

  public function getPayLog($id);

  public function updatePayLog($id, $pay_log);

  //public function deleteStudent($id);

  // public function findStudents($school_id);

  // public function findStudentsByTeacher($id);

  // public function findTeachersByIds(array $ids);

  public function findAllPayLog();
}