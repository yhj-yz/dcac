package com.huatusoft.dcac.systemsetting.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

/**
 * @author: Vamtoo.Java.Cao
 *
 */
@Entity
@Table(name ="HT_ELECTRONICTAG_SYSTEM_SET")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SystemParamEntity extends BaseEntity {

	private static final long serialVersionUID = 3843230996772036937L;

	/**基础平台地址*/
	@Column(name = "BASIS_PLATFORM_IP", length = 42)
	private String basisPlatformIP;
	/**连接端口*/
	@Column(name = "BASIS_PLATFORM_PORT", length = 20)
	private String basisPlatformPort;
	/**平台注册后，返回的app_id*/
	@Column(name = "BASIS_PLATFORM_APPID", length = 100)
	private String basisPlatformAppId;
	/**平台注册后，返回的app_secret*/
	@Column(name = "BASIS_PLATFORM_SECRET", length = 100)
	private String basisPlatformSecret;
	@Column(name = "VERIFY_TOKEN_URL", length = 255)
	private String verifyTokenUrl;
	/**标识是否有日志正在导入*/
	@Column(name = "IS_MANAGER_LOG_IMPORT", length = 1)
	private Integer isManagerLogImport;
	/**标识是否有日志正在导入*/
	@Column(name = "IS_File_LOG_IMPORT", length = 1)
	private Integer isFileLogImport;
	/**标识是否有日志正在导入*/
	@Column(name = "IS_Alarm_LOG_IMPORT", length = 1)
	private Integer isAlarmLogImport;
	/** 上次同步时间*/
	@Column(name = "LAST_SYNC_DATE", length = 16)
	private Date lastSyncDate;
	/** 上次同步部门成功时间*/
	@Column(name = "LAST_SYNC_DEPT_SUCCESS_DATE", length = 16)
	private Date lastSyncDeptSuccessDate;
	/** 上次同步用户成功时间*/
	@Column(name = "LAST_SYNC_USER_SUCCESS_DATE", length = 16)
	private Date lastSyncUserSuccessDate;
}
