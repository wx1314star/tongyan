<?php

/**
 * 
 * 微信支付API异常类
 * @author wx
 *
 */
class WxPayException extends Exception {
	public function errorMessage()
	{
		return $this->getMessage();
	}
}
