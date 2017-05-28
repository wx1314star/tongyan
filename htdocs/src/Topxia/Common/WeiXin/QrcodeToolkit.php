<?php
namespace Topxia\Common\WeiXin;
header('Content-Type: image/png');
// error_reporting(E_ERROR);
require_once 'phpqrcode.php';

use Topxia\Common\WeiXin\phpqrcode;

class QrcodeToolkit
{
    static function init($url1)
    {
        $data = urlencode($url1);
        $url = urldecode($data);
        $value = $url;
        ob_clean();
        //require_once 'phpqrcode.php';
        //echo QRcode::png($url1);
        //$error = "L";
        //$matr = "4";
        //$url2 = QRcode::png($url);
        //QRcode::png($value, false, "L", "4", 2);
        //$url2 = QRcode::png($url1,false,$error,$matr);
        return QRcode::png($value);
    }
}
