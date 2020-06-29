package com.huatusoft.dcac.common.constant;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 14:17
 */
public interface PlatformConstants {

    Integer REQUEST_PARAM_INIT_LENGTH = 5;

    Integer DEPARTMENT_DELETE = 2;
    Integer DEPARTMENT_DISABLED = 1;
    Integer USER_DELETE = 2;
    Integer USER_DISABLED = 2;
    String PLATFORM_APP_ID = "platform_app_id";
    String PLATFORM_APP_SECRET = "platform_app_secret";
    String PLATFORM_IP = "basisPlatformIP";
    String PLATFORM_PORT = "basisPlatformPort";
    String SYNC_DEPT = "1";
    String SYNC_USER = "2";
    /**
     * 子系统部门信息的最后变更时间（指基础平台时间）。时
     * 间格式为yyyy-MM-dd HH:mm:ss，如果时间为””，则请求
     * 服务器返回所有部门信息。
     */
    String SYNC_TIME = "synctime";
    String ACCESS_TOKEN = "access_token";
    String SYNC_TYPE = "type";
    String SYNC_PAGE = "page";
    String SYNC_ROWS = "rows";
    String SYNC_TIME_PATTERN = "yyyy-MM-dd HH:mm:ss";
    Integer SYNC_PAGE_DEFAULT = 1;
    Integer SYNC_ROWS_DEFAULT = 50;
    String SYNC_APP_NAME = "电子标签";


    String ACCESS_APP_ID = "app_id";
    String ACCESS_APP_SECRET = "app_secret";
    String ACCESS_GRANT_TYPE = "grant_type";
    String ACCESS_GRANT_TYPE_VAlUE = "app";
    String ACCESS_TYPE = "type";
    String ACCESS_M_CODE = "mcode";
    String ACCESS_IP = "ip";
    String ACCESS_USER_ID = "uid";
    String ACCESS_USER_NAME = "uname";
    String ACCESS_TIME = "time";
    String ACCESS_LEVEL = "level";
    String ACCESS_RESULT = "result";
    String ACCESS_WARN_DETAIL = "warnDetail";

    /**
     * url
     */
    String APP_NAME = "电子标签";
    String GETTOKEN_URL = "http://%s:%s/restapi/gettoken";
    String VERIFYTOKEN_URL = "http://%s:%s/restapi/verifytoken";
    String ALARMREPORT_URL = "http://%s:%s/restapi/alarmreport";
    String ALARMRESULT_URL = "http://%s:%s/restapi/alarmresult";
    String GETUNITCERT_URL = "http://%s:%s/restapi/getunitcert";
    String STATUSREPORT_URL = "http://%s:%s/restapi/statusreport";
    String DEPT_USER_SYNC_URL = "http://%s:%s/restapi/deptusersync";
    String ALARM_REPORT_URL = "http://%s:%s/restapi/alarmreport";
    String ALARM_RESULT_URL = "http://%s:%s/restapi/alarmresult";



}
