/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.dcac.auditlog.entity.base;

import com.huatusoft.dcac.base.entity.BaseEntity;
import com.huatusoft.dcac.common.constant.SystemConstants;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;
import java.util.Date;

/**
 * Entity - 日志
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
@MappedSuperclass
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class LogEntity extends BaseEntity {
    @Transient
	private static final long serialVersionUID = -87709900794282286L;

	/** "日志内容"属性名称 */
	public static final String LOG_CONTENT_ATTRIBUTE_NAME = LogEntity.class.getName() + ".CONTENT";
	
	/**设备名*/
	public static final String LOG_DEVICENAME_ATTRIBUTE_NAME= LogEntity.class.getName() +".DEVICENAME";
	
	/**文档名称*/
	public static final String LOG_DOCNAME_ATTRIBUTE_NAME= LogEntity.class.getName() +".DOCNAME";

	/**打开天数*/
	public static final String LOG_OPENCOUNTS_ATTRIBUTE_NAME= LogEntity.class.getName() +".OPENCOUNTS";
	
	/**打开次数*/
	public static final String LOG_OPENDAYS_ATTRIBUTE_NAME= LogEntity.class.getName() +".OPENDAYS";

	/**文件作者*/
	public static final String LOG_FILEAUTHOR_ATTRIBUTE_NAME= LogEntity.class.getName() +".FILEAUTHOR";

	/**文档密集*/
	public static final String LOG_DOCSECURITY_ATTRIBUTE_NAME= LogEntity.class.getName() +".DOCSECURITY";

	/**登录类型*/
	public static final String LOG_LOGINTYPE_ATTRIBUTE_NAME= LogEntity.class.getName() +".LOGINTYPE";

	/**登录结果*/
	public static final String LOG_LOGINRESLUT_ATTRIBUTE_NAME= LogEntity.class.getName() +".LOGINRESLUT";
	
	/**客户端类型*/
	public static final String LOG_TEMINALTYPE_ATTRIBUTE_NAME= LogEntity.class.getName() +".TEMINALTYPE";

	/** "日志成功标示" */
	public static final String LOG_SUCCESS_ATTRIBUTE_NAME = LogEntity.class.getName() + ".SUCCESS";
	
	/** "日志失败标示" */
	public static final String LOG_FAIL_ATTRIBUTE_NAME = LogEntity.class.getName() + ".FAIL";
	
	public static final String USER_ACCOUNT_NAME="userAccount";
	
	public static final String USER_NAME_NAME="userName";
	
	public static final String IP_ADDRESS_NAME="ipAddress";
    /** 是否是导入的日志 */
    @Column(name="IS_IMPORT", length = 1)
	private Integer isImport = 0;
	/**日志唯一标识（用于导入时去重）*/
	@Column(name = "GUID", unique = true)
	private String guid;
	/**日志操作时间*/
	@DateTimeFormat(pattern = SystemConstants.DATE_TIME_PATTERN)
    @Column(name = "OPERATE_TIME", length = 20)
	private Date operateTime;
	/**操作用户账号*/
	@Column(name = "USER_ACCOUNT", length = 16)
	private String userAccount;
	/**操作用户姓名*/
    @Column(name = "USER_NAME", length = 15)
	private String userName;
	/**操作用户ip*/
	@Column(name = "IP", length = 21)
	private String ip;
}