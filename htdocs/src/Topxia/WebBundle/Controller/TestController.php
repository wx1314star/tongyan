<?php
namespace Topxia\WebBundle\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Filesystem\Filesystem;
use Topxia\Service\Util\CloudClientFactory;


class TestController extends BaseController
{
    public function indexAction(Request $request)
    {

        return $this->render('TopxiaWebBundle:Test:test.html.twig');

    }

    private function getCourseService()
    {
        return $this->getServiceKernel()->createService('Course.CourseService');
    }

    private function getCloudClient()
    {
        if(empty($this->cloudClient)) {
            $factory = new CloudClientFactory();
            $this->cloudClient = $factory->createClient();
        }
        return $this->cloudClient;
    }
    
}