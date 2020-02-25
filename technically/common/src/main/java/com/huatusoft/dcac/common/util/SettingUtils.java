/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.dcac.common.util;

import com.huatusoft.dcac.common.bo.CommonAttributes;
import com.huatusoft.dcac.common.bo.Setting;
import com.huatusoft.dcac.common.vo.DatabaseConnectionVO;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Ehcache;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.beanutils.ConvertUtilsBean;
import org.apache.commons.beanutils.Converter;
import org.apache.commons.beanutils.converters.ArrayConverter;
import org.apache.commons.beanutils.converters.DateConverter;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PropertiesLoaderUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;


/**
 * Utils - 系统设置
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
public final class SettingUtils {

	/** CacheManager */
	private static final CacheManager CACHE_MANAGER = CacheManager.create();

	/** BeanUtilsBean */
	private static final BeanUtilsBean BEAN_UTILS_BEAN;

	static {
		ConvertUtilsBean convertUtilsBean = new ConvertUtilsBean() {
			@Override
			public String convert(Object value) {
				if (value != null) {
					Class<?> type = value.getClass();
					if (type.isEnum() && super.lookup(type) == null) {
						super.register(new EnumConverter(type), type);
					} else if (type.isArray() && type.getComponentType().isEnum()) {
						if (super.lookup(type) == null) {
							ArrayConverter arrayConverter = new ArrayConverter(type, new EnumConverter(type.getComponentType()), 0);
							arrayConverter.setOnlyFirstToString(false);
							super.register(arrayConverter, type);
						}
						Converter converter = super.lookup(type);
						return ((String) converter.convert(String.class, value));
					}
				}
				return super.convert(value);
			}

			@SuppressWarnings("rawtypes")
			@Override
			public Object convert(String value, Class clazz) {
				if (clazz.isEnum() && super.lookup(clazz) == null) {
					super.register(new EnumConverter(clazz), clazz);
				}
				return super.convert(value, clazz);
			}

			@SuppressWarnings("rawtypes")
			@Override
			public Object convert(String[] values, Class clazz) {
				if (clazz.isArray() && clazz.getComponentType().isEnum() && super.lookup(clazz.getComponentType()) == null) {
					super.register(new EnumConverter(clazz.getComponentType()), clazz.getComponentType());
				}
				return super.convert(values, clazz);
			}

			@SuppressWarnings("rawtypes")
			@Override
			public Object convert(Object value, Class targetType) {
				if (super.lookup(targetType) == null) {
					if (targetType.isEnum()) {
						super.register(new EnumConverter(targetType), targetType);
					} else if (targetType.isArray() && targetType.getComponentType().isEnum()) {
						ArrayConverter arrayConverter = new ArrayConverter(targetType, new EnumConverter(targetType.getComponentType()), 0);
						arrayConverter.setOnlyFirstToString(false);
						super.register(arrayConverter, targetType);
					}
				}
				return super.convert(value, targetType);
			}
		};

		DateConverter dateConverter = new DateConverter();
		dateConverter.setPatterns(CommonAttributes.DATE_PATTERNS);
		convertUtilsBean.register(dateConverter, Date.class);
		BEAN_UTILS_BEAN = new BeanUtilsBean(convertUtilsBean);
	}

	/**
	 * 不可实例化
	 */
	private SettingUtils() {
	}

	/**
	 * 获取系统设置
	 * 
	 * @return 系统设置
	 */
	public static Setting get() {
		Ehcache cache = CACHE_MANAGER.getEhcache(Setting.CACHE_NAME);
		net.sf.ehcache.Element cacheElement = cache.get(Setting.CACHE_KEY);
		Setting setting;
		if (cacheElement != null) {
			setting = (Setting) cacheElement.getObjectValue();
		} else {
			setting = new Setting();
			try {
				File shopxxXmlFile = new ClassPathResource(CommonAttributes.ELECTRONICTAG__XML_PATH).getFile();
				Document document = new SAXReader().read(shopxxXmlFile);
				List<Element> elements = document.selectNodes("/shopxx/setting");
				for (Element element : elements) {
					String name = element.attributeValue("name");
					String value = element.attributeValue("value");
					try {
						BEAN_UTILS_BEAN.setProperty(setting, name, value);
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					} catch (InvocationTargetException e) {
						e.printStackTrace();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			cache.put(new net.sf.ehcache.Element(Setting.CACHE_KEY, setting));
		}
		return setting;
	}

	/**
	 * 设置系统设置
	 * 
	 * @param setting
	 *            系统设置
	 */
	public static void set(Setting setting) {
		try {
			File shopxxXmlFile = new ClassPathResource(CommonAttributes.ELECTRONICTAG__XML_PATH).getFile();
			Document document = new SAXReader().read(shopxxXmlFile);
			List<Element> elements = document.selectNodes("/shopxx/setting");
			for (Element element : elements) {
				try {
					String name = element.attributeValue("name");
					String value = BEAN_UTILS_BEAN.getProperty(setting, name);
					Attribute attribute = element.attribute("value");
					attribute.setValue(value);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				}
			}

			FileOutputStream fileOutputStream = null;
			XMLWriter xmlWriter = null;
			try {
				OutputFormat outputFormat = OutputFormat.createPrettyPrint();
				outputFormat.setEncoding("UTF-8");
				outputFormat.setIndent(true);
				outputFormat.setIndent("	");
				outputFormat.setNewlines(true);
				fileOutputStream = new FileOutputStream(shopxxXmlFile);
				xmlWriter = new XMLWriter(fileOutputStream, outputFormat);
				xmlWriter.write(document);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (xmlWriter != null) {
					try {
						xmlWriter.close();
					} catch (IOException e) {
					}
				}
				IOUtils.closeQuietly(fileOutputStream);
			}

			Ehcache cache = CACHE_MANAGER.getEhcache(Setting.CACHE_NAME);
			cache.put(new net.sf.ehcache.Element(Setting.CACHE_KEY, setting));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 修改数据库配置文件
	 * @param dbIp
	 * @param dbName
	 * @param username
	 * @param pwd
	 */
	public static Boolean updateDB(String dbIp, String dbName, String username, String pwd) {
		OutputStream outputStream = null;
		Connection con = null;
		try {
			
			String url = MessageFormat.format(CommonAttributes.MYSQL_DB_URL, dbIp,"3306",dbName);
			//新建数据库连接, 测试是否能够连接
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,username,pwd);
			
			org.springframework.core.io.Resource resource = new ClassPathResource(CommonAttributes.ELECTRONICTAG_DB_PROPERTIES_PATH);
			Properties properties = PropertiesLoaderUtils.loadProperties(resource);
			//如果数据库可以连接，且参数没有变化，就不修改配置文件了
			if (StringUtils.equals(url, properties.getProperty("jdbc.url")) && StringUtils.equals(username, properties.getProperty("jdbc.username")) && StringUtils.equals(pwd, properties.getProperty("jdbc.password"))) {
				return true;
			}
			
			outputStream = new FileOutputStream(resource.getFile());
			properties.setProperty("jdbc.username", username);
			properties.setProperty("jdbc.password", pwd);
			properties.setProperty("jdbc.url", url);
			properties.store(outputStream, "dsm++ PROPERTIES");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			IOUtils.closeQuietly(outputStream);
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	/**
	 * 显示数据库连接信息
	 * 
	 * @return
	 * 			VO类，包含数据库连接的信息
	 */
	public static DatabaseConnectionVO showDB(){
		DatabaseConnectionVO db = new DatabaseConnectionVO();
		try {
			org.springframework.core.io.Resource resource = new ClassPathResource(CommonAttributes.ELECTRONICTAG_DB_PROPERTIES_PATH);
			Properties properties = PropertiesLoaderUtils.loadProperties(resource);
			String url = properties.getProperty("jdbc.url");
			String splitUrl = StringUtils.substringBetween(url, "//", "?");
			db.setDbIp(StringUtils.substringBefore(splitUrl, ":"));
			db.setDbName(StringUtils.substringAfter(splitUrl, "/"));
			db.setUsername(properties.getProperty("jdbc.username"));
			db.setPwd(properties.getProperty("jdbc.password"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return db;
	}

}