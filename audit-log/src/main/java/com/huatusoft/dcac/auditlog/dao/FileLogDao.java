/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.auditlog.dao;

import com.huatusoft.dcac.auditlog.entity.FileLogEntity;
import com.huatusoft.dcac.base.dao.BaseDao;

public interface FileLogDao extends BaseDao<FileLogEntity,String>{

    /**
     * 根据guid查询数量
     * @param guid
     * @return
     */
    Integer countByGuidLike(String guid);
}
