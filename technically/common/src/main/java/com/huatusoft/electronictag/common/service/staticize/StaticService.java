/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.electronictag.common.service.staticize;

import java.util.Map;

/**
 * Service - 静态化
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
public interface StaticService {

	/**
	 * 生成静态
	 * 
	 * @param templatePath
	 *            模板文件路径
	 * @param staticPath
	 *            静态文件路径
	 * @param model
	 *            数据
	 * @return 生成数量
	 */
	int build(String templatePath, String staticPath, Map<String, Object> model);

	/**
	 * 生成静态
	 * 
	 * @param templatePath
	 *            模板文件路径
	 * @param staticPath
	 *            静态文件路径
	 * @return 生成数量
	 */
	int build(String templatePath, String staticPath);

	/**
	 * 生成首页静态
	 * 
	 * @return 生成数量
	 */
	int buildIndex();

	/**
	 * 生成其它静态
	 * 
	 * @return 生成数量
	 */
	int buildOther();

	/**
	 * 生成所有静态
	 * 
	 * @return 生成数量
	 */
	int buildAll();

	/**
	 * 删除静态
	 * 
	 * @param staticPath
	 *            静态文件路径
	 * @return 删除数量
	 */
	int delete(String staticPath);

	/**
	 * 删除首页静态
	 * 
	 * @return 删除数量
	 */
	int deleteIndex();

	/**
	 * 删除其它静态
	 * 
	 * @return 删除数量
	 */
	int deleteOther();

}