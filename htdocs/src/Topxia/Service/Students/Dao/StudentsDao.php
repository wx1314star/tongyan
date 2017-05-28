<?php
namespace Topxia\Service\Students\Dao;

interface StudentsDao
{
  public function addStudent($id, $student);

  public function getStudent($id);

  public function getStudentByUserId($id);

  public function updateStudent($id, $student);

  public function deleteStudent($id);

  public function findStudents($school_id);

  public function findStudentsByTeacher($id);

  public function findTeachersByIds(array $ids);
}