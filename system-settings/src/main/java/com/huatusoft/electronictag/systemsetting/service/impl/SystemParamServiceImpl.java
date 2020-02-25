package com.huatusoft.electronictag.systemsetting.service.impl;

import com.huatusoft.electronictag.base.service.BaseServiceImpl;
import com.huatusoft.electronictag.systemsetting.entity.SystemParamEntity;
import com.huatusoft.electronictag.systemsetting.dao.SystemParamDao;
import com.huatusoft.electronictag.systemsetting.service.SystemParamService;
import org.springframework.stereotype.Service;
import java.util.List;
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
