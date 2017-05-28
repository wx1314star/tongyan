<?php
namespace Topxia\Service\Pay;

interface PayService
{
  public function addPay($pay, $pay_log);

  public function getPay($id);

  public function getPayByStuId($id);

  public function getPayBySms($id);

  public function updatePay($id, $pay);

  public function deletePay($id);

  public function findPay($pay_id);

  public function findAllPay();
}