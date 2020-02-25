package com.huatusoft.dcac.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * VO - 数据库连接
 * 
 * @author WangShun
 *
 */

@Getter
@Setter
@ToString
public class DatabaseConnectionVO {
	/** 数据库地址 */
	private String dbIp;
	/** 数据库名称 */
	private String dbName;
	/** 数据库账号 */
	private String username;
	/** 数据库密码 */
	private String pwd;
}
