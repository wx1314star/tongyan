<?php
namespace Topxia\AdminBundle\Controller;

use Topxia\Common\Paginator;
use Topxia\Common\ArrayToolkit;
use Topxia\Common\StringToolkit;
use Topxia\Service\Common\MailFactory;
use Topxia\WebBundle\DataDict\UserRoleDict;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class BackgroundController extends BaseController
{
    public function indexAction(Request $request)
    {
        $user   = $this->getCurrentUser();
        $fields = $request->query->all();

        $conditions = array(
            'roles'           => '',
            'keywordType'     => '',
            'keyword'         => '',
            'keywordUserType' => '',
            'school_id'        => $user['schoolId']
        );

        $conditions = array_merge($conditions, $fields);
        $conditions = $this->fillOrgCode($conditions);

        $userCount = $this->getUserService()->searchUserCount($conditions);
        $paginator = new Paginator(
            $this->get('request'),
            $userCount,
            20
        );

        $users = $this->getUserService()->searchUsers(
            $conditions,
            array('createdTime', 'DESC'),
            $paginator->getOffsetCount(),
            $paginator->getPerPageCount()
        );

        //根据mobile查询user_profile获得userIds

        if (isset($conditions['keywordType']) && $conditions['keywordType'] == 'verifiedMobile' && !empty($conditions['keyword'])) {
            $profilesCount = $this->getUserService()->searchUserProfileCount(array('mobile' => $conditions['keyword']));
            $userProfiles  = $this->getUserService()->searchUserProfiles(
                array('mobile' => $conditions['keyword']),
                array('id', 'DESC'),
                0,
                $profilesCount
            );
            $userIds       = ArrayToolkit::column($userProfiles, 'id');

            if (!empty($userIds)) {
                unset($conditions['keywordType']);
                unset($conditions['keyword']);
                $conditions['userIds'] = array_merge(ArrayToolkit::column($users, 'userId'), $userIds);
            }

            $userCount = $this->getUserService()->searchUserCount($conditions);
            $paginator = new Paginator(
                $this->get('request'),
                $userCount,
                20
            );

            $users = $this->getUserService()->searchUsers(
                $conditions,
                array('createdTime', 'DESC'),
                $paginator->getOffsetCount(),
                $paginator->getPerPageCount()
            );
        }

        $app = $this->getAppService()->findInstallApp("UserImporter");

        $showUserExport = false;

        if (!empty($app) && array_key_exists('version', $app)) {
            $showUserExport = version_compare($app['version'], "1.0.2", ">=");
        }

        $userIds  = ArrayToolkit::column($users, 'id');
        $profiles = $this->getUserService()->findUserProfilesByIds($userIds);

        $allRoles = $this->getAllRoles();

        return $this->render('TopxiaAdminBundle:Background:whole/index.html.twig', array(
            'users'          => $users,
            'allRoles'       => $allRoles,
            'userCount'      => $userCount,
            'paginator'      => $paginator,
            'profiles'       => $profiles,
            'showUserExport' => $showUserExport
        ));
    }

    protected function convertConditions($conditions)
    {
        if (!empty($conditions['nickname'])) {
            $conditions['fromIds']= "";
            
            $userConditions = array('nickname' => trim($conditions['nickname']));
            $userCount = $this->getUserService()->searchUserCount($userConditions);
            if ($userCount) {
                $users                 = $this->getUserService()->searchUsers($userConditions, array('createdTime', 'DESC'), 0, $userCount);
                $conditions['fromIds'] = ArrayToolkit::column($users, 'id');
            }
            
        }

        unset($conditions['nickname']);
      
        if (!empty($conditions['startDate'])  ) {
            $conditions['startDate'] = strtotime($conditions['startDate']);
        }

        if (!empty($conditions['endDate'])) {
            $conditions['endDate'] = strtotime($conditions['endDate']);
        }

        return $conditions;
    }

    protected function getAllRoles()
    {
        $roles = $this->getRoleService()->searchRoles(array(), 'created', 0, PHP_INT_MAX);

        $roleDicts = array();
        foreach ($roles as $key => $role) {
            $roleDicts[$role['code']] = $role['name'];
        }
        return $roleDicts;
    }

    protected function validateResult($result, $message)
    {
        if ($result == 'success') {
            $response = array('success' => true, 'message' => '');
        } else {
            $response = array('success' => false, 'message' => $message);
        }

        return $this->createJsonResponse($response);
    }

    public function createAction(Request $request)
    {
        if ($request->getMethod() == 'POST') {
            $formData         = $request->request->all();
            $formData['type'] = 'import';
            $registration     = $this->getRegisterData($formData, $request->getClientIp());
            $user             = $this->getAuthService()->register($registration);

            $this->get('session')->set('registed_email', $user['email']);

            if (isset($formData['roles'])) {
                $roles[] = 'ROLE_TEACHER';
                array_push($roles, 'ROLE_USER');
                $this->getUserService()->changeUserRoles($user['id'], $roles);
            }

            $this->getLogService()->info('user', 'add', "管理员添加新用户 {$user['nickname']} ({$user['id']})");

            return $this->redirect($this->generateUrl('admin_user'));
        }

        return $this->render($this->getCreateUserModal());
    }

    protected function getRegisterData($formData, $clientIp)
    {
        if (isset($formData['email'])) {
            $userData['email'] = $formData['email'];
        }

        if (isset($formData['emailOrMobile'])) {
            $userData['emailOrMobile'] = $formData['emailOrMobile'];
        }

        if (isset($formData['mobile'])) {
            $userData['mobile'] = $formData['mobile'];
        }

        $userData['nickname']  = $formData['nickname'];
        $userData['password']  = $formData['password'];
        $userData['createdIp'] = $clientIp;
        $userData['type']      = $formData['type'];

        if (isset($formData['orgCode'])) {
            $userData['orgCode'] = $formData['orgCode'];
        }

        return $userData;
    }

    protected function getCreateUserModal()
    {
        $auth = $this->getSettingService()->get('auth');

        if (isset($auth['register_mode']) && $auth['register_mode'] == 'email_or_mobile') {
            return 'TopxiaAdminBundle:User:create-by-mobile-or-email-modal.html.twig';
        } elseif (isset($auth['register_mode']) && $auth['register_mode'] == 'mobile') {
            return 'TopxiaAdminBundle:User:create-by-mobile-modal.html.twig';
        } else {
            return 'TopxiaAdminBundle:User:create-modal.html.twig';
        }
    }

    public function editAction(Request $request, $id)
    {
        $user = $this->getUserService()->getUser($id);

        $profile          = $this->getUserService()->getUserProfile($user['id']);
        $profile['title'] = $user['title'];

        if ($request->getMethod() == 'POST') {
            $profile = $request->request->all();

            if (!((strlen($user['verifiedMobile']) > 0) && isset($profile['mobile']))) {
                $profile = $this->getUserService()->updateUserProfile($user['id'], $profile);
                $this->getLogService()->info('user', 'edit', "管理员编辑用户资料 {$user['nickname']} (#{$user['id']})", $profile);
            } else {
                $this->setFlashMessage('danger', $this->getServiceKernel()->trans('用户已绑定的手机不能修改。'));
            }

            return $this->redirect($this->generateUrl('admin_user'));
        }

        $fields = $this->getFields();

        return $this->render('TopxiaAdminBundle:User:edit-modal.html.twig', array(
            'user'    => $user,
            'profile' => $profile,
            'fields'  => $fields
        ));
    }

    public function orgUpdateAction(Request $request, $id)
    {
        $user = $this->getUserService()->getUser($id);

        if ($request->isMethod('POST')) {
            $orgCode = $request->request->get('orgCode', $user['orgCode']);
            $this->getUserService()->changeUserOrg($user['id'], $orgCode);
        }

        $org = $this->getOrgService()->getOrgByOrgCode($user['orgCode']);
        return $this->render('TopxiaAdminBundle:User:update-org-modal.html.twig', array(
            'user' => $user,
            'org'  => $org
        ));
    }

    public function showAction(Request $request, $id)
    {
        $user             = $this->getUserService()->getUser($id);
        $profile          = $this->getUserService()->getUserProfile($id);
        $profile['title'] = $user['title'];

        $fields = $this->getFields();
        return $this->render('TopxiaAdminBundle:Background:whole/show-modal.html.twig', array(
            'user'    => $user,
            'profile' => $profile,
            'fields'  => $fields
        ));
    }
    
    public function rolesAction(Request $request, $id)
    {
        $user        = $this->getUserService()->getUser($id);
        $currentUser = $this->getCurrentUser();

        if ($request->getMethod() == 'POST') {
            $roles = $request->request->get('roles');

            $this->getUserService()->changeUserRoles($user['id'], $roles);

            if (!empty($roles)) {
                $roleSet          = $this->getRoleService()->searchRoles(array(), 'created', 0, 9999);
                $rolesByIndexCode = ArrayToolkit::index($roleSet, 'code');
                $roleNames = $this->getRoleNames($roles, $rolesByIndexCode);

                $message          = array(
                    'userId'   => $currentUser['id'],
                    'userName' => $currentUser['nickname'],
                    'role'     => implode(',', $roleNames)
                );

                $this->getNotifiactionService()->notify($user['id'], 'role', $message);
            }
            $user = $this->getUserService()->getUser($id);
            return $this->render('TopxiaAdminBundle:Background:whole/user-table-tr.html.twig', array(
                'user'    => $user,
                'profile' => $this->getUserService()->getUserProfile($id)
            ));
        }

        return $this->render('TopxiaAdminBundle:Background:whole/roles-modal.html.twig', array(
            'user' => $user
        ));
    }

    protected function getRoleNames($roles, $roleSet)
    {
        $roleNames = array();
        $roles     = array_unique($roles);

        $userRoleDict  = new UserRoleDict();
        $userRoleDict  = $userRoleDict->getDict();
        $roleDictCodes = array_keys($userRoleDict);

        foreach ($roles as $key => $role) {
            if (in_array($role, $roleDictCodes)) {
                $roleNames[] = $userRoleDict[$role];
            } elseif ($role == 'ROLE_BACKEND') {
                continue;
            } else {
                $role        = $roleSet[$role];
                $roleNames[] = $role['name'];
            }
        }

        return $roleNames;
    }

    public function avatarAction(Request $request, $id)
    {
        $user = $this->getUserService()->getUser($id);

        $hasPartnerAuth = $this->getAuthService()->hasPartnerAuth();

        if ($hasPartnerAuth) {
            $partnerAvatar = $this->getAuthService()->getPartnerAvatar($user['id'], 'big');
        } else {
            $partnerAvatar = null;
        }

        return $this->render('TopxiaAdminBundle:User:user-avatar-modal.html.twig', array(
            'user'          => $user,
            'partnerAvatar' => $partnerAvatar
        ));
    }

    protected function getFields()
    {
        $fields = $this->getUserFieldService()->getAllFieldsOrderBySeqAndEnabled();

        for ($i = 0; $i < count($fields); $i++) {
            if (strstr($fields[$i]['fieldName'], "textField")) {
                $fields[$i]['type'] = "text";
            }

            if (strstr($fields[$i]['fieldName'], "varcharField")) {
                $fields[$i]['type'] = "varchar";
            }

            if (strstr($fields[$i]['fieldName'], "intField")) {
                $fields[$i]['type'] = "int";
            }

            if (strstr($fields[$i]['fieldName'], "floatField")) {
                $fields[$i]['type'] = "float";
            }

            if (strstr($fields[$i]['fieldName'], "dateField")) {
                $fields[$i]['type'] = "date";
            }
        }

        return $fields;
    }

    public function avatarCropAction(Request $request, $id)
    {
        $user = $this->getUserService()->getUser($id);

        if ($request->getMethod() == 'POST') {
            $options = $request->request->all();
            $this->getUserService()->changeAvatar($id, $options["images"]);

            return $this->createJsonResponse(true);
        }

        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 270, 270);

        return $this->render('TopxiaAdminBundle:User:user-avatar-crop-modal.html.twig', array(
            'user'        => $user,
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize
        ));
    }

    public function lockAction($id)
    {
        $this->getUserService()->lockUser($id);
        $this->kickUserLogout($id);
        return $this->render('TopxiaAdminBundle:User:user-table-tr.html.twig', array(
            'user'    => $this->getUserService()->getUser($id),
            'profile' => $this->getUserService()->getUserProfile($id)
        ));
    }

    public function unlockAction($id)
    {
        $this->getUserService()->unlockUser($id);

        return $this->render('TopxiaAdminBundle:User:user-table-tr.html.twig', array(
            'user'    => $this->getUserService()->getUser($id),
            'profile' => $this->getUserService()->getUserProfile($id)
        ));
    }

    public function sendPasswordResetEmailAction(Request $request, $id)
    {
        $user = $this->getUserService()->getUser($id);

        if (empty($user)) {
            throw $this->createNotFoundException();
        }

        $token = $this->getUserService()->makeToken('password-reset', $user['id'], strtotime('+1 day'));
        $site  = $this->setting('site', array());
        try {
            $mailOptions = array(
                'to'       => $user['email'],
                'template' => 'email_reset_password',
                'params'   => array(
                    'nickname'  => $user['nickname'],
                    'verifyurl' => $this->generateUrl('password_reset_update', array('token' => $token), true),
                    'sitename'  => $site['name'],
                    'siteurl'   => $site['url']
                )
            );
            $mail        = MailFactory::create($mailOptions);
            $mail->send();
            $this->getLogService()->info('user', 'send_password_reset', "管理员给用户 ${user['nickname']}({$user['id']}) 发送密码重置邮件");
        } catch (\Exception $e) {
            $this->getLogService()->error('user', 'send_password_reset', "管理员给用户 ${user['nickname']}({$user['id']}) 发送密码重置邮件失败：" . $e->getMessage());
            throw $e;
        }

        return $this->createJsonResponse(true);
    }

    public function sendEmailVerifyEmailAction(Request $request, $id)
    {
        $user = $this->getUserService()->getUser($id);

        if (empty($user)) {
            throw $this->createNotFoundException();
        }

        $token = $this->getUserService()->makeToken('email-verify', $user['id'], strtotime('+1 day'));

        $site      = $this->getSettingService()->get('site', array());
        $verifyurl = $this->generateUrl('register_email_verify', array('token' => $token), true);

        try {
            $mailOptions = array(
                'to'       => $user['email'],
                'template' => 'email_registration',
                'params'   => array(
                    'sitename'  => $site['name'],
                    'siteurl'   => $site['url'],
                    'verifyurl' => $verifyurl,
                    'nickname'  => $user['nickname']
                )
            );

            $mail = MailFactory::create($mailOptions);
            $mail->send();
            $this->getLogService()->info('user', 'send_email_verify', "管理员给用户 ${user['nickname']}({$user['id']}) 发送Email验证邮件");
        } catch (\Exception $e) {
            $this->getLogService()->error('user', 'send_email_verify', "管理员给用户 ${user['nickname']}({$user['id']}) 发送Email验证邮件失败：" . $e->getMessage());
            throw $e;
        }

        return $this->createJsonResponse(true);
    }

    public function changePasswordAction(Request $request, $userId)
    {
        $currentUser = $this->getCurrentUser();
        $user        = $this->getUserService()->getUser($userId);

        if ($request->getMethod() == 'POST') {
            $formData = $request->request->all();
            $this->getAuthService()->changePassword($user['id'], null, $formData['newPassword']);
            $this->kickUserLogout($user['id']);
            return $this->createJsonResponse(true);
        }

        return $this->render('TopxiaAdminBundle:User:change-password-modal.html.twig', array(
            'user' => $user
        ));
    }

    protected function kickUserLogout($userId)
    {
        $this->getSessionService()->clearByUserId($userId);
        $tokens = $this->getTokenService()->findTokensByUserIdAndType($userId, 'mobile_login');
        if (!empty($tokens)) {
            foreach ($tokens as $token) {
                $this->getTokenService()->destoryToken($token['token']);
            }
        }
    }

    /*1.全局部分*/
    public function siteAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:default/site.html.twig', array(
            ));
    }

    public function teamAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:default/team.html.twig', array(
            ));
    }

    public function payAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:default/pay.html.twig', array(
            ));
    }

    /*2.学生部分*/
    public function enrollAction(Request $request)
    {
        $school_id = $this->getCurrentUser()->getSchoolId();
        $students = $this->getStudentsService()->findStudents($school_id);
        for($i = 0; $i < count($students); $i++) {
             $id = $students[$i]['reportedCourse'];
             $course = $this->getCourseService()->getCourse($id);
             $students[$i]['course'] = $course['title'];
             $students[$i]['price'] = $course['price'];
        }
       
        return $this->render('TopxiaAdminBundle:Background:student/enroll.html.twig', array(
            'students' => $students
            ));
    }

    // 确认报道功能
    public function reportAction(Request $request, $id)
    {
         if ($request->getMethod() == 'POST') {
            $pay = $request->request->get('pay');
            $num = $this->getPayService()->getPayBySms($pay['sms']);
            if($num != null)
            {
                // 状态改为已确认报道
                $num['status'] = 1;
                $this->getPayService()->updatePay($num['id'], $num);
                $this->setFlashMessage('success', $this->getServiceKernel()->trans('学生确认报道成功。'));
                return $this->redirect($this->generateUrl('newadmin_enroll'));
            }else
            {
                $this->setFlashMessage('success', $this->getServiceKernel()->trans('学生确认报道失败,请检查凭证。'));
                return $this->redirect($this->generateUrl('newadmin_enroll'));
            }
            
         }

         $pay = $this->getPayService()->getPayByStuId($id);
         return $this->render('TopxiaAdminBundle:Background:student/report.html.twig', array(
            'pay' => $pay
            ));
    }

    public function customizationAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:student/customization.html.twig', array(
            ));
    }

    public function auditionAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:student/audition.html.twig', array(
            ));
    }

    public function leaveSchoolAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:student/leaveSchool.html.twig', array(
            ));
    }

    public function forSchoolAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:student/forSchool.html.twig', array(
            ));
    }

    /*3.学校部分*/

    public function registerscAction(Request $request)
    {
        $user = $this -> getCurrentUser();
        $id = $user -> getSchoolId();
        $roles = array();
        $roles = $user['roles'];
        $flag = 1;
        if (in_array('ROLE_SCHOOL_ADMIN', $roles) || in_array('ROLE_SCHOOLRECRUIT', $roles)) {
            $flag = 1;
        }else if(in_array('ROLE_TRAIN_ADMIN', $roles) || in_array('ROLE_TRAINRECRUIT', $roles)){
            $flag = 2;
        }

        if ($request->getMethod() == 'POST') {
            $school = $request->request->get('schools');

            if($school['id'] !=0 && $school['id'] != null){
                $school = $this->getSchoolsService()->updateSchool($id, $school);
                $newUser = $this->getUserService()->getUser($user['id']);
                $newUser['schoolId'] = $school['id'];
                $this->getUserService()->updateUser($newUser['id'], $newUser);
                $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息更新成功。'));
             
                return $this->redirect($this->generateUrl('newadmin'));
            }else{
                $school = $this->getSchoolsService()->addSchool($id, $school);
                $newUser = $this->getUserService()->getUser($user['id']);
                $newUser['schoolId'] = $school['id'];
                $this->getUserService()->updateUser($user->getId(), $user);
                $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息保存成功。'));
             
                return $this->redirect($this->generateUrl('newadmin'));
            }
        }
        
         //学校
        $school = $this->getSchoolsService()->getSchool($id);
        if ($school['institutionsType'] == "0") {
            $flag = 1;
        }else if($school['institutionsType'] == "1"){
            $flag = 2;
        }
        if($school['province_id'] != null && $school['city_id'] != null){
            //省份
            $province = $this->getProvinceService()->getProvince($school['province_id']);
            //城市
            $city = $this->getCityService()->getCityById($school['city_id']);
        }

        $provinces = $this->getProvinceService()->findAll();

        $citys = $this->getCityService()->findAll();
        
        if($school != null ){
             return $this->render('TopxiaAdminBundle:Background:school/registersc.html.twig', array(
            'province' => $province,
            'city' => $city,
            'provinces' => $provinces,
            'citys' => $citys,
            'schools' => $school,
            'user' => $user,
            'flag' => $flag
            ));
        }else{
             return $this->render('TopxiaAdminBundle:Background:school/registersc-add.html.twig', array(
            'province' => $province,
            'city' => $city,
            'provinces' => $provinces,
            'citys' => $citys,
            'schools' => $school,
            'user' => $user,
            'flag' => $flag
            ));
        }
       
    }

    public function authenticationAction(Request $request)
    {
        $user = $this->getCurrentUser();
        $id = $user->getSchoolId();
       
        // if ($request->getMethod() == 'POST') {
        //     $schoolAuth = $request->request->get('schoolAuth');

        //     $this->getSchoolAuthService()->addSchoolAuth($id, $schoolAuth);

        //     //$birthday = date("Y-m-d", $student['birthday']);
          
        //     $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息保存成功。'));
             
        //     return $this->redirect($this->generateUrl('homepage'));



        //     $schoolAuth = $request->request->get('schoolAuth');

        //     $this->getSchoolAuthService()->updateSchoolAuth($id, $schoolAuth);
          
        //     $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息更新成功。'));
             
        //     return $this->redirect($this->generateUrl('homepage'));
        // }
        $flag = 1;
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
         if(null != $id){
             $school = $this->getSchoolsService()->getSchool($id);
        }else if(null != $schoolAuth['school_id']){
             $school = $this->getSchoolsService()->getSchool($schoolAuth['school_id']);
        }
        if(null != $school['institutionsType'] && $school['institutionsType'] == 0){
            $flag = 1;
        }else if(null != $school['institutionsType'] && $school['institutionsType'] == 0){
            $flag = 2;
        }
        if($schoolAuth != null){
             return $this->render('TopxiaAdminBundle:Background:school/authentication.html.twig', array(
                'schoolAuth' => $schoolAuth,
                'school_id'  => $schoolAuth['school_id'],
                'flag' => $flag
            ));
        }else{
             return $this->render('TopxiaAdminBundle:Background:school/authentication-add.html.twig', array(
                'school_id' => $id,
                // 'user' => $user,
                'flag' => $flag
                ));
        }
        //  return $this->render('TopxiaAdminBundle:Background:school/authentication.html.twig', array(
        //         'schoolAuth' => $schoolAuth,
        //         'school_id'  => $schoolAuth['school_id']
        //     ));
    }

    // 原后台学校机构
    public function messagescAction(Request $request)
    {
        
        $schools = $this->getSchoolsService()->findAllByNum(10);
        return $this->render('TopxiaAdminBundle:Background:school/messagesc.html.twig', array(
            'schools' => $schools
            ));
    }

    // 微信设置页面
    public function  weiXinSetAction(Request $request)
    {
        if ($request->getMethod() == 'POST') {
            $weixin = $request->request->get("weixin");
            $this->getWeiXinService()->updateWeiXin($weixin['id'], $weixin);

            $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息更新成功。'));
             
            return $this->redirect($this->generateUrl('newadmin_weixinsc'));
        }
        $weixin = $this->getWeiXinService()->findAllWeiXin();
        return $this->render('TopxiaAdminBundle:Background:school/weiXinSc.html.twig', array(
            'weixin' => $weixin[0]
            ));
    }
               

    // 显示上传图片
    public function showSchoolAuthAction(Request $request, $school_id)
    {
        $user = $this->getCurrentUser();
        $flag = 1;
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($school_id);
        $school = $this->getSchoolsService()->getSchool($school_id);
        if(null != $school['institutionsType'] && $school['institutionsType'] == 0){
            $flag = 1;
        }else if(null != $school['institutionsType'] && $school['institutionsType'] == 1){
            $flag = 2;
        }

        // if($schoolAuth != null){
        //      return $this->render('TopxiaAdminBundle:Background:school/showSchoolAuth.html.twig', array(
        //         'schoolAuth' => $schoolAuth,
        //         'school_id'  => $schoolAuth['school_id'],
        //         'flag' => $flag
        //     ));
        // }else{
        //      return $this->render('TopxiaAdminBundle:Background:school/authentication-add.html.twig', array(
        //         'school_id' => $id,
        //         // 'user' => $user,
        //         'flag' => $flag
        //         ));
        // }
        
        return $this->render('TopxiaAdminBundle:Background:school/showSchoolAuth.html.twig', array(
                'schoolAuth' => $schoolAuth,
                'school_id'  => $schoolAuth['school_id'],
                'flag' => $flag
            ));
    }

    public function showSchoolAuthCropAction(Request $request, $id, $type)
    {
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        switch ($type) {
            case "registerCertificate":
                return $this->render('TopxiaAdminBundle:Background:school/showSchoolAuthCrop.html.twig', array(
                    'pictureUrl' => $schoolAuth['registerCertificate']
                    ));
            case "licenseForSchool":
                return $this->render('TopxiaAdminBundle:Background:school/showSchoolAuthCrop.html.twig', array(
                    'pictureUrl' => $schoolAuth['licenseForSchool']
                    ));
            case "permitOrProject":
                return $this->render('TopxiaAdminBundle:Background:school/showSchoolAuthCrop.html.twig', array(
                    'pictureUrl' => $schoolAuth['permitOrProject']
                    ));
            case "annuaInspection":
                return $this->render('TopxiaAdminBundle:Background:school/showSchoolAuthCrop.html.twig', array(
                    'pictureUrl' => $schoolAuth['annuaInspection']
                    ));
            case "approvalForm":
                return $this->render('TopxiaAdminBundle:Background:school/showSchoolAuthCrop.html.twig', array(
                    'pictureUrl' => $schoolAuth['approvalForm']
                    ));
            case "specialProfessional":
                return $this->render('TopxiaAdminBundle:Background:school/showSchoolAuthCrop.html.twig', array(
                    'pictureUrl' => $schoolAuth['specialProfessional']
                    ));
            case "businessLicense":
                return $this->render('TopxiaAdminBundle:Background:school/showSchoolAuthCrop.html.twig', array(
                    'pictureUrl' => $schoolAuth['businessLicense']
                    ));
            }
    }

    //授权学校和学校管理员
    public function schoolAuthorizeTrueAction(Request $request, $school_id)
    {
        $school = $this->getSchoolsService()->getSchool($school_id);
        $user = $this->getUserService()->getUser($school['userId']);
        if(isset($school) && isset($user)){
            $school['status'] = "0";
            $role = array(
                'ROLE_USER','ROLE_SCHOOL_ADMIN'
            );

            $user['roles'] = $role;
            $school = $this->getSchoolsService()->updateSchool($school_id,$school);
            $this->getUserService()->updateUser($user['id'],$user);
            $this->setFlashMessage('success', $this->getServiceKernel()->trans('授权学校和学校管理员成功。'));
            return $this->redirect($this->generateUrl('newadmin_messagesc'));
        }else{
            $this->setFlashMessage('error', $this->getServiceKernel()->trans('保存失败，请重试或联系管理员。'));
            return $this->redirect($this->generateUrl('newadmin_messagesc'));
        }
    }

    //封禁学校
    public function schoolAuthorizeFalseAction(Request $request, $school_id)
    {
        $school = $this->getSchoolsService()->getSchool($school_id);
        $user = $this->getUserService()->getUser($school['userId']);
        if(isset($school) && isset($user)){
            $school['status'] = 1;
            $this->getSchoolsService()->updateSchool($school_id,$school);
            $this->setFlashMessage('success', $this->getServiceKernel()->trans('封禁学校成功。'));
            return $this->redirect($this->generateUrl('newadmin_messagesc'));
        }else{
            $this->setFlashMessage('error', $this->getServiceKernel()->trans('封禁失败，请重试或联系管理员。'));
            return $this->redirect($this->generateUrl('newadmin_messagesc'));
        }
    }

    public function schoolShowAction(Request $request, $id)
    {
        $school = $this->getSchoolsService()->getSchool($id);
        return $this->render('TopxiaAdminBundle:Background:school/schoolshow.html.twig', array(
            'school' => $school
            ));
    }

    public function studentShowAction(Request $request, $id)
    {
        $student = $this->getStudentsService()->getStudent($id);
        return $this->render('TopxiaAdminBundle:Background:student/studentshow.html.twig', array(
            'student' => $student
            ));
    }

    public function coursescAction(Request $request)
    {
        if ($request->getMethod() == 'POST') {
            $id = $request->request->get('id');
            $name = $request->request->get('name');
            $level = $request->request->get('level');
            $deleteId = $request->request->get('deleteId');

            $j = 0;//需要被删除的检索级别的Id下标
            for ($i = 0; $i < count($name); $i++) {
			$iid = 0;
			$ilevel = 0;
			$ideleteLevelId = 0;
			    try {
				    $iid = (int)$id[$i];
				    $ilevel = (int)$level[$i];
			    } catch (\Exception $e) {
				    throw $e;
			    }
                $entityLevel = array();
                $entityLevel['id'] = $iid;
                $entityLevel['name'] = $name[$i]; 
                $entityLevel['level'] = $ilevel;
			    $entityLevel['next'] = $i;
			    if($entityLevel['id'] == 0){//添加操作
				    $this->getLevelService()->addLevel($entityLevel);
			    }else if($entityLevel['id'] == -1){//删除操作
				    try {
					    $ideleteLevelId = (int)$deleteId[$j++];
					    $entityLevel['id'] = $ideleteLevelId;
                        $this->getLevelService()->deleteLevel($entityLevel['id'], $entityLevel);
				    } catch (\Exception $e) {
					    throw $e;
				    }
			    }else{//更新操作
                    $this->getLevelService()->updateLevel($entityLevel['id'], $entityLevel);
			    }
	        }
		//$coursetype = $this->getLevelService()->findAll();
        //$this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息保存成功。'));
            return $this->redirect($this->generateUrl('newadmin_registersc'));
        }
        $coursetype = $this->getLevelService()->findAll();
        return $this->render('TopxiaAdminBundle:Background:school/coursesc.html.twig', array(
            'tmpSize' => count($coursetype),
            'list' => $coursetype
            ));
    }

    // 文章资讯
    public function articlescAction(Request $request)
    {
        $user   = $this->getCurrentUser();
       
        $conditions = $request->query->all();

        $categoryId = 0;

        if (!empty($conditions['categoryId'])) {
            $conditions['includeChildren'] = true;
            $categoryId                    = $conditions['categoryId'];
        }

        $conditions = $this->fillOrgCode($conditions);

        $conditions['school_id'] = $user['schoolId'];
        $paginator = new Paginator(
            $request,
            $this->getArticleService()->searchArticlesCount($conditions),
            20
        );

        $articles = $this->getArticleService()->searchArticles(
            $conditions,
            'normal',
            $paginator->getOffsetCount(),
            $paginator->getPerPageCount()
        );
        $categoryIds  = ArrayToolkit::column($articles, 'categoryId');
        $categories   = $this->getCategoryService()->findCategoriesByIds($categoryIds);
        $categoryTree = $this->getCategoryService()->getCategoryTree();
        return $this->render('TopxiaAdminBundle:Background:school/articlesc.html.twig', array(
            'articles'     => $articles,
            'categories'   => $categories,
            'paginator'    => $paginator,
            'categoryTree' => $categoryTree,
            'categoryId'   => $categoryId
            ));
    }

    public function articlescCreateAction(Request $request)
    {
         if ($request->getMethod() == 'POST') {
            $formData        = $request->request->all();
            $article['tags'] = array_filter(explode(',', $formData['tags']));

            $article = $this->getArticleService()->createArticle($formData);

            $attachment = $request->request->get('attachment');
            $this->getUploadFileService()->createUseFiles($attachment['fileIds'], $article['id'], $attachment['targetType'], $attachment['type']);
            return $this->redirect($this->generateUrl('admin_article'));
        }

        $categoryTree = $this->getCategoryService()->getCategoryTree();

        return $this->render('TopxiaAdminBundle:Background:school/article-modal.html.twig', array(
            'categoryTree' => $categoryTree,
            'category'     => array('id' => 0, 'parentId' => 0)
        ));
    }

    public function articlescEditAction(Request $request, $id)
    {
        $article = $this->getArticleService()->getArticle($id);

        if (empty($article)) {
            throw $this->createNotFoundException($this->getServiceKernel()->trans('文章已删除或者未发布！'));
        }

        if (empty($article['tagIds'])) {
            $article['tagIds'] = array();
        }

        $tags     = $this->getTagService()->findTagsByIds($article['tagIds']);
        $tagNames = ArrayToolkit::column($tags, 'name');

        $categoryId = $article['categoryId'];
        $category   = $this->getCategoryService()->getCategory($categoryId);

        $categoryTree = $this->getCategoryService()->getCategoryTree();

        if ($request->getMethod() == 'POST') {
            $formData = $request->request->all();
            $article  = $this->getArticleService()->updateArticle($id, $formData);

            $attachment = $request->request->get('attachment');

            $this->getUploadFileService()->createUseFiles($attachment['fileIds'], $article['id'], $attachment['targetType'], $attachment['type']);
            return $this->redirect($this->generateUrl('admin_article'));
        }

        return $this->render('TopxiaAdminBundle:Background:school/article-modal.html.twig', array(
            'article'      => $article,
            'categoryTree' => $categoryTree,
            'category'     => $category,
            'tagNames'     => $tagNames
        ));
    }

    /*5.统计部分*/
    public function schoolstAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:statistics/schoolst.html.twig', array(
            ));
    }

    public function enrollstatAction(Request $request)
    {
        if ($request->getMethod() == 'POST') {
            $id = $request->request->get('id');
            $name = $request->request->get('name');
            $level = $request->request->get('level');
            }
        $user  = $this->getCurrentUser();
        $students = $this->getStudentsService()->findStudentsByTeacher($user['id']);
        //$students = $this->getStudentsService()->findStudentsByTeacher(0);
        return $this->render('TopxiaAdminBundle:Background:statistics/enrollstat.html.twig', array(
            'students' => $students
            ));
    }

    public function dataViewAction(Request $request, $studentId)
    {
        $student = $this->getStudentsService()->getStudent($studentId);

         return new Response('<pre>'.StringToolkit::jsonPettry(StringToolkit::jsonEncode($student)).'</pre>');
    }

    public function auditionstatAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:statistics/auditionstat.html.twig', array(
            ));
    }

    public function customizationstatAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:statistics/customizationstat.html.twig', array(
            ));
    }

    public function leaveSchoolstatAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:statistics/leaveSchoolstat.html.twig', array(
            ));
    }

    public function forSchoolstatAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:Background:statistics/forSchoolstat.html.twig', array(
            ));
    }

    //学校上传图片功能区域
    /*上传图片区域*/
    public function uploadCerAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        return $this->render('TopxiaAdminBundle:Background:school/upload-authCer.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadCerCropAction(Request $request)
    {
       //$user = $this->getUserService()->getUser($id);
        //$user = $this->getCurrentUser();
        $school_id = $this->getCurrentUser()->getSchoolId();
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        // if ($request->getMethod() == 'POST') {
        //     // $options = $request->request->all();
        //     // $schoolAt = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($school_id);
        //     // $schoolAuth = array();
        //     // $schoolAuth['registerCertificate']  = empty($pictureUrl) ? $schoolAt['registerCertificate'] : $pictureUrl;
        //     // $this->getSchoolAuthService()->updateSchoolAuth($id, $schoolAuth);

        //     // return $this->createJsonResponse(true);
        //      return $this->redirect($this->generateUrl('newadmin_authentication'));
        // }

        //list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($school_id);
        $schoolAuth['registerCertificate'] = empty($pictureUrl) ? $schoolAuth['registerCertificate'] : $pictureUrl;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaAdminBundle:Background:school/upload-authCer-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $school_id
        ));
    }

    public function uploadLisAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        return $this->render('TopxiaAdminBundle:Background:school/upload-authLis.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadLisCropAction(Request $request)
    {
      
        $school_id = $this->getCurrentUser()->getSchoolId();
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($school_id);
        $schoolAuth['licenseForSchool']  =  empty($pictureUrl) ? $schoolAuth['licenseForSchool'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaAdminBundle:Background:school/upload-authLis-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $school_id
        ));
    }

    public function uploadPerAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        return $this->render('TopxiaAdminBundle:Background:school/upload-authPer.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadPerCropAction(Request $request)
    {
      
        $school_id = $this->getCurrentUser()->getSchoolId();
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($school_id);
        $schoolAuth['permitOrProject']  =  empty($pictureUrl) ? $schoolAuth['permitOrProject'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaAdminBundle:Background:school/upload-authPer-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $school_id
        ));
    }

    public function uploadAnnAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        return $this->render('TopxiaAdminBundle:Background:school/upload-authAnn.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadAnnCropAction(Request $request)
    {
      
        $school_id = $this->getCurrentUser()->getSchoolId();
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($school_id);
        $schoolAuth['annuaInspection']  =  empty($pictureUrl) ? $schoolAuth['annuaInspection'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaAdminBundle:Background:school/upload-authAnn-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $school_id
        ));
    }

    public function uploadAppAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        return $this->render('TopxiaAdminBundle:Background:school/upload-authApp.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadAppCropAction(Request $request)
    {
      
        $school_id = $this->getCurrentUser()->getSchoolId();
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($school_id);
        $schoolAuth['approvalForm']  =  empty($pictureUrl) ? $schoolAuth['approvalForm'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaAdminBundle:Background:school/upload-authApp-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $school_id
        ));
    }

    public function uploadBusAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        return $this->render('TopxiaAdminBundle:Background:school/upload-authBus.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadBusCropAction(Request $request)
    {
      
        $school_id = $this->getCurrentUser()->getSchoolId();
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($school_id);
        $schoolAuth['businessLicense']  =  empty($pictureUrl) ? $schoolAuth['businessLicense'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaAdminBundle:Background:school/upload-authBus-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $school_id
        ));
    }

    public function uploadSpeAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        return $this->render('TopxiaAdminBundle:Background:school/upload-authSpe.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadSpeCropAction(Request $request)
    {
      
        $school_id = $this->getCurrentUser()->getSchoolId();
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($school_id);
        $schoolAuth['specialProfessional']  =  empty($pictureUrl) ? $schoolAuth['specialProfessional'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaAdminBundle:Background:school/upload-authSpe-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $school_id
        ));
    }

    public function uploadSchAction(Request $request, $id)
    {  
        //学校
        $school = $this->getSchoolsService()->getSchool($id);
        return $this->render('TopxiaAdminBundle:Background:school/upload-picSch.html.twig', array(
            'school' => $school
            ));
    }

    public function uploadSchCropAction(Request $request)
    {
        $school_id = $this->getCurrentUser()->getSchoolId();
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $school = $this->getSchoolsService()->getSchool($school_id);
        $school['logo']  =  empty($pictureUrl) ? $school['logo'] : $pictureUrl ;
        $this->getSchoolsService()->updateSchool($school_id, $school);
        
        return $this->render('TopxiaAdminBundle:Background:school/upload-picSch-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $school_id
        ));
    }

    public function deleteAction(Request $request, $id)
    {
        $this->getFileService()->deleteFile($id);

        return $this->createNewJsonResponse(true);
    }

    public function uploadAction(Request $request)
    {
        return $this->render('TopxiaAdminBundle:File:upload-modal.html.twig');
    }

    protected function getStudentsService()
    {
        return $this->getServiceKernel()->createService('Students.StudentsService');
    }

    protected function getRoleService()
    {
        return $this->getServiceKernel()->createService('Permission:Role.RoleService');
    }

    protected function getNotificationService()
    {
        return $this->getServiceKernel()->createService('User.NotificationService');
    }

    protected function getLogService()
    {
        return $this->getServiceKernel()->createService('System.LogService');
    }

    protected function getSettingService()
    {
        return $this->getServiceKernel()->createService('System.SettingService');
    }

    protected function getSessionService()
    {
        return $this->getServiceKernel()->createService('System.SessionService');
    }

    protected function getTokenService()
    {
        return $this->getServiceKernel()->createService('User.TokenService');
    }

    protected function getCourseService()
    {
        return $this->getServiceKernel()->createService('Course.CourseService');
    }

    protected function getAuthService()
    {
        return $this->getServiceKernel()->createService('User.AuthService');
    }

    protected function getAppService()
    {
        return $this->getServiceKernel()->createService('CloudPlatform.AppService');
    }

    protected function getUserFieldService()
    {
        return $this->getServiceKernel()->createService('User.UserFieldService');
    }

    protected function getNotifiactionService()
    {
        return $this->getServiceKernel()->createService('User.NotificationService');
    }

    protected function getFileService()
    {
        return $this->getServiceKernel()->createService('Content.FileService');
    }

    protected function getOrgService()
    {
        return $this->getServiceKernel()->createService('Org:Org.OrgService');
    }

    protected function getMessageService()
    {
        return $this->getServiceKernel()->createService('User.MessageService');
    }

    protected function getUserService()
    {
        return $this->getServiceKernel()->createService('User.UserService');
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

    protected function getSchoolAuthService()
    {
        return $this->getServiceKernel()->createService('SchoolAuth.SchoolAuthService');
    }

    protected function getLevelService()
    {
        return $this->getServiceKernel()->createService('Level.LevelService');
    }

    protected function getPayService()
    {
        return $this->getServiceKernel()->createService('Pay.PayService');
    }

    protected function getWeiXinService()
    {
        return $this->getServiceKernel()->createService('WeiXin.WeiXinService');
    }

    // 文章资讯
    protected function getArticleService()
    {
        return $this->getServiceKernel()->createService('Article.ArticleService');
    }

    protected function getTagService()
    {
        return $this->getServiceKernel()->createService('Taxonomy.TagService');
    }

    protected function getCategoryService()
    {
        return $this->getServiceKernel()->createService('Article.CategoryService');
    }

    protected function getUploadFileService()
    {
        return $this->createService('File.UploadFileService');
    }

}
