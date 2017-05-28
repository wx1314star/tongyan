<?php

namespace Topxia\WebBundle\Controller;

use Topxia\Common\Paginator;
use Topxia\Common\ArrayToolkit;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Topxia\Service\Defaults\Impl\DefaultsServiceImpl;
use Topxia\Service\Schools\Impl\SchoolsServiceImpl;
use Symfony\Component\HttpFoundation\RedirectResponse;

class DefaultController extends BaseController
{
    public function indexAction(Request $request)
    {
        $user = $this->getCurrentUser();
        /*加service*/
        //培训机构
        //$crowd_classification = $this->getCrowdClassificationService()->findAll();
        //学校0,培训机构1
        //$school = $this->getSchoolsService()->findAll(0);

        //首页课程分类
        $list = $this->getLevelService()->findAll();

        // 首页缩略图
        $thumbnails = $this->getThumbnailsService()->findAll();

        //学校推荐
        $school = $this->getSchoolsService()->findSchoolByNewTime();

        $citys = $this->getCityService()->findCityBySchoolIdOrSchoolAll(null);

        //获得默认初中生课程方法(学历文凭)
        $PCcourses = $this->getCourseService()->findCoursesByPopulationClassify(0);
        //获得课程方法
        $VScourses = $this->getCourseService()->findCoursesByPopulationClassify(1);
        //获得课程方法
        $SAcourses = $this->getCourseService()->findCoursesByPopulationClassify(2);
        //获得课程方法
        $Tucourses = $this->getCourseService()->findCoursesByPopulationClassify(3);

        //获得默认推荐根据课程创建时间显示方法
        $DFcourses = $this->getCourseService()->findCoursesByTime();

        //首页学校资讯
        $categoryIds = array(1);
        $start = 0;
        $limit = 5;
        $SCarticle = $this->getArticleService()->findArticlesByCategoryIds($categoryIds, $start, $limit);

        $categoryIds = array(2);
        $TYarticle = $this->getArticleService()->findArticlesByCategoryIds($categoryIds, $start, $limit);

        $categoryIds = array(3);
        $Rearticle = $this->getArticleService()->findArticlesByCategoryIds($categoryIds, $start, $limit);

        /*教师数据*/
        $conditions = array(
            'roles'  => 'ROLE_TEACHER',
            'locked' => 0
        );

        $paginator = new Paginator(
            $this->get('request'),
            $this->getUserService()->searchUserCount($conditions),
            4
        );
        //$teachersCount = $this->getUserService()->searchUserCount($conditions);
        $teachers = $this->getUserService()->searchUsers(
            $conditions,
            array(
                'promoted', 'DESC',
                'promotedSeq', 'ASC',
                'promotedTime', 'DESC',
                'createdTime', 'DESC'
            ),
            $paginator->getOffsetCount(),
            $paginator->getPerPageCount()
        );


        $user = $this->getCurrentUser();

        if (!empty($user['id'])) {
            $this->getBatchNotificationService()->checkoutBatchNotification($user['id']);
        }
         $friendlyLinks = $this->getNavigationService()->getOpenedNavigationsTreeByType('friendlyLink');
        //$friendlyLinks = $this->getNavigationService()->getOpenedNavigationsTreeByType('friendlyLink');
       
        return $this->render('TopxiaWebBundle:Default:old-index.html.twig', array(
            'user'      => $user,
            'list'      => $list,
            'Schools'   => $school,
            'citys'     => $citys,
            'PCcourses' => $PCcourses,
            'DFcourses' => $DFcourses,
            'SCarticle' => $SCarticle,
            'TYarticle' => $TYarticle,
            'Rearticle' => $Rearticle,
            'Teachers'  => $teachers,
            'VScourses' => $VScourses,
            'SAcourses' => $SAcourses,
            'Tucourses' => $Tucourses,
            'thumbnails' => $thumbnails,
            //'crowd_classification' => $crowd_classification
            'friendlyLinks' => $friendlyLinks
            ));
    }

