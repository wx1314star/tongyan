<?php
namespace Topxia\Service\Students\Impl;

use Topxia\Service\Students\StudentsService;
use Topxia\Service\Common\BaseService;

class StudentsServiceImpl extends BaseService implements StudentsService
{
    protected function getStudentsDao()
    {
        return $this->createDao('Students.StudentsDao');
    }

    public function addStudent($id, $student)
    {
        $students = array();
        
        /*$time = strtotime('2010-03-24 08:15:42');
 
        $date =  date('Y-m-d H:i:s');
        $time = strtotime($date);*/

        $students['name']     =   empty($student['name'])?'':$student['name'];
        $students['nation']     =   empty($student['nation'])?'':$student['nation'];
        $students['birthday']     =   empty($student['birthday'])?0:strtotime($student['birthday']);
        $students['height']     =   empty($student['height'])?'':$student['height'];
        $students['weight']     =   empty($student['weight'])?'':$student['weight'];
        $students['phone']     =   empty($student['phone'])?'':$student['phone'];
        $students['IDcards']     =   empty($student['IDcards'])?'':$student['IDcards'];
        $students['graduateSchool']     =   empty($student['graduateSchool'])?'':$student['graduateSchool'];
        $students['admissionTickerNum']     =   empty($student['admissionTickerNum'])?'':$student['admissionTickerNum'];
        $students['graduationTestScore']     =   empty($student['graduationTestScore'])?'':$student['graduationTestScore'];
        $students['address']     =   empty($student['address'])?'':$student['address'];
        $students['guardianName']     =   empty($student['guardianName'])?'':$student['guardianName'];
        $students['guardianPhone']     =   empty($student['guardianPhone'])?'':$student['guardianPhone'];
        $students['reportedSchool']     =   empty($student['reportedSchool'])?0:$student['reportedSchool'];
        $students['reportedCourse']     =   empty($student['reportedCourse'])?0:$student['reportedCourse'];
        $students['school_id']     =   $id;
        $students['status']     =   empty($student['status'])? 0:$student['status'];
        $students['recommendTeacher']     =   empty($student['recommendTeacher'])? 0:$student['recommendTeacher'];
        $students['userId']     =   empty($student['userId'])? 0:$student['userId'];
        $students['courseId']     =   empty($student['courseId'])? 0:$student['courseId'];
        $students['createTime'] = time();
       
        return $this->getStudentsDao()->addStudent($id, $students);
    }

    public function updateStudent($id, $student)
    {
        $students = array();

        $students['name']     =   empty($student['name'])?'':$student['name'];
        $students['nation']     =   empty($student['nation'])?'':$student['nation'];
        $students['birthday']     =   empty($student['birthday'])?'':strtotime($student['birthday']);
        $students['height']     =   empty($student['height'])?'':$student['height'];
        $students['weight']     =   empty($student['weight'])?'':$student['weight'];
        $students['phone']     =   empty($student['phone'])?'':$student['phone'];
        $students['IDcards']     =   empty($student['IDcards'])?'':$student['IDcards'];
        $students['graduateSchool']     =   empty($student['graduateSchool'])?'':$student['graduateSchool'];
        $students['admissionTickerNum']     =   empty($student['admissionTickerNum'])?'':$student['admissionTickerNum'];
        $students['graduationTestScore']     =   empty($student['graduationTestScore'])?'':$student['graduationTestScore'];
        $students['address']     =   empty($student['address'])?'':$student['address'];
        $students['guardianName']     =   empty($student['guardianName'])?'':$student['guardianName'];
        $students['guardianPhone']     =   empty($student['guardianPhone'])?'':$student['guardianPhone'];
        $students['reportedSchool']     =   empty($student['reportedSchool'])?0:$student['reportedSchool'];
        $students['reportedCourse']     =   empty($student['reportedCourse'])?0:$student['reportedCourse'];
        $students['school_id']     =   $id;
        $students['recommendTeacher']     =   empty($student['recommendTeacher'])? 0:$student['recommendTeacher'];
        $students['userId']     =   empty($student['userId'])? 0:$student['userId'];
        $students['courseId']     =   empty($student['courseId'])? 0:$student['courseId'];
        $students['status']     =   empty($student['status'])? 0:$student['status'];
        $students['updateTime'] = time();
       
        return $this->getStudentsDao()->updateStudent($id, $students);
    }

    public function deleteStudent($id)
    {
        //return $this->getSchoolsDao()->deleteSchool($id);
        $student = $this->getStudentsDao().getStudent($id);
        $student['status']                = empty($fields['status']) ? 0 : $fields['status'];
        return $this->getStudentsDao()->updateStudent($id, $school);

    }

    public function getStudent($id)
    {
        return $this->getStudentsDao()->getStudent($id);
    }

    public function getStudentByUserId($id)
    {
        return $this->getStudentsDao()->getStudentByUserId($id);
    }

    public function findStudents($school_id)
    {
        return $this->getStudentsDao()->findStudents($school_id);
    }

    public function findStudentsByTeacher($id)
    {
        return $this->getStudentsDao()->findStudentsByTeacher($id);
    }

    public function findTeachersByIds(array $ids)
    {
        return $this->getStudentsDao()->findTeachersByIds($ids);
    }

}
