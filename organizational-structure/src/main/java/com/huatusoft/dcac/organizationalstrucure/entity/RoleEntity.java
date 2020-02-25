/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.dcac.organizationalstrucure.entity;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



/**
 * Entity - 角色
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
@Getter
@Setter
@Entity
@Cacheable
@Table(name = "HT_ELECTRONICTAG_ROLE")
@NoArgsConstructor
@AllArgsConstructor
public class RoleEntity extends BaseEntity {
	@Transient
	private static final long serialVersionUID = 7015637138573293955L;
	/** 名称 */
	@Column(nullable = false, length = 64, name = "ROLE_NAME")
	private String name;

	/** 描述 */
	@Column(name = "ROLE_DESC", length = 1024)
	private String description;
	
	/** 是否包含部门管理0否1是*/
	@Column(name = "ROLE_STATUS", length = 1)
	private Integer status = 0;

	/** 权限 */
	@OneToMany(mappedBy = "role", fetch = FetchType.LAZY)
	@JsonIgnore
	private List<AuthorityEntity> authorities = new ArrayList<AuthorityEntity>();

	/** 管理员 */
	@OneToMany(mappedBy = "role", fetch = FetchType.LAZY)
	@JsonIgnore
	private Set<UserEntity> users = new HashSet<UserEntity>();

}