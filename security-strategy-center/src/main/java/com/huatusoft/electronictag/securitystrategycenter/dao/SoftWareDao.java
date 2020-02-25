/**
 * @author yhj
 * @date 2019-11-4
 */
package com.huatusoft.electronictag.securitystrategycenter.dao;

import com.huatusoft.electronictag.base.dao.BaseDao;
import com.huatusoft.electronictag.organizationalstrucure.entity.SoftWareEntity;

import java.util.List;

public interface SoftWareDao extends BaseDao<SoftWareEntity,String>{
    /**
     * 通过软件名统计数量
     * @param softName
     * @return
     */
    Integer countBySoftName(String softName);
}
