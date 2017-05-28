<?php
namespace Topxia\Service\Common;

use Doctrine\DBAL\Connection as DoctrineConnection;

class Connection extends DoctrineConnection
{
    
    public function update($tableExpression, array $data, array $identifier, array $types = array())
    {
        $this->checkFieldNames(array_keys($data));
        return parent::update($tableExpression, $data, $identifier, $types);
    }

    public function insert($tableExpression, array $data, array $types = array())
    {
        $this->checkFieldNames(array_keys($data));
        return parent::insert($tableExpression, $data, $types);
    }

    public function insertNew($tableExpression, array $data, array $types = array())
    {
        $this->checkFieldNames(array_keys($data));
        return parent::insertNew($tableExpression, $data, $types);
    }

    public function delete($tableExpression, array $data, array $types = array())
    {
        $this->checkFieldNames(array_keys($data));
        return parent::delete($tableExpression, $data, $types);
    }

    // 添加事务相关代码 1.开启事务
    public function beginTransaction()
    {
        return parent::beginTransaction();
    }

    // 提交事务
    public function commit()
    {
        return parent::commit();
    }

    // 回滚事务
    public function rollBack()
    {
        return parent::rollBack();
    }

    public function checkFieldNames($names)
    {
        foreach ($names as $name) {
            if (!ctype_alnum(str_replace('_', '', $name))) {
                throw new \InvalidArgumentException('Field name is invalid.');
            }
        }

        return true;
    }
}
