package com.huatusoft.dcac.web.listener;

import com.huatusoft.dcac.common.bo.BasisPlatformInfo;
import com.huatusoft.dcac.common.service.initdb.InitDbService;
import com.huatusoft.dcac.systemsetting.entity.SystemParamEntity;
import com.huatusoft.dcac.systemsetting.service.SystemParamService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import javax.servlet.ServletContext;

/**
 * Listener - 初始化
 * 
 * @author asg Team
 * @version 3.0
 */
@Component
@Lazy(false)
public class InitListener implements ServletContextAware, ApplicationListener<ContextRefreshedEvent> {

	/** logger */
	private static final Logger LOGGER = LogManager.getLogger(LogManager.ROOT_LOGGER_NAME);

	/** servletContext */
	private ServletContext servletContext;

	@Value("${system.version}")
	private String systemVersion;

	@Autowired
	private InitDbService initDBService;
	
	@Autowired
	private SystemParamService systemParamService;

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	@Override
	public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
		if (servletContext != null && contextRefreshedEvent.getApplicationContext().getParent() == null) {
			try {
				initDBService.init();
			} catch (Exception e) {
				e.printStackTrace();
			}
			SystemParamEntity systemParam = systemParamService.findOne();
			/*staticService.buildOther();*/
			if(systemParam != null){
				servletContext.setAttribute(BasisPlatformInfo.APP_ID, systemParam.getBasisPlatformAppId());
				servletContext.setAttribute(BasisPlatformInfo.APP_SECRET, systemParam.getBasisPlatformSecret());
				servletContext.setAttribute(BasisPlatformInfo.VERIFY_TOKEN_URL, systemParam.getVerifyTokenUrl());
			}
		}
	}
}