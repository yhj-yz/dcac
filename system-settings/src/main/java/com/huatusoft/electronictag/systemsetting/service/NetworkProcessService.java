/**
 * @author yhj
 * @date 2019-10-18
 */
package com.huatusoft.electronictag.systemsetting.service;

import com.huatusoft.electronictag.base.service.BaseService;
import com.huatusoft.electronictag.systemsetting.dao.NetworkProcessDao;
import com.huatusoft.electronictag.systemsetting.entity.NetworkProcessEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface NetworkProcessService extends BaseService<NetworkProcessEntity, NetworkProcessDao> {

    /**
     * 根据processName分页查询
     * @param pageable
     * @param processName
     * @return
     */
    Page<NetworkProcessEntity> findAll(Pageable pageable,String processName);
}
