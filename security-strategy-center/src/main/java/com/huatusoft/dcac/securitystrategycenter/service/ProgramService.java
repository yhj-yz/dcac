/**
 * @author yhj
 * @date 2019-10-18
 */
package com.huatusoft.dcac.securitystrategycenter.service;

import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.organizationalstrucure.entity.ProgramEntity;
import com.huatusoft.dcac.securitystrategycenter.dao.ProgramDao;

import java.util.List;

public interface ProgramService extends BaseService<ProgramEntity, ProgramDao>{

    /**
     * 根据isconfig和parentId查询
     * @param isConfig
     * @param parentId
     * @return
     */
    List<ProgramEntity> findByIsConfigAndParentId(Integer isConfig,String parentId);
}
