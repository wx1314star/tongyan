<?php
namespace Topxia\Service\Schools\Impl;

use Topxia\Service\Schools\SchoolsService;
use Topxia\Service\Common\BaseService;

class SchoolsServiceImpl extends BaseService implements SchoolsService
{
   
    protected function getSchoolsDao()
    {
        return $this->createDao('Schools.SchoolsDao');
    }

    public function findAll($institutionsType)
    {
        return $this->getSchoolsDao()->findAll($institutionsType);
    }

    public function findAllByNum($number)
    {
        return $this->getSchoolsDao()->findAllByNum($number);
    }

    public function findSchoolByNewTime()
    {
        return $this->getSchoolsDao()->findSchoolByNewTime();
    }

    public function findSchoolByCity($city_id)
    {
        return $this->getSchoolsDao()->findSchoolByCity($city_id);
    }
    public function getSchool($id)
    {
        return $this->getSchoolsDao()->getSchool($id);
    }

    public function getSchoolByCName($CName)
    {
        return $this->getSchoolsDao()->getSchoolByCName($CName);
    }

     /*添加学生信息*/
    public function addSchool($id, $fields)
    {
        //$school = $this->getSchool($id);

        /*$fields = ArrayToolkit::filter($fields, array(
            'chineseName'       => '',
            'englishName'       => '',
            'abbreviation'      => '',
            'type'              => '',
            'schoolAddress'     => '',
            'campusHumanities'  => '',
      'campusAmorousFeelings'   => ''
        ));*/
        $school = array();
        
        $school['chineseName']            = empty($fields['chineseName']) ? '' : $fields['chineseName'];
        $school['englishName']            = empty($fields['englishName']) ? '' : $fields['englishName'];
        $school['abbreviation']           = empty($fields['abbreviation']) ? '' : $fields['abbreviation'];
        $school['type']                   = empty($fields['type']) ? '' : $fields['type'];
        $school['schoolAddress']          = empty($fields['schoolAddress']) ? '' : $fields['schoolAddress'];
        $school['province_id']            = empty($fields['province_id']) ? 1 : $fields['province_id'];
        $school['city_id']                = empty($fields['city_id']) ? 1 : $fields['city_id'];
         $school['status']                = isset($fields['status']) ? $fields['status'] : 1  ;
        $school['smallPicture']           = empty($fields['smallPicture']) ? '' : $fields['smallPicture'];
        $school['middlePicture']          = empty($fields['middlePicture']) ? '' : $fields['middlePicture'];
        $school['largePicture']           = empty($fields['largePicture']) ? '' : $fields['largePicture'];

        $school['createTime']             = time();
        if (!empty($fields['campusHumanities'])) {
            $school['campusHumanities'] = $this->purifyHtml($fields['campusHumanities']);
        }

        //$school['campusHumanities']       = empty($fields['campusHumanities']) ? '' : $fields['campusHumanities'];
        if (!empty($fields['campusAmorousFeelings'])) {
            $school['campusAmorousFeelings'] = $this->purifyHtml($fields['campusAmorousFeelings']);
        }

        //$school['campusAmorousFeelings']  = empty($fields['campusAmorousFeelings']) ? '' : $fields['campusAmorousFeelings'];


        //$school['createdTime'] = time();

        $schools = $this->getSchoolsDao()->addSchool($school);

        //$this->dispatchEvent('school.add', new ServiceEvent(array('school' => $school, 'fields' => $fields)));

        //$this->getDispatcher()->dispatch('school.add', new ServiceEvent($schools));

        return $schools;
    }

    public function deleteSchool($id)
    {
        //return $this->getSchoolsDao()->deleteSchool($id);
        $school = $this->getSchoolsDao().getSchool($id);
        $school['status']                = empty($school['status']) ? 1 : $school['status'];
        return $this->getSchoolsDao()->updateSchool($id, $school);

    }

    public function updateSchool($id, $fields)
    {
        $school = array();
        
        $school['chineseName']            = empty($fields['chineseName']) ? '' : $fields['chineseName'];
        $school['englishName']            = empty($fields['englishName']) ? '' : $fields['englishName'];
        $school['abbreviation']           = empty($fields['abbreviation']) ? '' : $fields['abbreviation'];
        $school['type']                   = empty($fields['type']) ? '' : $fields['type'];
        $school['schoolAddress']          = empty($fields['schoolAddress']) ? '' : $fields['schoolAddress'];

        $school['smallPicture']           = empty($fields['smallPicture']) ? '' : $fields['smallPicture'];
        $school['middlePicture']          = empty($fields['middlePicture']) ? '' : $fields['middlePicture'];
        $school['largePicture']           = empty($fields['largePicture']) ? '' : $fields['largePicture'];

        $school['province_id']            = empty($fields['province_id']) ? 1 : $fields['province_id'];
        $school['city_id']                = empty($fields['city_id']) ? 1 : $fields['city_id'];
        $school['status']                 = isset($fields['status']) ? $fields['status'] : 1  ;
        $school['updateTime']             = time();
        //$school['status']                = empty($fields['status']) ? 1 : $fields['status'];
        if (!empty($fields['campusHumanities'])) {
            $school['campusHumanities'] = $this->purifyHtml($fields['campusHumanities']);
        }

        //$school['campusHumanities']       = empty($fields['campusHumanities']) ? '' : $fields['campusHumanities'];
        if (!empty($fields['campusAmorousFeelings'])) {
            $school['campusAmorousFeelings'] = $this->purifyHtml($fields['campusAmorousFeelings']);
        }

        return $this->getSchoolsDao()->updateSchool($id, $school);
    }
}
