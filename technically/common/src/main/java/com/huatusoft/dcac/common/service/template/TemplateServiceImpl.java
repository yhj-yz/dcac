/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.dcac.common.service.template;

import com.huatusoft.dcac.common.bo.CommonAttributes;
import com.huatusoft.dcac.common.bo.Template;
import org.apache.commons.io.FileUtils;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Service - 模板
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("templateServiceImpl")
public class TemplateServiceImpl implements TemplateService, ServletContextAware {

	/** servletContext */
	private ServletContext servletContext;

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	private static Document document = null;

	static {
		try {
			document = new SAXReader().read(new ClassPathResource(CommonAttributes.ELECTRONICTAG__XML_PATH).getFile());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Value("${template.loader_path}")
	private String[] templateLoaderPaths;

	private static final String XML_TEMPLATE_PATH = "/shopxx/template";

	@Override
	@Cacheable("template")
	public List<Template> getAll() {
		List<Template> templates = new ArrayList<Template>();
		List<Element> elements = null;
		elements = document.selectNodes(XML_TEMPLATE_PATH);
		for (Element element : elements) {
			Template template = getTemplate(element);
			templates.add(template);
		}
		return templates;
	}

	@Override
	@Cacheable("template")
	public List<Template> getList(Template.Type type) {
		if (type == null) {
			return getAll();
		}
		List<Template> templates = new ArrayList<Template>();
		List<Element> elements = document.selectNodes(XML_TEMPLATE_PATH + "[@type='" + type + "']");
		for (Element element : elements) {
			Template template = getTemplate(element);
			templates.add(template);
		}
		return templates;
	}

	@Override
	@Cacheable("template")
	public Template get(String id) {
		return getTemplate((Element) document.selectSingleNode(XML_TEMPLATE_PATH + "[@id='" + id + "']"));
	}

	@Override
	public String read(String id) {
		return read(get(id));
	}

	@Override
	public String read(Template template) {
		String templatePath = servletContext.getRealPath(templateLoaderPaths[0] + template.getTemplatePath());
		File templateFile = new File(templatePath);
		String templateContent = null;
		try {
			templateContent = FileUtils.readFileToString(templateFile, "UTF-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return templateContent;
	}

	@Override
	public void write(String id, String content) {
		write(get(id), content);
	}

	@Override
	public void write(Template template, String content) {
		File templateFile = new File(servletContext.getRealPath(templateLoaderPaths[0] + template.getTemplatePath()));
		try {
			FileUtils.writeStringToFile(templateFile, content, "UTF-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取模板
	 * 
	 * @param element
	 *            元素
	 */
	private Template getTemplate(Element element) {
		String id = element.attributeValue("id");
		String type = element.attributeValue("type");
		String name = element.attributeValue("name");
		String templatePath = element.attributeValue("templatePath");
		String staticPath = element.attributeValue("staticPath");
		String description = element.attributeValue("description");

		Template template = new Template();
		template.setId(id);
		template.setType(Template.Type.valueOf(type));
		template.setName(name);
		template.setTemplatePath(templatePath);
		template.setStaticPath(staticPath);
		template.setDescription(description);
		return template;
	}

}