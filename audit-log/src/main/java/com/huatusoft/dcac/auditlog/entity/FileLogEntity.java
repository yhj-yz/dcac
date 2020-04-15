/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.auditlog.entity;

import com.huatusoft.dcac.auditlog.entity.base.LogEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

@Getter
@Setter
@Entity
@Table(name="HT_ELECTRONICTAG_FILE_LOG")
@NoArgsConstructor
@AllArgsConstructor
public class FileLogEntity extends LogEntity {
    @Transient
    private static final long serialVersionUID = -6979731263329441805L;

    /**文档名称 */
    @Column(name = "DOC_NAME",updatable = false)
    private String docName;

    /**操作类型 */
    public enum OperationType{
        fileprint,//文件打印
        filesave,//修改保存
        commentcopy,//内容复制
        filecopy,//文件复制
        commentcut,//内容剪切
        filemove,//文件移动
        Labelseparation,//标签分离
        filerename,//文件重命名
        receiveNetFile,//文件网络接受
        sendNetFile, //文件网络发送
        Labelmodify,//修改电子标签
        Labelcreate//新建电子标签
    }

    /** 操作类型 */
    @Column(name = "OPERATION_TYPE")
    private OperationType operationType;
    /**设备名称 */
    @Column(name = "DEVICE_NAME",updatable = false)
    private String deviceName;
    /** 文件操作者？ */
    @Column(name = "FILE_USER")
    private String fileUser;
    /** 安全域序号 */
    @Column(name = "DOMAIN_ORDER")
    private Integer domainOrder;
    /** 文件ID */
    @Column(name = "FILE_ID")
    private String fileId;
    /** 操作时间 */
    @Column(name = "FILE_TIME")
    private String fileTime;
    /** 内部错误 */
    @Column(name = "INTERNAL_ERROR")
    private String internalError;
    /** 系统错误 */
    @Column(name = "SYSTEM_ERROR")
    private String systemError;
    /** 是否删除 */
    @Column(name = "DELETED")
    private Integer deleted;
    /** 管理GUID */
    @Column(name = "MANAGE_GUID")
    private String manageGuid;
    /** 上传服务器上的路径 */
    @Column(name = "FILE_SERVER_PATH")
    private String fileServerPath;
    /** 文件GUID */
    @Column(name = "FILE_GUID")
    private String fileGuid;
    /** 终端ID clientID*/
    @Column(name = "CLIENT_ID")
    private String clientID;
    /** 日志GUID */
    @Column(name = "LOG_GUID")
    private String logGuid;
    /** 操作GUID */
    @Column(name = "OPERATION_GUID")
    private String operationGuid;
    /** 电脑名称 */
    @Column(name = "COMPUTER_NAME")
    private String computerName;
    /** 数据分级编号 */
    @Column(name = "DATA_GRADE_ID")
    private String dataClassification;
    /** 数据分类编号 */
    @Column(name = "DATA_CLASSIFY_ID")
    private String dataType;
    /** 文件名称 */
    @Column(name = "FILE_NAME")
    private String fileName;
    /** 防护策略 */
    @Column(name = "FILE_OPER")
    private int fileOper;
    /** 命中次数 */
    @Column(name = "HITS")
    private int hits;
    /** 登陆名 */
    @Column(name = "LOGIN_NAME")
    private String loginName;
    /** 时间 */
    @Column(name = "TIME")
    private String time;
    /** 文件大小 */
    @Column(name = "FILE_SIZE")
    private int fileSize;
    /** 文件md5 */
    @Column(name = "FILE_MD5")
    private String fileMD5;
}