    public function forwardIndexAction(Request $request, $id)
    {
        $user = $this->getCurrentUser();
        
        if (!empty($user['id'])) {
            $this->getBatchNotificationService()->checkoutBatchNotification($user['id']);
        }

        $friendlyLinks = $this->getNavigationService()->getOpenedNavigationsTreeByType('friendlyLink');
        $school = $this->getSchoolsService()->getSchool($id);
        $logo = $school['logo'];
        $imgsOne = array(
            'src'  => $school['smallPicture'],
            'background' => "white",
            'href' => $school['url']
        );
        $imgsTwo = array(
            'src'  => $school['middlePicture'],
            'background' => "white",
            'href' => $school['url']
        );
        $imgsThree = array(
            'src'  => $school['largePicture'],
            'background' => "white",
            'href' => $school['url']
        );
        $images = array($imgsOne,$imgsTwo,$imgsThree);
        return $this->render('TopxiaWebBundle:Default:index.html.twig', array(
            'friendlyLinks' => $friendlyLinks, 
            'school_id' => $id, 
            'logo' => $logo, 
            'imgsOne' => $imgsOne,
            'imgsTwo' => $imgsTwo,
            'imgsThree' => $imgsThree
            ));
    }

    public function addSchoolAction(Request $request, $id)
    {
        $user = $this->getCurrentUser();
        
        // if (!empty($user['id'])) {
        //     $this->getBatchNotificationService()->checkoutBatchNotification($user['id']);
        // }
         //省份
        $province = $this->getProvinceService()->findAll();
        //城市
        $city = $this->getCityService()->findAll();
         //学校
        //$school = $this->getSchoolsService()->getSchool($id);
        if ($request->getMethod() == 'POST') {
            $school = $request->request->get('schools');

            $school_id = $this->getSchoolsService()->addSchool($id, $school);
          
            $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息保存成功。'));
             
            return $this->redirect($this->generateUrl('homepage'));
        }
        return $this->render('TopxiaWebBundle:School:add-school.html.twig', array(
            'province' => $province,
            'city' => $city,
            'schools' => $school,
            'user' => $user
            ));
    }

    public function updateSchoolAction(Request $request, $id)
    {
        if ($request->getMethod() == 'POST') {
            $school = $request->request->get('schools');

            $school_id = $this->getSchoolsService()->updateSchool($id, $school);
          
            $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息更新成功。'));
             
            return $this->redirect($this->generateUrl('homepage'));
        }
        
        $user = $this->getCurrentUser();

        // if (!empty($user['id'])) {
        //     $this->getBatchNotificationService()->checkoutBatchNotification($user['id']);
        // }
         //学校
        $school = $this->getSchoolsService()->getSchool($id);
        if($school['province_id'] != null && $school['city_id'] != null){
            //省份
            $province = $this->getProvinceService()->getProvince($school['province_id']);
            //城市
            $city = $this->getCityService()->getCityById($school['city_id']);
        }

        $provinces = $this->getProvinceService()->findAll();

        $citys = $this->getCityService()->findAll();
        
        return $this->render('TopxiaWebBundle:School:update-school.html.twig', array(
            'province' => $province,
            'city' => $city,
            'provinces' => $provinces,
            'citys' => $citys,
            'schools' => $school,
            'user' => $user
            ));
    }

    public function deleteSchoolAction(Request $request, $id)
    {
          //学校
        //$school = $this->getSchoolsService()->getSchool($id);
        $affected = $this->getSchoolsService()->deleteSchool($id);
        if ($affected <= 0) {
            $this->setFlashMessage('danger', $this->getServiceKernel()->trans('删除学校信息成功。'));
        }
        return $this->redirect($this->generateUrl('homepage'));
    }

