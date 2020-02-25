/**
 * @author yhj
 * @date 2019-11-4
 */
package com.huatusoft.dcac.securitystrategycenter.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.organizationalstrucure.entity.SoftWareEntity;

public interface SoftWareDao extends BaseDao<SoftWareEntity,String>{
    /**
     * 通过软件名统计数量
     * @param softName
     * @return
     */
    Integer countBySoftName(String softName);
}
