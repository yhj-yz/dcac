package com.huatusoft.dcac.organizationalstrucure.entity;


import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * dsm - 部门
 * @author Administrator
 *
 */
@Entity
@Getter
@Setter
@Cacheable
@Table(name = "HT_ELECTRONICTAG_DEPARTMENT")
@NoArgsConstructor
@AllArgsConstructor
public class DepartmentEntity extends BaseEntity {
    @Transient
	private static final long serialVersionUID = -4813219363657312148L;

	@Column(name = "DEPT_NAME", length = 64)
	private String name;
	
	/** "部门描述"属性名称 */
	@Column(name = "DEPT_DESC", length = 1024)
	private String desc;
	
	/** 上级部门ID */
	@Column(name = "DEPT_PID", length = 32)
	private String parentId;
	
	/** 状态：0 启用 1 禁用 2 删除*/
	@Column(name = "DEPT_STATUS", length = 1)
	private Integer status = 0;
	
	/** 是否单位：1是单位 0非单位*/
	@Column(name = "DEPT_IS_ZONE", length = 1)
	private Integer isZone = 0;

	@Column(name = "DEPT_UNIT_CODE", length = 255)
	private String unitCode;

	/** "部门名"属性名称 */
	@OneToMany(mappedBy="department", fetch = FetchType.LAZY,cascade={CascadeType.REMOVE})
	@JsonIgnore
	private List<UserEntity> users = new ArrayList<>();
	
}
