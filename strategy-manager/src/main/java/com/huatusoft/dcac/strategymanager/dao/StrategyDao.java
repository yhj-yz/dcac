package com.huatusoft.dcac.strategymanager.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;

import java.util.List;

/**
 * @author yhj
 * @date 2020-3-20
 */
public interface StrategyDao extends BaseDao<StrategyEntity,String> {

    /**
     * 根据用户名查找用户所有的策略
     * @param createUserAccount
     * @return
     */
    List<StrategyEntity> findByCreateUserAccount(String createUserAccount);
}
