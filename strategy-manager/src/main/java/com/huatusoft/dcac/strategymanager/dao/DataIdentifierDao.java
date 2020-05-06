package com.huatusoft.dcac.strategymanager.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.strategymanager.entity.DataIdentifierEntity;

/**
 * @author yhj
 * @date 2020-3-27
 */
public interface DataIdentifierDao extends BaseDao<DataIdentifierEntity,String>{

    /**
     * 根据数据标识符名查询数据标识符信息
     * @param identifierName
     * @return
     */
    DataIdentifierEntity findByIdentifierName(String identifierName);

}
