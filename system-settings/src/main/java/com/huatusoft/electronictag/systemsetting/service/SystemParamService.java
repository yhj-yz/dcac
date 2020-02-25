package com.huatusoft.electronictag.systemsetting.service;

import com.huatusoft.electronictag.base.service.BaseService;
import com.huatusoft.electronictag.systemsetting.entity.SystemParamEntity;
import com.huatusoft.electronictag.systemsetting.dao.SystemParamDao;

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
