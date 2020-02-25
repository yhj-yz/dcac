/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.dcac.organizationalstrucure.vo;

import com.huatusoft.dcac.base.vo.BaseVo;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


/**
 * Entity - 角色
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RoleVo extends BaseVo {
	private static final long serialVersionUID = 7015637138573293955L;
	/** 名称 */
	private String name;

	/** 描述 */
	private String description;
	
	/** 是否包含部门管理0否1是*/
	private Integer status = 0;

	/** 权限 */
	private List<String> authorities = new ArrayList<String>();

	/** 管理员 */
	private Set<UserVo> users = new HashSet<UserVo>();

}