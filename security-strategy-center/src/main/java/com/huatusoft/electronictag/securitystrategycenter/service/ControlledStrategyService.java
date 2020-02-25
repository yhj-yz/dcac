/**
 * @author yhj
 * @date 2019-10-16
 */
package com.huatusoft.electronictag.securitystrategycenter.service;

import com.huatusoft.electronictag.base.service.BaseService;
import com.huatusoft.electronictag.organizationalstrucure.entity.ControlledStrategyEntity;
import com.huatusoft.electronictag.securitystrategycenter.dao.ControlledStrategyDao;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ControlledStrategyService extends BaseService<ControlledStrategyEntity, ControlledStrategyDao>{
    /**
     * 分页查询
     * @param pageable
     * @param name
     * @return
     */
    Page<ControlledStrategyEntity> findAll(Pageable pageable, String name);

    /**
     *
     */
}
