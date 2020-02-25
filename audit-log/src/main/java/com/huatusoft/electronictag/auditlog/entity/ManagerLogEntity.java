package com.huatusoft.electronictag.auditlog.entity;

import com.huatusoft.electronictag.auditlog.entity.base.LogEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;


/***
 * 管理日志实体
 * 
 * @author Vamtoo.Java.YHJ
 * 2017年3月28日
 */

@Getter
@Setter
@Entity
@Table(name="HT_ELECTRONICTAG_MANAGER_LOG")
@NoArgsConstructor
@AllArgsConstructor
@DynamicInsert
@DynamicUpdate
public class ManagerLogEntity extends LogEntity {
	@Transient
	private static final long serialVersionUID = -6060670555616271383L;

	/**操作模块*/
	@Column(name = "MANAGER_LOG_OPERATION_MODEL", updatable = false, length = 32)
	private String operationModel;
    /**操作类型*/
	@Column(name = "MANAGER_LOG_OPERATION_TYPE", updatable = false, length = 32)
	private String operationType;
	/**操作内容描述*/
	@Column(name = "MANAGER_LOG_OPERATION_DESCRIPTION", length = 3096, updatable = false)
	private String description;
}
