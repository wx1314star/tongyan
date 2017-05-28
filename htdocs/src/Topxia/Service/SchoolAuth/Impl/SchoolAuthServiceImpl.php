<?php
namespace Topxia\Service\SchoolAuth\Impl;

use Topxia\Service\SchoolAuth\SchoolAuthService;
use Topxia\Service\Common\BaseService;

class SchoolAuthServiceImpl extends BaseService implements SchoolAuthService
{
    protected function getSchoolAuthDao()
    {
        return $this->createDao('SchoolAuth.SchoolAuthDao');
    }

    public function findAll($institutionsType)
    {
        return $this->getSchoolAuthDao()->findAll($institutionsType);
    }

    public function getSchoolAuthBySchoolId($school_id)
    {
        return $this->getSchoolAuthDao()->getSchoolAuthBySchoolId($school_id);
    }

    public function getSchoolAuth($id)
    {
        return $this->getSchoolAuthDao()->getSchoolAuth($id);
    }

    public function addSchoolAuth($id, $fields)
    {
        $schoolAuth = array();
        
        $schoolAuth['school_id']            = empty($fields['school_id']) ? 0 : $fields['school_id'];
        $schoolAuth['registerCertificate']  = empty($fields['registerCertificate']) ? '' : $fields['registerCertificate'];
        $schoolAuth['licenseForSchool']     = empty($fields['licenseForSchool']) ? '' : $fields['licenseForSchool'];
        $schoolAuth['permitOrProject']      = empty($fields['permitOrProject']) ? '' : $fields['permitOrProject'];
        $schoolAuth['annuaInspection']      = empty($fields['annuaInspection']) ? '' : $fields['annuaInspection'];
        $schoolAuth['approvalForm']         = empty($fields['approvalForm']) ? '' : $fields['approvalForm'];
        $schoolAuth['specialProfessional']  = empty($fields['specialProfessional']) ? '' : $fields['specialProfessional'];
        $schoolAuth['businessLicense']      = empty($fields['businessLicense']) ? '' : $fields['businessLicense'];
        $schoolAuth['type']                 = empty($fields['type']) ? 0 : $fields['type'];

        $sa = $this->getSchoolAuthDao()->addSchoolAuth($schoolAuth);

        return $sa;
    }

    public function deleteSchoolAuth($id)
    {
        $school = $this->getSchoolsDao().getSchool($id);
        //$school['status']                = empty($school['status']) ? 0 : $school['status'];
        return $this->getSchoolsDao()->updateSchool($id, $school);
    }

    public function updateSchoolAuth($id, $fields)
    {
        $schoolAuth = array();
        
        $schoolAuth['school_id']            = empty($fields['school_id']) ? 0 : $fields['school_id'];
        $schoolAuth['registerCertificate']  = empty($fields['registerCertificate']) ? '' : $fields['registerCertificate'];
        $schoolAuth['licenseForSchool']     = empty($fields['licenseForSchool']) ? '' : $fields['licenseForSchool'];
        $schoolAuth['permitOrProject']      = empty($fields['permitOrProject']) ? '' : $fields['permitOrProject'];
        $schoolAuth['annuaInspection']      = empty($fields['annuaInspection']) ? '' : $fields['annuaInspection'];
        $schoolAuth['approvalForm']         = empty($fields['approvalForm']) ? '' : $fields['approvalForm'];
        $schoolAuth['specialProfessional']  = empty($fields['specialProfessional']) ? '' : $fields['specialProfessional'];
        $schoolAuth['businessLicense']      = empty($fields['businessLicense']) ? '' : $fields['businessLicense'];
        $schoolAuth['type']                 = empty($fields['type']) ? 0 : $fields['type'];

        return $this->getSchoolAuthDao()->updateSchoolAuth($id, $schoolAuth);
    }
}