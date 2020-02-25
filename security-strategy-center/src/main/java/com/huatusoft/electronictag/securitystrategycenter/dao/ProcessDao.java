/**
 * @author yhj
 * @date 2019-11-5
 */
package com.huatusoft.electronictag.securitystrategycenter.dao;

import com.huatusoft.electronictag.base.dao.BaseDao;
import com.huatusoft.electronictag.organizationalstrucure.entity.ProcessEntity;

import java.util.List;

public interface ProcessDao extends BaseDao<ProcessEntity,String>{
    /**
     * 通过进程名获取进程对象
     * @param processName
     * @return
     */
    List<ProcessEntity> findByProcessName(String processName);
}