    public function userlearningAction()
    {
        $user = $this->getCurrentUser();

        $courses = $this->getCourseService()->findUserLearnCourses($user->id, 0, 1);

        if (!empty($courses)) {
            foreach ($courses as $course) {
                $member = $this->getCourseService()->getCourseMember($course['id'], $user->id);

                $teachers = $this->getUserService()->findUsersByIds($course['teacherIds']);
            }

            $nextLearnLesson = $this->getCourseService()->getUserNextLearnLesson($user->id, $course['id']);

            $progress = $this->calculateUserLearnProgress($course, $member);
        } else {
            $course          = array();
            $nextLearnLesson = array();
            $progress        = array();
            $teachers        = array();
        }

        return $this->render('TopxiaWebBundle:Default:user-learning.html.twig', array(
            'user'            => $user,
            'course'          => $course,
            'nextLearnLesson' => $nextLearnLesson,
            'progress'        => $progress,
            'teachers'        => $teachers
        ));
    }

    public function promotedTeacherBlockAction()
    {
        $teacher = $this->getUserService()->findLatestPromotedTeacher(0, 1);

        if ($teacher) {
            $teacher = $teacher[0];
            $teacher = array_merge(
                $teacher,
                $this->getUserService()->getUserProfile($teacher['id'])
            );
        }

        if (isset($teacher['locked']) && $teacher['locked'] !== '0') {
            $teacher = null;
        }

        return $this->render('TopxiaWebBundle:Default:promoted-teacher-block.html.twig', array(
            'teacher' => $teacher
        ));
    }

    public function latestReviewsBlockAction($number)
    {
        $reviews = $this->getReviewService()->searchReviews(array('private' => 0), 'latest', 0, $number);
        $users   = $this->getUserService()->findUsersByIds(ArrayToolkit::column($reviews, 'userId'));
        $courses = $this->getCourseService()->findCoursesByIds(ArrayToolkit::column($reviews, 'courseId'));
        return $this->render('TopxiaWebBundle:Default:latest-reviews-block.html.twig', array(
            'reviews' => $reviews,
            'users'   => $users,
            'courses' => $courses
        ));
    }

    public function topNavigationAction($siteNav = null, $isMobile = false)
    {
        $navigations = $this->getNavigationService()->getOpenedNavigationsTreeByType('top');

        return $this->render('TopxiaWebBundle:Default:top-navigation.html.twig', array(
            'navigations' => $navigations,
            'siteNav'     => $siteNav,
            'isMobile'    => $isMobile
        ));
    }

    public function footNavigationAction()
    {
        $navigations = $this->getNavigationService()->findNavigationsByType('foot', 0, 100);

        return $this->render('TopxiaWebBundle:Default:foot-navigation.html.twig', array(
            'navigations' => $navigations
        ));
    }

    public function friendlyLinkAction()
    {
        $friendlyLinks = $this->getNavigationService()->getOpenedNavigationsTreeByType('friendlyLink');

        return $this->render('TopxiaWebBundle:Default:friend-link.html.twig', array(
            'friendlyLinks' => $friendlyLinks
        ));
    }

    public function customerServiceAction()
    {
        $customerServiceSetting = $this->getSettingService()->get('customerService', array());

        return $this->render('TopxiaWebBundle:Default:customer-service-online.html.twig', array(
            'customerServiceSetting' => $customerServiceSetting
        ));
    }

    public function jumpAction(Request $request)
    {
        $courseId = intval($request->query->get('id'));

        if ($this->getCourseService()->isCourseTeacher($courseId, $this->getCurrentUser()->id)) {
            $url = $this->generateUrl('live_course_manage_replay', array('id' => $courseId));
        } else {
            $url = $this->generateUrl('course_show', array('id' => $courseId));
        }

        $jumpScript = "<script type=\"text/javascript\"> if (top.location !== self.location) {top.location = \"{$url}\";}</script>";
        return new Response($jumpScript);
    }

