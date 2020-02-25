/**
 * @author yhj
 * @date 2019-10-18
 */
package com.huatusoft.dcac.systemsetting.service;

import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.systemsetting.dao.NetworkProcessDao;
import com.huatusoft.dcac.systemsetting.entity.NetworkProcessEntity;
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
