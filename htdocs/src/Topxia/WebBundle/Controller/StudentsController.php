<?php
namespace Topxia\WebBundle\Controller;

use Symfony\Component\HttpFoundation\Request;
use Topxia\Common\AuthenticationToolkit;
use Topxia\Common\SmsToolkit;
use Topxia\Common\WeiXin\WeiXinToolkit;
use Topxia\Common\WeiXin\QrcodeToolkit;

class StudentsController extends BaseController
{
    public function addStudentAction(Request $request, $id)
    {
         $user = $this->getCurrentUser();
         if ($request->getMethod() == 'POST') {
            // 先获得EntityManager再开启事务,而且必须要在控制器里才能使用
            //$em = $this->getDoctrine()->getManager();
            // 关闭自动提交
            //$em->getConnection()->setAutoCommit(false);
            // 开启事务
            //$em->getConnection()->beginTransaction();
            try
            {
                $student = $request->request->get('student');
                $payment = $request->request->get('payment');
                
                // $value = $request->request->get('reportedCourse');
                // if (!empty($value)) {
                //     foreach ($value as $key => $va) {
                //         $student['reportedCourse'] = (int)$va;
                //         $this->getStudentsService()->addStudent($student['school_id'], $student);
                //     }
                // }
                //$birthday = date("Y-m-d", $student['birthday']);

                // $newStudent = $this->getStudentsService()->addStudent($student['school_id'], $student);
                // $course = $this->getCourseService()->getCourse($student['reportedCourse']);
                

                // $pay = array(
                //     'student_id'  => $newStudent['id'],
                //     'course_id'   => $course['id'],
                //     'studentName' => $student['name'],
                //     'courseCost'  => $course['price'],
                //     'payment'     => $payment,
                //     'createDate'  => time()
                // );
            
                // $pay_log = array(
                //     'student_id'  => $newStudent['id'],
                //     'school_id'   => $student['school_id'],
                //     'user_id'     => $user['id'],
                //     'createDate'  => time()
                // );
                // $this->getPayService()->addPay($pay, $pay_log);

                // 释放
                // $em->flush();
                // 提交
                //$em->getConnection()->commit();
                //throw new Exception("Value must be 1 or below");
                //$em->getConnection()->rollback();
                //$this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息保存成功。'));
            }
            catch(Exception $e)
            {
                // 回滚
                //$em->getConnection()->rollback();
                // 关闭
                //$em->close();
                //throw $e;
            }
            // 关闭
            //$em->close();
            $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息保存成功。'));
            switch ($payment)
            {
                case 1:
                    return $this->redirect($this->generateUrl('homepage'));
                break;  
                case 2:
                    // return $this->redirect($this->generateUrl('student_pay', array('id' => $newStudent['id'])));
                    return $this->redirect($this->generateUrl('student_pay', array('id' => 25)));
                break;
                case 3:
                    return $this->redirect($this->generateUrl('student_pay', array('id' => $newStudent['id'])));
                break;
                default:
                    return $this->redirect($this->generateUrl('homepage'));
                break;
            }
            
        }

        /*身份验证接口，填身份证号码和真实姓名*/
        //$status = AuthenticationToolkit::auth('xxxxxxxxxxxx','xx');
        /*短信接口,填写电话号码和内容*/
        //$status = SmsToolkit::sendSMS('xxxxxxxxxxx','您已报名成功');
        if ($user->isLogin()) {
             $school = $this->getSchoolsService()->getSchool($id);
             $student = $this->getStudentsService()->findStudents($school['id']);
             //  跳转到个人用户
             if($student != null)
             {
                
             }
             /*查询招生老师*/
            //  $teacher = $this->getUserService()->findUserBySchoolId($id);
            //  if($teacher == null)
            //  {
            //      /*查询所有学校招生老师*/
            //      $teacher = $this->getUserService()->findUserBySchoolId(0);
            //  }
             $flag = 1;
             if(null != $school['institutionsType'] && $school['institutionsType'] == 0){
                $flag = 1;
             }else if(null != $school['institutionsType'] && $school['institutionsType'] == 1){
                $flag = 2;
             }
             $userId = $user['id'];
             $userProfile = $this->getUserService()->getUserProfile($userId);
             $conditions = array();
             $conditions['status'] = 'published';
             $conditions['parentId'] = 0;
             $conditions['school_id'] = $id;
             $arguments = array();
             $arguments['count'] = 12;
             $arguments['categoryId'] = 0;
             $arguments['school_id'] = $id; 
             /*课程*/
             $courses = $this->getCourseService()->searchCourses($conditions,'latest', 0, $arguments['count']);

             //$course = $this->getCoursesService()->findCoursesBySchoolId($id);

             //$schools = $this->getSchoolsService()->findAll(0);

            return $this->render('TopxiaWebBundle:Student:add-student.html.twig', array(
                'school_id' => $id,
                'school' => $school,
                // 'teacher' => $teacher,
                'courses' => $courses,
                'userProfile' => $userProfile,
                'user' => $user,
                'flag' => $flag
                ));
        }else{
            return $this->redirect($this->generateUrl('login_background'));
        } 
    }

    public function studentPayAction(Request $request, $id)
    {
        if ($request->getMethod() == 'POST') {
             return $this->redirect($this->generateUrl('student_pay_suc', array('id' => $id)));
        }
        $pay = $this->getPayService()->getPay($id);
        return $this->render('TopxiaWebBundle:Student:winxin_payList.html.twig', array(
                'pay' => $pay
                ));
        
    }

    public function studentPaySucAction(Request $request, $id)
    {
        $pay = $this->getPayService()->getPay($id);
        $url1 = WeiXinToolkit::initial();
        //$url2 = QrcodeToolkit::init($url1);
        //$host = $_SERVER['REMOTE_ADDR'];
        return $this->render('TopxiaWebBundle:Student:winxin_paySuc.html.twig', array(
                'pay'   => $pay,
                'url1' => $url1
                //'url2' => QrcodeToolkit::init($url1)
                //'host' => $host
                ));
    }

    public function updateStudentAction(Request $request, $id)
    {
        if ($request->getMethod() == 'POST') {
            $student = $request->request->get('student');

            $this->getStudentsService()->updateStudent($id, $student);
          
            $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息更新成功。'));
             
            return $this->redirect($this->generateUrl('homepage'));
        }

        $student = $this->getStudentsService()->getStudent($id);
        if($student['city_id'] != null){
            //城市
            $city = $this->getCityService()->getCityById($school['city_id']);
        }
        if($student['birthday']!=null){
            $birthday =  date("Y-m-d", $student['birthday']);
        }

       
        return $this->render('TopxiaWebBundle:Student:update-student.html.twig', array(
            'city' => $city,
            'student' => $student,
            'birthday' => $birthday
            ));
    }


    protected function getSchoolsService()
    {
        return $this->getServiceKernel()->createService('Schools.SchoolsService');
    }

    protected function getStudentsService()
    {
        return $this->getServiceKernel()->createService('Students.StudentsService');
    }

    protected function getCourseService()
    {
        return $this->getServiceKernel()->createService('Course.CourseService');
    }

    protected function getUserService()
    {
        return $this->getServiceKernel()->createService('User.UserService');
    }

    protected function getPayService()
    {
        return $this->getServiceKernel()->createService('Pay.PayService');
    }

}
