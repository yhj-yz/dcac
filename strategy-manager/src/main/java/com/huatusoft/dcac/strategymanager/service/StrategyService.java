package com.huatusoft.dcac.strategymanager.service;


import com.huatusoft.dcac.base.response.Result;
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

    /**
     * 添加策略
     * @param strategyName
     * @param strategyDesc
     * @param dataClassifyName
     * @param dataGradeName
     * @param scanType
     * @param ruleName
     * @param responseType
     * @param maskRuleName
     * @return
     */
    Result addStrategy(String strategyName, String strategyDesc, String dataClassifyName, String dataGradeName, String scanType, String ruleName, String responseType, String maskRuleName);

    /**
     * 根据id生成策略
     * @param id
     * @return
     * @throws Exception
     */
    String getStrategyById(String id) throws Exception;

    /**
     * 更新策略
     * @param strategyName
     * @param strategyDesc
     * @param dataClassifyName
     * @param dataGradeName
     * @param scanType
     * @param ruleName
     * @param responseType
     * @param maskRuleName
     * @return
     */
    Result updateStrategy(String strategyId,String strategyName,String strategyDesc,String dataClassifyName,String dataGradeName,String scanType,String ruleName,String responseType,String maskRuleName);
}
