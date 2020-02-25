package com.huatusoft.dcac.common.bo;

/**
 * 公共参数
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
public final class CommonAttributes {

	/** 日期格式配比 */
	public static final String[] DATE_PATTERNS = new String[] { "yyyy", "yyyy-MM", "yyyyMM", "yyyy/MM", "yyyy-MM-dd", "yyyyMMdd", "yyyy/MM/dd", "yyyy-MM-dd HH:mm:ss", "yyyyMMddHHmmss", "yyyy/MM/dd HH:mm:ss" };

	/**shopxx.xml文件路径 */
	public static final String ELECTRONICTAG__XML_PATH = "/electronicTag.xml";

	/** dsmxx.properties文件路径 */
	public static final String ELECTRONICTAG__PROPERTIES_PATH = "/electronicTag.properties";

	/** dsmxx-db.properties文件路径 */
	public static final String ELECTRONICTAG_DB_PROPERTIES_PATH = "/electronicTag-db.properties";

	/** dsmDB.sql文件路径 */
	public static final String ELECTRONICTAG_DB_File_PATH = "/init/initElectronicTag.sql";
	
	public static final String MYSQL_DB_URL = "jdbc:mysql://{0}:{1}/{2}?useUnicode=true&characterEncoding=UTF-8";

	public static final String STRING_NULL = "null";

	public static final String DATA_SEPARATOR = "<www.huatusoft.com>";

	/**
	 * 不可实例化
	 */
	private CommonAttributes() {
	}

}