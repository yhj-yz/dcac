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
    /** 策略编号 */
    @Column(name = "STRATEGY_ID")
    private String strategyId;
    /**所属部门*/
    @Column(name = "DEPARTMENT")
    private String department;
}
