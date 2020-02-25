/**
 * @author yhj
 * @date 2019-10-16
 */
package com.huatusoft.dcac.securitystrategycenter.service;

import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.organizationalstrucure.entity.ControlledStrategyEntity;
import com.huatusoft.dcac.securitystrategycenter.dao.ControlledStrategyDao;
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
