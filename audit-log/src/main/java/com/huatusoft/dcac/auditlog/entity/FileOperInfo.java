package com.huatusoft.dcac.auditlog.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author yhj
 * @date 2020-4-9
 */
@Getter
@Setter
public class FileOperInfo {
    /**文件ID*/
    private String fileId;
    /**文件IP*/
    private String fileIp;
    /**计算机名*/
    private String fileComputer;
    /**终端ID*/
    private String fileClientId;
    /**操作时间*/
    private String fileTime;
    /**文件用户*/
    private String fileUserName;
    /**账号*/
    private String fileUserAccount;
    /**操作类型*/
    private String fileOper;
    /**文件操作内容*/
    private String operDes;
}
