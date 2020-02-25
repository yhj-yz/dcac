package com.huatusoft.electronictag.common.service.initdb;

import com.google.inject.internal.util.$Maps;
import com.huatusoft.electronictag.common.bo.CommonAttributes;
import com.huatusoft.electronictag.common.util.ExceptionCastUtils;
import com.huatusoft.electronictag.common.util.FreemarkerUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.sql.SQLException;
import java.util.*;

/**
 * @author WangShun
 */
@Service
@Transactional
public class InitDbServiceImpl implements InitDbService {
	private static final Logger LOGGER = LogManager.getLogger(LogManager.ROOT_LOGGER_NAME);

	@PersistenceContext
	protected EntityManager entityManager;

	@Autowired
	private FreeMarkerConfigurer freeMarkerConfigurer;

	@Override
	public void init() throws Exception {
		//获取初始化数据库.sql文件
		File initDbFile = getInitDbFile(CommonAttributes.ELECTRONICTAG_DB_File_PATH);
		if(initDbFile == null) {
			ExceptionCastUtils.castSystemException("找不到初始化数据库文件");
		}
		executeSql(initDbFile);
	}

    /** 获取初始化数据库文件 */
    private File getInitDbFile(String path) {
		File initDbFile = null;
		ClassPathResource classPathResource = new ClassPathResource(path);
		try {
			initDbFile = classPathResource.exists() ? classPathResource.getFile() : null;
		} catch (IOException e) {
			ExceptionCastUtils.castSystemException("执行初始化数据库文件失败" + e.getMessage());
		}
		return initDbFile;
	}

	private void executeSql(File sqlFile) throws Exception {
		long before = System.currentTimeMillis();
		Map<String, Object> model = $Maps.newHashMap();
		model.put("date", new Date());
		String currentSQL;
		List<String> strings = FileUtils.readLines(sqlFile, "UTF-8");
		for (String line : strings) {
			if (StringUtils.isNotBlank(line)) {
				currentSQL = FreemarkerUtils.process(line, model, freeMarkerConfigurer.getConfiguration());
				LOGGER.debug("用freemarker方法替换'${date?string(\"yyyy-MM-dd HH:mm:ss\")}'后的sql" + currentSQL);
				//执行sql
				entityManager.createNativeQuery(currentSQL).executeUpdate();
			}
		}
	}


	private boolean isInit(String sql) throws SQLException {
		if (!StringUtils.startsWithIgnoreCase(sql, "INSERT INTO")) {
			return true;
		}
		String tableName = sql.replaceAll("((?i)INSERT INTO|\\(.*)", "");
		BigInteger count = (BigInteger) entityManager.createNativeQuery("select count(*) from " + tableName).getSingleResult();
		if(count.longValue() > 0) {
			return true;
		}
		return false;
	}
}
