package com.huatusoft.dcac.strategymanager.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.strategymanager.entity.DataClassifySmallEntity;

import java.util.List;

/**
 * @author yhj
 * @date 2020-3-25
 */
public interface DataClassifySmallDao extends BaseDao<DataClassifySmallEntity,String>{

    /**
     * 根据分类名称查询小类
     * @param classifyName
     * @return
     */
    DataClassifySmallEntity findByClassifyName(String classifyName);
}
