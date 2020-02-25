/**
 * @author yhj
 * @date 2019-10-18
 */
package com.huatusoft.electronictag.securitystrategycenter.service.impl;

import com.huatusoft.electronictag.base.service.BaseServiceImpl;
import com.huatusoft.electronictag.organizationalstrucure.entity.ProgramEntity;
import com.huatusoft.electronictag.securitystrategycenter.dao.ProgramDao;
import com.huatusoft.electronictag.securitystrategycenter.service.ProgramService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProgramServiceImpl extends BaseServiceImpl<ProgramEntity, ProgramDao> implements ProgramService{
    @Autowired
    private ProgramDao programDao;

    @Override
    public List<ProgramEntity> findByIsConfigAndParentId(Integer isConfig, String parentId) {
        return programDao.findByIsConfigAndParentId(isConfig,parentId);
    }
}
