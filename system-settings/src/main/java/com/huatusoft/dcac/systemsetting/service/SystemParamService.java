package com.huatusoft.dcac.systemsetting.service;

import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.systemsetting.entity.SystemParamEntity;
import com.huatusoft.dcac.systemsetting.dao.SystemParamDao;

/**
 * System - 系统参数
 *
 * @author: Vamtoo.Java.Cao
 *
 */
public interface SystemParamService extends BaseService<SystemParamEntity, SystemParamDao> {

	/**
	 * 获取系统参数
	 * @return
	 */
	SystemParamEntity findOne();

}
