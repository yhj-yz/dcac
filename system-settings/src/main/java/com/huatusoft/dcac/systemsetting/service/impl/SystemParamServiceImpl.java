package com.huatusoft.dcac.systemsetting.service.impl;

import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.systemsetting.entity.SystemParamEntity;
import com.huatusoft.dcac.systemsetting.dao.SystemParamDao;
import com.huatusoft.dcac.systemsetting.service.SystemParamService;
import org.springframework.stereotype.Service;

import java.util.Objects;

/**
 * Service - 系统参数
 *
 * @author: WangShun
 *
 */
@Service
public class SystemParamServiceImpl extends BaseServiceImpl<SystemParamEntity, SystemParamDao> implements SystemParamService {
	@Override
	public SystemParamEntity findOne() {
		return Objects.isNull(dao.findAll()) || dao.findAll().isEmpty() ? null : dao.findAll().get(0);
	}
}
