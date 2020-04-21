package com.huatusoft.dcac.strategymanager.service;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.strategymanager.dao.StrategyGroupDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;
import com.huatusoft.dcac.strategymanager.entity.StrategyGroupEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * @author yhj
 * @date 2020-4-18
 */
public interface StrategyGroupService extends BaseService<StrategyGroupEntity, StrategyGroupDao> {

    /**
     * 分页查询
     * @param pageable
     * @param groupName
     * @param groupDesc
     * @param createUserAccount
     * @return
     */
    Page<StrategyGroupEntity> findAllByPage(Pageable pageable, String groupName, String groupDesc,String createUserAccount);

    /**
     * 添加组策略
     * @param groupName
     * @param groupDesc
     * @param strategyId
     * @return
     */
    Result addStrategyGroup(String groupName,String groupDesc,String strategyId);

    /**
     * 根据id获取组策略详情
     * @param id
     * @return
     */
    StrategyGroupEntity findById(String id);

    /**
     * 更新组策略
     * @param groupId
     * @param groupName
     * @param groupDesc
     * @param strategyId
     * @return
     */
    Result updateStrategyGroup(String groupId,String groupName,String groupDesc,String strategyId);
}
