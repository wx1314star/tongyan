<?php
namespace Topxia\Common;

use Topxia\Common\CurlToolkit;

class SmsToolkit
{
	public static function smsCheck($request, $scenario)
		    {
		list($sessionField, $requestField) = self::paramForSmsCheck($request, $scenario);
		$result                            = self::checkSms($sessionField, $requestField, $scenario);
		self::clearSmsSession($request, $scenario);
		return array($result, $sessionField, $requestField);
	}
	
	private static function paramForSmsCheck($request, $scenario)
		    {
		$sessionField             = $request->getSession()->get($scenario);
		$sessionField['sms_type'] = $scenario;
		
		$requestField['sms_code'] = $request->request->get('sms_code');
		$requestField['mobile']   = $request->request->get('mobile');
		
		return array($sessionField, $requestField);
	}
	
	
	
	/**
	* @param  array     $sessionField 必须包含元素：'sms_type' 'sms_last_time' 'sms_code' 'to'
		     * @param  array     $requestField 必须包含元素：'sms_code' 'mobile'
		     * @return boolean
		     */
		    private static function checkSms($sessionField, $requestField, $scenario, $allowedTime = 1800)
		    {
		$smsType = $sessionField['sms_type'];
		if ((strlen($smsType) == 0) || (strlen($scenario) == 0)) {
			return false;
		}
		if ($smsType != $scenario) {
			return false;
		}
		
		$currentTime = time();
		$smsLastTime = $sessionField['sms_last_time'];
		if ((strlen($smsLastTime) == 0) || (($currentTime - $smsLastTime) > $allowedTime)) {
			return false;
		}
		
		$smsCode       = $sessionField['sms_code'];
		$smsCodePosted = $requestField['sms_code'];
		if ((strlen($smsCodePosted) == 0) || (strlen($smsCode) == 0)) {
			return false;
		}
		if ($smsCode != $smsCodePosted) {
			return false;
		}
		
		$to     = $sessionField['to'];
		$mobile = $requestField['mobile'];
		if ((strlen($to) == 0) || (strlen($mobile) == 0)) {
			return false;
		}
		if ($to != $mobile) {
			return false;
		}
		
		return true;
	}
	
	public static function clearSmsSession($request, $scenario)
		    {
		$request->getSession()->set($scenario, array(
				            'to'            => '',
				            'sms_code'      => '',
				            'sms_last_time' => '',
				            'sms_type'      => ''
				        ));
	}
	
	public static function getShortLink($url)
		    {
		$apis = array(
				            'baidu' => 'http://dwz.cn/create.php',
				            'qq'    => 'http://qqurl.com/create/'
				        );
		
		foreach ($apis as $key => $api) {
			$response = CurlToolkit::request('POST', $api, array('url' => $url));
			if ($response['status'] != 0) {
				continue;
			}
			else {
				if ($key == 'baidu') {
					return $response['tinyurl'];
				}
				else {
					return $response['short_url'];
				}
			}
		}
		
		return '';
	}
	
	public static function sendSMS($mobile, $contentin)
		{
		//短信接口的URL
		$sendUrl = 'http://v.juhe.cn/sms/send';
		//PHP连接字符串不是+号是.号
        $con = strval("#code#="."".$contentin);
        $tpl_value = urlencode($con);
		
		$smsConf = array(
				    'key'   => '961c6129ae169dd12f7ee61b724eacc4', //您申请的APPKEY
				    'mobile'    => $mobile, //接受短信的用户手机号码
				    'tpl_id'    => '33057', //您申请的短信模板ID，根据实际情况修改
				    'tpl_value' => $tpl_value//您设置的模板变量，根据实际情况修改
				);
		
		$content = self::juhecurl($sendUrl,$smsConf,1);
		//请求发送短信
		
		if($content){
			$result = json_decode($content,true);
			$error_code = $result['error_code'];
			if($error_code == 0){
				//状态为0，说明短信发送成功
				//echo "短信发送成功,短信ID：".$result['result']['sid'];
				return true;
			}
			else{
				//状态非0，说明失败
				$msg = $result['reason'];
				//echo "短信发送失败(".$error_code.")：".$msg;
				return false;
			}
		}
		else{
			//返回内容异常，以下可根据业务逻辑自行修改
			//echo "请求发送短信失败";
			return false;
		}
	}
	
	
	/**
	* 请求接口返回内容
	 * @param  string $url [请求的URL地址]
	 * @param  string $params [请求的参数]
	 * @param  int $ipost [是否采用POST形式]
	 * @return  string
	 */
	public static function juhecurl($url,$params=false,$ispost=0)
    {
		$httpInfo = array();
		$ch = curl_init();
		curl_setopt( $ch, CURLOPT_HTTP_VERSION , CURL_HTTP_VERSION_1_1 );
		curl_setopt( $ch, CURLOPT_USERAGENT , 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22' );
		curl_setopt( $ch, CURLOPT_CONNECTTIMEOUT , 30 );
		curl_setopt( $ch, CURLOPT_TIMEOUT , 30);
		curl_setopt( $ch, CURLOPT_RETURNTRANSFER , true );
		if( $ispost )
		    {
			curl_setopt( $ch , CURLOPT_POST , true );
			curl_setopt( $ch , CURLOPT_POSTFIELDS , $params );
			curl_setopt( $ch , CURLOPT_URL , $url );
		}
		else
		    {
			if($params){
				curl_setopt( $ch , CURLOPT_URL , $url.'?'.$params );
			}
			else{
				curl_setopt( $ch , CURLOPT_URL , $url);
			}
		}
		$response = curl_exec( $ch );
		if ($response === FALSE) {
			//e			cho "cURL Error: " . curl_error($ch);
			return false;
		}
		$httpCode = curl_getinfo( $ch , CURLINFO_HTTP_CODE );
		$httpInfo = array_merge( $httpInfo , curl_getinfo( $ch ) );
		curl_close( $ch );
		return $response;
	}
}
