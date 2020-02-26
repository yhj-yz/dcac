/**
 * @author yhj
 * @date 2019-11-5
 */
package com.huatusoft.dcac.securitystrategycenter.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.organizationalstrucure.entity.ProcessEntity;

import java.util.List;

public interface ProcessDao extends BaseDao<ProcessEntity,String>{
    /**
     * 通过进程名获取进程对象
     * @param processName
     * @return
     */
    List<ProcessEntity> findByProcessName(String processName);
}
