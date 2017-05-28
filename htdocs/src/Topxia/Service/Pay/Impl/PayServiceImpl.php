<?php
namespace Topxia\Service\Pay\Impl;

use Topxia\Service\Pay\PayService;
use Topxia\Service\Common\BaseService;

class PayServiceImpl extends BaseService implements PayService
{

    protected function getPayDao()
    {
        return $this->createDao('Pay.PayDao');
    }

    public function addPay($pay, $pay_log)
    {
        return $this->getPayDao()->addPay($pay, $pay_log);
    }

    public function updatePay($id, $pay)
    {
        return $this->getPayDao()->updatePay($id, $pay);
    }

    public function deletePay($id)
    {
        return $this->getPayDao()->deletePay($id);
    }

    public function getPay($id)
    {
        return $this->getPayDao()->getPay($id);
    }

    public function getPayByStuId($id)
    {
        return $this->getPayDao()->getPayByStuId($id);
    }

    public function getPayBySms($id)
    {
        return $this->getPayDao()->getPayBySms($id);
    }

    public function findPay($pay_id)
    {
        return $this->getPayDao()->findPay($pay_id);
    }

    public function findAllPay()
    {
        return $this->getPayDao()->findAllPay();
    }
}
