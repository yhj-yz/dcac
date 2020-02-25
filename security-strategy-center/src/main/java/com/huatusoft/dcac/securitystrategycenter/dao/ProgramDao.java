/**
 * @author yhj
 * @date 2019-10-18
 */
package com.huatusoft.dcac.securitystrategycenter.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.organizationalstrucure.entity.ProgramEntity;

import java.util.List;

public interface ProgramDao extends BaseDao<ProgramEntity,String>{

    /**
     * 根据isconfig和parentId查询
     * @param isconfig
     * @param parentId
     * @return
     */
    List<ProgramEntity> findByIsConfigAndParentId(Integer isconfig,String parentId);
}
