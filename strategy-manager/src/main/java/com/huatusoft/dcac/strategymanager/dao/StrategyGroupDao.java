package com.huatusoft.dcac.strategymanager.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyGroupEntity;

import java.util.List;

/**
 * @author yhj
 * @date 2020-4-18
 */
public interface StrategyGroupDao extends BaseDao<StrategyGroupEntity,String> {

    /**
     * 根据创建者查询策略组
     * @param createUserAccount
     * @return
     */
    List<StrategyGroupEntity> findByCreateUserAccount(String createUserAccount);
}
