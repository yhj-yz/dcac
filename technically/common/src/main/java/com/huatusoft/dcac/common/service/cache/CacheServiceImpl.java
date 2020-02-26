/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.dcac.common.service.cache;

import com.huatusoft.dcac.common.util.SettingUtils;
import com.huatusoft.dcac.common.util.ExceptionCastUtils;
import freemarker.template.TemplateModelException;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Ehcache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.annotation.Resource;

/**
 * Service - 缓存
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
@Service
public class CacheServiceImpl implements CacheService {

	@Resource(name = "ehCacheManager")
	private CacheManager cacheManager;

	@Autowired
	private ReloadableResourceBundleMessageSource messageSource;

	@Resource(name = "freeMarkerConfigurer")
	private FreeMarkerConfigurer freeMarkerConfigurer;

	@Override
	public String getDiskStorePath() {
		return cacheManager.getConfiguration().getDiskStoreConfiguration().getPath();
	}

	@Override
	public int getCacheSize() {
		int cacheSize = 0;
		String[] cacheNames = cacheManager.getCacheNames();
		if (cacheNames != null) {
			for (String cacheName : cacheNames) {
				Ehcache cache = cacheManager.getEhcache(cacheName);
				if (cache != null) {
					cacheSize += cache.getSize();
				}
			}
		}
		return cacheSize;
	}

	@Override
	@CacheEvict(value = { "setting", "authorization", "logConfig", "template", "memberAttribute", "navigation", "license"}, allEntries = true)
	public void clear() {
		messageSource.clearCache();
		try {
			freeMarkerConfigurer.getConfiguration().setSharedVariable("setting", SettingUtils.get());
		} catch (TemplateModelException e) {
			ExceptionCastUtils.castSystemException("CacheServiceImpl.clear()" + "setSharedVariable失败");
		}
		freeMarkerConfigurer.getConfiguration().clearTemplateCache();
	}

	@Override
	@CacheEvict(value = "license", allEntries = true)
	public void myClear() {
		
	}

}