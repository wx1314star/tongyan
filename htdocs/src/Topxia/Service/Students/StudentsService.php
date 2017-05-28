<?php
namespace Topxia\Service\Students;

interface StudentsService
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