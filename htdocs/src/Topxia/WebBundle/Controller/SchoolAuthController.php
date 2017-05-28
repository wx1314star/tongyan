<?php
namespace Topxia\WebBundle\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\File\File;
use Topxia\Component\OAuthClient\OAuthClientFactory;

class SchoolAuthController extends BaseController
{
    public function addSchoolAction(Request $request)
    {
        $userLogin = $this -> getCurrentUser();
        if ($request->getMethod() == 'POST') {
            //$userLogin = $this -> getCurrentUser();
            $school = $request->request->get('schools');
            $schoolOld = $this->getSchoolsService()->getSchoolByCName($school['chineseName']);
            if(false != $schoolOld){
                $this->setFlashMessage('error', $this->getServiceKernel()->trans('该学校已经注册，请登录进学校管理后台更新学校信息!!'));
                return $this->redirect($this->generateUrl('newadmin')); 
            }
            $userName = $request->request->get('userName');
            if(0 != $userLogin['id']){          
                $user = $this->getUserService()->getUserByNickname($userName);
                if(null != $user){
                    $school['userId'] = $user['id'];
                    $school = $this->getSchoolsService()->addSchool(0, $school);
                    $newUser = $this->getUserService()->getUser($user['id']);
                    $newUser['schoolId'] = $school['id'];
                    $this->getUserService()->updateUser($newUser['id'], $newUser);
                    //$birthday = date("Y-m-d", $student['birthday']);
          
                    $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息保存成功。'));
             
                    return $this->redirect($this->generateUrl('schoolAuth_add', array('id' => $school['id'])));
                }else{
                    $this->setFlashMessage('error', $this->getServiceKernel()->trans('该用户没有注册，请注册!!'));
                    return $this->redirect($this->generateUrl('register'));
                }
            }else{
                 $school['userId'] = $userLogin['id'];
                 $school = $this->getSchoolsService()->addSchool(0, $school);
                 $newUser = $this->getUserService()->getUser($userLogin['id']);
                 $newUser['schoolId'] = $school['id'];
                 $this->getUserService()->updateUser($newUser['id'], $newUser);
                //$birthday = date("Y-m-d", $student['birthday']);
          
                 $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息保存成功。'));
             
                 return $this->redirect($this->generateUrl('schoolAuth_add', array('id' => $school['id'])));
            }
            
        }
        //未登录跳转到注册页面
        if(0 == $userLogin['id']){
            return $this->redirect($this->generateUrl('register'));   
        }
        $userName = $userLogin['nickname'];
        $provinces = $this->getProvinceService()->findAll();

        $citys = $this->getCityService()->findAll();

        //$school = $this->getSchoolsService()->getSchools($id);

        //$schools = $this->getSchoolsService()->findAll(0);

        return $this->render('TopxiaWebBundle:School:add-school.html.twig', array(
            'provinces' => $provinces,
            'citys'     => $citys,
            'userName'  => $userName
            ));
    }

    public function addSchoolAuthAction(Request $request, $id)
    {
        $user = $this->getCurrentUser();
        //$id = $user->getSchoolId();
       
        $flag = 1;
        $name = "";
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId((int)$id);
         if(null != $id){
             $school = $this->getSchoolsService()->getSchool((int)$id);
        }else if(null != $schoolAuth['school_id']){
             $school = $this->getSchoolsService()->getSchool($schoolAuth['school_id']);
        }
        if(null != $school['institutionsType'] && $school['institutionsType'] == 0){
            $flag = 1;
            $name = "学校";
        }else if(null != $school['institutionsType'] && $school['institutionsType'] == 0){
            $flag = 2;
            $name = "培训机构";
        }
       
       
        return $this->render('TopxiaWebBundle:SchoolAuth:add-schoolAuth.html.twig', array(
                'school_id' => $id,
                'name'      => $name,
                // 'user' => $user,
                'flag'      => $flag
                ));
        
    }

    

