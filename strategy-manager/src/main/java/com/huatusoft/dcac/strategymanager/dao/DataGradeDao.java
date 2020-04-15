package com.huatusoft.dcac.strategymanager.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.strategymanager.entity.DataGradeEntity;

import java.util.List;

/**
 * @author yhj
 * @date 2020-3-20
 */
public interface DataGradeDao extends BaseDao<DataGradeEntity,String> {

    /**
     * 根据分级名称查询
     * @param gradeName
     * @return
     */
    DataGradeEntity findByGradeName(String gradeName);
}
