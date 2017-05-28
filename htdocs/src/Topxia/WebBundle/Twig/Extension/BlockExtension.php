<?php
namespace Topxia\WebBundle\Twig\Extension;

use Topxia\Service\Common\ServiceKernel;
use Topxia\Common\BlockToolkit;

class BlockExtension extends \Twig_Extension
{
    protected $container;

    public function __construct($container)
    {
        $this->container = $container;
    }

    public function getFilters()
    {
        return array(
        );
    }

    public function getFunctions()
    {
        return array(
            new \Twig_SimpleFunction('block_show', array($this, 'showBlock'), array('is_safe' => array('html')))
        );
    }

    public function showBlock($code)
    {
        $block = ServiceKernel::instance()->createService('Content.BlockService')->getBlockByCode($code);
        if (empty($block)) {
            return '';
        }

        $env = $this->container->getParameter('kernel.environment');

        if ($env == 'prod') {
            $content = $block['content'];
        } else {
            $content = BlockToolkit::render($block, $this->container);
        }

        $content = $this->container->get('topxia.twig.web_extension')->cdn($content);

        return $content;
    }

    public function getName()
    {
        return 'topxia_block_twig';
    }
}