    public function updateSchoolAuthAction(Request $request, $id)
    {
        if ($request->getMethod() == 'POST') {
            $schoolAuth = $request->request->get('schoolAuth');

            $this->getSchoolAuthService()->updateSchoolAuth($id, $schoolAuth);
          
            $this->setFlashMessage('success', $this->getServiceKernel()->trans('基础信息更新成功。'));
             
            return $this->redirect($this->generateUrl('homepage'));
        }

        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuth($id);

        return $this->render('TopxiaWebBundle:SchoolAuth:update-schoolAuth.html.twig', array(
            'schoolAuth' => $schoolAuth,
            'school_id' => $schoolAuth['school_id']
            ));
    }

     //学校上传图片功能区域
    /*上传图片区域*/
    public function uploadCerAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        if(null == $schoolAuth){
            $sa = array(
                'school_id' => $id
            );
            $schoolAuth = $this->getSchoolAuthService()->addSchoolAuth($id, $sa);
        }
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authCer.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadCerCropAction(Request $request, $id)
    {
        //$user = $this->getUserService()->getUser($id);
        //$user = $this->getCurrentUser();
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
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        $schoolAuth['registerCertificate'] = empty($pictureUrl) ? $schoolAuth['registerCertificate'] : $pictureUrl;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authCer-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $id
        ));
    }

    public function uploadLisAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        if(null == $schoolAuth){
            $sa = array(
                'school_id' => $id
            );
            $schoolAuth = $this->getSchoolAuthService()->addSchoolAuth($id, $sa);
        }
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authLis.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadLisCropAction(Request $request, $id)
    {
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        $schoolAuth['licenseForSchool']  =  empty($pictureUrl) ? $schoolAuth['licenseForSchool'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authLis-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $id
        ));
    }

    public function uploadPerAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        if(null == $schoolAuth){
            $sa = array(
                'school_id' => $id
            );
            $schoolAuth = $this->getSchoolAuthService()->addSchoolAuth($id, $sa);
        }
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authPer.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadPerCropAction(Request $request, $id)
    {
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        $schoolAuth['permitOrProject']  =  empty($pictureUrl) ? $schoolAuth['permitOrProject'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authPer-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $id
        ));
    }

    public function uploadAnnAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        if(null == $schoolAuth){
            $sa = array(
                'school_id' => $id
            );
            $schoolAuth = $this->getSchoolAuthService()->addSchoolAuth($id, $sa);
        }
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authAnn.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadAnnCropAction(Request $request, $id)
    {
      
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        $schoolAuth['annuaInspection']  =  empty($pictureUrl) ? $schoolAuth['annuaInspection'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authAnn-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $id
        ));
    }

    public function uploadAppAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        if(null == $schoolAuth){
            $sa = array(
                'school_id' => $id
            );
            $schoolAuth = $this->getSchoolAuthService()->addSchoolAuth($id, $sa);
        }
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authApp.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadAppCropAction(Request $request, $id)
    {
      
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        $schoolAuth['approvalForm']  =  empty($pictureUrl) ? $schoolAuth['approvalForm'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authApp-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $id
        ));
    }

    public function uploadBusAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        if(null == $schoolAuth){
            $sa = array(
                'school_id' => $id
            );
            $schoolAuth = $this->getSchoolAuthService()->addSchoolAuth($id, $sa);
        }
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authBus.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadBusCropAction(Request $request, $id)
    {
      
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        $schoolAuth['businessLicense']  =  empty($pictureUrl) ? $schoolAuth['businessLicense'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authBus-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $id
        ));
    }

    public function uploadSpeAction(Request $request, $id)
    {  
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        if(null == $schoolAuth){
            $sa = array(
                'school_id' => $id
            );
            $schoolAuth = $this->getSchoolAuthService()->addSchoolAuth($id, $sa);
        }
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authSpe.html.twig', array(
            'schoolAuth' => $schoolAuth
            ));
    }

    public function uploadSpeCropAction(Request $request, $id)
    {
      
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        $schoolAuth = $this->getSchoolAuthService()->getSchoolAuthBySchoolId($id);
        $schoolAuth['specialProfessional']  =  empty($pictureUrl) ? $schoolAuth['specialProfessional'] : $pictureUrl ;
        $this->getSchoolAuthService()->updateSchoolAuth($schoolAuth['id'], $schoolAuth);
        
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-authSpe-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $id
        ));
    }


    public function uploadSchAction(Request $request, $id)
    {  
        //学校
        $school = $this->getSchoolsService()->getSchool($id);
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-picSch.html.twig', array(
            'school' => $school
            ));
    }

    public function uploadSchCropAction(Request $request, $id)
    {
        $school = $this->getSchoolsService()->getSchool($id);
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        //$school = $this->getSchoolsService()->getSchool($school_id);
        $school['logo']  =  empty($pictureUrl) ? $school['logo'] : $pictureUrl ;
        $school = $this->getSchoolsService()->updateSchool($id, $school);
        
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-picSch-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $id
        ));
    }
    
    public function uploadOneAction(Request $request, $id)
    {  
        //学校
        $school = $this->getSchoolsService()->getSchool($id);
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-picOne.html.twig', array(
            'school' => $school
            ));
    }

    public function uploadOneCropAction(Request $request, $id)
    {
        $school = $this->getSchoolsService()->getSchool($id);
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        //$school = $this->getSchoolsService()->getSchool($school_id);
        $school['smallPicture']  =  empty($pictureUrl) ? $school['smallPicture'] : $pictureUrl ;
        $school = $this->getSchoolsService()->updateSchool($id, $school);
        
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-picOne-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $id
        ));
    }

    public function uploadTwoAction(Request $request, $id)
    {  
        //学校
        $school = $this->getSchoolsService()->getSchool($id);
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-picTwo.html.twig', array(
            'school' => $school
            ));
    }

    public function uploadTwoCropAction(Request $request, $id)
    {
        $school = $this->getSchoolsService()->getSchool($id);
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        //$school = $this->getSchoolsService()->getSchool($school_id);
        $school['middlePicture']  =  empty($pictureUrl) ? $school['middlePicture'] : $pictureUrl ;
        $school = $this->getSchoolsService()->updateSchool($id, $school);
        
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-picTwo-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $id
        ));
    }

    public function uploadThreeAction(Request $request, $id)
    {  
        //学校
        $school = $this->getSchoolsService()->getSchool($id);
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-picThree.html.twig', array(
            'school' => $school
            ));
    }

    public function uploadThreeCropAction(Request $request, $id)
    {
        $school = $this->getSchoolsService()->getSchool($id);
        $fileId = $request->getSession()->get("fileId");
        list($pictureUrl, $naturalSize, $scaledSize) = $this->getFileService()->getImgFileMetaInfo($fileId, 700, 300);
        //$school = $this->getSchoolsService()->getSchool($school_id);
        $school['largePicture']  =  empty($pictureUrl) ? $school['largePicture'] : $pictureUrl ;
        $school = $this->getSchoolsService()->updateSchool($id, $school);
        
        return $this->render('TopxiaWebBundle:SchoolAuth:upload-picThree-crop.html.twig', array(
            'pictureUrl'  => $pictureUrl,
            'naturalSize' => $naturalSize,
            'scaledSize'  => $scaledSize,
            'school_id'   => $id
        ));
    }

    protected function getFileService()
    {
        return $this->getServiceKernel()->createService('Content.FileService');
    }

    protected function getUserService()
    {
        return $this->getServiceKernel()->createService('User.UserService');
    }

    protected function getSchoolsService()
    {
        return $this->getServiceKernel()->createService('Schools.SchoolsService');
    }

    protected function getSchoolAuthService()
    {
        return $this->getServiceKernel()->createService('SchoolAuth.SchoolAuthService');
    }

    protected function getProvinceService()
    {
        return $this->getServiceKernel()->createService('Province.ProvinceService');
    }

    protected function getCityService()
    {
        return $this->getServiceKernel()->createService('City.CityService');
    }
}