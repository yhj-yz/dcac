package com.huatusoft.dcac.auditlog.entity;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

/**类里面所有属性null值不转换
 * @author yhj
 * @date 2020-4-9
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Getter
@Setter
public class RecvSlaveEntity {
    /**
     * 0：不能进入离网 1:可以进入离网
     */
    private String haveOffline;

    private String firstLogin;
    /**如果是1表示提醒一次，否则表示每个minute提醒一次*/
    private String remindOnce;
    /**提醒间隔时间*/
    private String minute;
    /**狗ID和密钥都进行过RC4Base64加密，RC4密码DocGuarder_Encrypt_System_Made_in_HangZhou_2011_10_26*/
    private String dogId;
    /**RC4Base64加密*/
    private String key;
    /**用户操作权限，如开关客户端、删除文件等*/
    private String privilege;
    /**操作权限，通过configmanager配置的权限*/
    private String cfgId;
    /**离网时间*/
    private String overTime;
    /**当前等级*/
    private String cryptLevel;
    /**可打开密文的等级*/
    private String openFile;
    /**可打印*/
    private String printFile;
    /**可解密*/
    private String decryptFile;
    /**可调整*/
    private String adjustFile;
    /**可外发*/
    private String outsideFile;
    /**可解密审批*/
    private String decryptApproval;
    /**可外发审批*/
    private String outsideApproval;

    /**数据记录在SYSTEMPARA表*/
    /**客户端权限刷新时间*/
    private String timeFlushInfo;
    /**服务器安装的模块*/
    private String htModules;
    /**文件分布式存储，0：本地存储1：分布式*/
    private String fileStorage;
    /**授权到期提醒，如果服务器没有数据，返回-1*/
    private String leftDays;
    /**客户端开启选项描述*/
    private String clientChangeOpen;
    /**客户端开启弹框描述*/
    private String clientChangeOpenDesc;
    /**客户端关闭选项描述*/
    private String clientChangeClose;
    /**客户端关闭弹框描述*/
    private String clientChangeCloseDesc;
    /**外发文件打开是否限制*/
    private String limit;
    /**限制打开次数*/
    private String openCount;
    /**限制打开天数*/
    private String openDay;
    /**操作GUID，注册时不需要返回*/
    private String guid;
    /**0:失败 1：成功*/
    private String result;
    /**审批状态	0：未处理，1：已经处理*/
    private String state;
    /**http或是https*/
    private String protocol;
    /**服务器保存的路径*/
    private String filePath;
    /**最大文件等級*/
    private String maxLevel;
    /**其他电脑ip*/
    private String computerIp;
    /**其他电脑计算机名*/
    private String computerName;
}