    public function coursesCategoryAction(Request $request)
    {
        $conditions             = $request->query->all();
        $conditions['status']   = 'published';
        $conditions['parentId'] = 0;
        $categoryId             = isset($conditions['categoryId']) ? $conditions['categoryId'] : 0;
        $orderBy                = $conditions['orderBy'];
        $courseType             = isset($conditions['courseType']) ? $conditions['courseType'] : 'course';

        $config = $this->getThemeService()->getCurrentThemeConfig();

        if (!empty($config['confirmConfig'])) {
            $config = $config['confirmConfig']['blocks']['left'];

            foreach ($config as $template) {
                if (($template['code'] == 'course-grid-with-condition-index' && $courseType == 'course')
                    || ($template['code'] == 'open-course' && $courseType == 'open-course')) {
                    $config = $template;
                }
            }

            $config['orderBy']    = $orderBy;
            $config['categoryId'] = $categoryId;

            return $this->render('TopxiaWebBundle:Default:'.$config['code'].'.html.twig', array(
                'config' => $config
            ));
        } else {
            return $this->render('TopxiaWebBundle:Default:course-grid-with-condition-index.html.twig', array(
                'categoryId' => $categoryId,
                'orderBy'    => $orderBy
            ));
        }
    }

    protected function calculateUserLearnProgress($course, $member)
    {
        if ($course['lessonNum'] == 0) {
            return array('percent' => '0%', 'number' => 0, 'total' => 0);
        }

        $percent = intval($member['learnedNum'] / $course['lessonNum'] * 100).'%';

        return array(
            'percent' => $percent,
            'number'  => $member['learnedNum'],
            'total'   => $course['lessonNum']
        );
    }

    public function translateAction(Request $request)
    {
        $locale     = $request->query->get('language');
        $targetPath = $request->query->get('_target_path');

        $request->getSession()->set('_locale', $locale);

        $currentUser = $this->getCurrentUser();

        if ($currentUser->isLogin()) {
            $this->getUserService()->updateUserLocale($currentUser['id'], $locale);
        }

        return $this->redirect($targetPath);
    }

    


    protected function getSettingService()
    {
        return $this->getServiceKernel()->createService('System.SettingService');
    }

    protected function getNavigationService()
    {
        return $this->getServiceKernel()->createService('Content.NavigationService');
    }

    protected function getBlockService()
    {
        return $this->getServiceKernel()->createService('Content.BlockService');
    }

    protected function getCourseService()
    {
        return $this->getServiceKernel()->createService('Course.CourseService');
    }

    protected function getReviewService()
    {
        return $this->getServiceKernel()->createService('Course.ReviewService');
    }

    protected function getCategoryService()
    {
        return $this->getServiceKernel()->createService('Taxonomy.CategoryService');
    }

    protected function getAppService()
    {
        return $this->getServiceKernel()->createService('CloudPlatform.AppService');
    }

    protected function getClassroomService()
    {
        return $this->getServiceKernel()->createService('Classroom:Classroom.ClassroomService');
    }

    protected function getBatchNotificationService()
    {
        return $this->getServiceKernel()->createService('User.BatchNotificationService');
    }

    protected function getThemeService()
    {
        return $this->getServiceKernel()->createService('Theme.ThemeService');
    }

    private function getBlacklistService()
    {
        return $this->getServiceKernel()->createService('User.BlacklistService');
    }

    protected function getCrowdClassificationService()
    {
        return $this->getServiceKernel()->createService('CrowdClassification.CrowdClassificationService');
    }

    protected function getSchoolsService()
    {
        return $this->getServiceKernel()->createService('Schools.SchoolsService');
    }

    protected function getProvinceService()
    {
        return $this->getServiceKernel()->createService('Province.ProvinceService');
    }

    protected function getCityService()
    {
        return $this->getServiceKernel()->createService('City.CityService');
    }

    protected function getArticleService()
    {
        return $this->getServiceKernel()->createService('Article.ArticleService');
    }

    protected function getUserService()
    {
        return $this->getServiceKernel()->createService('User.UserService');
    }

    protected function getLevelService()
    {
        return $this->getServiceKernel()->createService('Level.LevelService');
    }

    protected function getThumbnailsService()
    {
        return $this->getServiceKernel()->createService('Thumbnails.ThumbnailsService');
    }
}
