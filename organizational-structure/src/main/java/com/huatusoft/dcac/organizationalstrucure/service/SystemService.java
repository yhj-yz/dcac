package com.huatusoft.dcac.organizationalstrucure.service;

import com.huatusoft.dcac.organizationalstrucure.dao.SystemDao;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.organizationalstrucure.entity.SystemEntity;

/**
 * @author yhj
 * @date 2020-5-15
 */
public interface SystemService extends BaseService<SystemEntity, SystemDao> {
    /**
     * 注册
     * @param appId
     * @param productKey
     * @return
     */
    Result register(String appId,String productKey);
}
