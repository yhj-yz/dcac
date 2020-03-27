package com.huatusoft.dcac.auditlog.service;

import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.auditlog.dao.AlarmLogDao;
import com.huatusoft.dcac.auditlog.entity.AlarmLogEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * @author yhj
 * @date 2020-2-25
 */
public interface AlarmLogService extends BaseService<AlarmLogEntity, AlarmLogDao> {
    /**
     * 分页查询
     * @param pageable
     * @param warnDetail
     * @param level
     * @param userAccount
     * @param operateTime
     * @param readFlag
     * @return
     */
    Page<AlarmLogEntity> findAll(Pageable pageable, String warnDetail, String level, String userAccount, String operateTime, String readFlag);
}
