/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.dcac.common.service.staticize;

import com.huatusoft.dcac.common.util.ExceptionCastUtils;
import com.huatusoft.dcac.common.service.template.TemplateService;
import com.huatusoft.dcac.common.bo.Template;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.servlet.ServletContext;
import java.io.*;
import java.util.Map;

/**
 * Service - 静态化
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
@Service
public class StaticServiceImpl implements StaticService, ServletContextAware {

	/** servletContext */
	private ServletContext servletContext;

	@Autowired
	private FreeMarkerConfigurer freeMarkerConfigurer;
	@Autowired
	private TemplateService templateService;

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	@Override
	@Transactional(readOnly = true)
	public int build(String templatePath, String staticPath, Map<String, Object> model) {
		//获取静态路径文件
		File staticFile = new File(servletContext.getRealPath(staticPath));
		File staticDirectory = staticFile.getParentFile();
		if (!staticDirectory.exists()) {
			staticDirectory.mkdirs();
		}

		try (Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(staticFile), "UTF-8"))) {
			freemarker.template.Template template = freeMarkerConfigurer.getConfiguration().getTemplate(templatePath);
			template.process(model, writer);
			writer.flush();
			return 1;
		} catch (Exception e) {
			ExceptionCastUtils.castSystemException("StaticServiceImpl.Build" + "写入model失败");
		}
		return 0;
	}

	@Override
	@Transactional(readOnly = true)
	public int build(String templatePath, String staticPath) {
		return build(templatePath, staticPath, null);
	}


	@Override
	@Transactional(readOnly = true)
	public int buildIndex() {
		return 1;
	}

	@Transactional(readOnly = true)
	public int buildSitemap() {
		return 0;
	}

	@Override
	@Transactional(readOnly = true)
	public int buildOther() {
		int buildCount = 0;
		Template adminCommonJsTemplate = templateService.get("adminCommonJs");
		Template dsmCommonJsTemplate = templateService.get("dsmCommonJs");
		buildCount += build(dsmCommonJsTemplate.getTemplatePath(), dsmCommonJsTemplate.getStaticPath());
		buildCount += build(adminCommonJsTemplate.getTemplatePath(), adminCommonJsTemplate.getStaticPath());
		return buildCount;
	}

	@Override
	@Transactional(readOnly = true)
	public int buildAll() {
		int buildCount = 0;
		buildIndex();
		buildSitemap();
		buildOther();
		return buildCount;
	}

	@Override
	@Transactional(readOnly = true)
	public int delete(String staticPath) {
		Assert.hasText(staticPath);

		File staticFile = new File(servletContext.getRealPath(staticPath));
		if (staticFile.exists()) {
			staticFile.delete();
			return 1;
		}
		return 0;
	}



	@Override
	@Transactional(readOnly = true)
	public int deleteIndex() {
		return 1;
	}

	@Override
	@Transactional(readOnly = true)
	public int deleteOther() {
		int deleteCount = 0;
		Template adminCommonJsTemplate = templateService.get("adminCommonJs");
		Template dsmCommonJsTemplate = templateService.get("dsmCommonJs");
		deleteCount += delete(dsmCommonJsTemplate.getStaticPath());
		deleteCount += delete(adminCommonJsTemplate.getStaticPath());
		return deleteCount;
	}

}