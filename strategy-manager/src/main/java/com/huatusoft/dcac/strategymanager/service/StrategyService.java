package com.huatusoft.dcac.strategymanager.service;


import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.strategymanager.dao.StrategyDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * @author yhj
 * @date 2020-3-20
 */
public interface StrategyService extends BaseService<StrategyEntity, StrategyDao>{

    /**
     * 分页查询
     * @param pageable
     * @param strategyName
     * @param strategyDesc
     * @param updateTime
     * @return
     */
    Page<StrategyEntity> findAllByPage(Pageable pageable,String strategyName,String strategyDesc,String updateTime);
}
