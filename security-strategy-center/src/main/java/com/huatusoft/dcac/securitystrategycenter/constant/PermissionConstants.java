/**
 * @author yhj
 * @date 2019-10-15
 */
package com.huatusoft.dcac.securitystrategycenter.constant;

import java.util.HashMap;
import java.util.Map;

/**
 * 常量类 - 权限
 */
public class PermissionConstants {

    /** 使用授权文件 */
    public static final String CONFIG_USE_AUTH_FILE = "section_authorization_management";

    /** 安全策略权限(原系统TN_POPDOM表的所有权限)*/
    public static final Map<String, Integer> policyMap = new HashMap<String, Integer>();

    public static final Map<String, Integer> logMap = new HashMap<String, Integer>();

    /** 智能加密策略--加密类型 */
    public static final Map<String, Integer> securityTypeMap = new HashMap<String, Integer>();
    /** 智能加密策略--策略选项 */
    public static final Map<String, Integer> policyOptionMap = new HashMap<String, Integer>();

    /** 打印复制 */
    public static final Integer POLICY_AUTH_0 = 1 << 0;
    /** 允许截屏 */
    public static final Integer POLICY_AUTH_1 = 1 << 1;
    /** 允许卸载客户端*/
    public static final Integer POLICY_AUTH_2 = 1 << 2;
    /** 强制绑定电子标签 */
    public static final Integer POLICY_AUTH_3 = 1 << 3;
    /** 允许分离审批 */
    public static final Integer POLICY_AUTH_4 = 1 << 4;
    /** 允许流转 */
    public static final Integer PoLICY_AUTH_5 = 1 << 5;

    /** 使用授权文件*/
    public static final Integer POLICY_AUTH_USE_AUTH_FILE = 1 << 6;
    /** 允许登录智能终端*/
    public static final Integer POLICY_AUTH_LOGIN_INTELLIGENT_TEMINAL = 1 << 7;
    /** 创建文件授权 */
    /** 修改文件授权 */
    /** 上传打印日志*/
    public static final Integer POLICY_AUTH_UPLOAD_PRINT_LOG = 1 << 0;

    /** 文件解密日志 */
    public static final Integer LOG_DECIPHERING = 1 << 0;
    /** 打印日志 */
    public static final Integer LOG_OPEN = 1 << 1;
    /** 外发日志 */
    public static final Integer LOG_OUT = 1 << 2;
    /** 授权文件日志 */
    public static final Integer LOG_AUTHORIZE = 1 << 3;
    /** 用户登录日志 */
    public static final Integer LOG_LOGIN = 1 << 4;
    /** 管理日志 */
    public static final Integer LOG_MANAGER = 1 << 5;
    /** 客户端卸载日志 */
    public static final Integer LOG_UNLOAD = 1 << 6;
    /** 扫描加密 */
    public static final Integer SECURITY_TYPE_SCAN_ENCRYPT = 1 << 0;
    /** 落地加密 */
    public static final Integer SECURITY_TYPE_FALL_ENCRYPT = 1 << 1;
    /** 穿透压缩包 */
    public static final Integer POLICY_OPTION_PENETRATE_PACKAGE = 1 << 0;
    /** 是否显示水印文字 */
    public static final Integer WATERMARK_SHOW_TEXT = 1 << 0;
    /** 居中显示水印文字 */
    public static final Integer WATERMARK_SHOW_TEXT_CENTER = 1 << 1;
    /** 左上显示水印文字 */
    public static final Integer WATERMARK_SHOW_TEXT_LEFT_UP = 1 << 2;
    /** 左下显示水印文字 */
    public static final Integer WATERMARK_SHOW_TEXT_LEFT_DOWN = 1 << 3;
    /** 右上显示水印文字 */
    public static final Integer WATERMARK_SHOW_TEXT_RIGHT_UP = 1 << 4;
    /** 右下显示水印文字 */
    public static final Integer WATERMARK_SHOW_TEXT_RIGHT_DOWN = 1 << 5;

    static {

        logMap.put("LOG_DECIPHERING", LOG_DECIPHERING);
        logMap.put("LOG_OPEN", LOG_OPEN);
        logMap.put("LOG_OUT", LOG_OUT);
        logMap.put("LOG_AUTHORIZE", LOG_AUTHORIZE);
        logMap.put("LOG_LOGIN", LOG_LOGIN);
        logMap.put("LOG_MANAGER", LOG_MANAGER);
        logMap.put("LOG_UNLOAD", LOG_UNLOAD);

        securityTypeMap.put("SECURITY_TYPE_SCAN_ENCRYPT", SECURITY_TYPE_SCAN_ENCRYPT);
        securityTypeMap.put("SECURITY_TYPE_FALL_ENCRYPT", SECURITY_TYPE_FALL_ENCRYPT);

        policyOptionMap.put("POLICY_OPTION_PENETRATE_PACKAGE", POLICY_OPTION_PENETRATE_PACKAGE);

        for (int i = 0; i < 32; i++) {
            policyMap.put("POLICY_AUTH_" + i, 1 << i);
        }
    }

}
