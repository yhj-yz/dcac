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

    /**
     * 根据id数组查询策略
     * @param ids
     * @return
     */
    List<StrategyEntity> findByIdIn(String[] ids);

    /**
     * 根据策略名称查询策略信息
     * @param strategyName
     * @return
     */
    StrategyEntity findByStrategyName(String strategyName);
}
