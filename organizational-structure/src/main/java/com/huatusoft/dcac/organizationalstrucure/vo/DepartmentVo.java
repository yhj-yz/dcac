package com.huatusoft.dcac.organizationalstrucure.vo;


import com.huatusoft.dcac.base.vo.BaseVo;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.HashSet;
import java.util.Set;

/**
 * dsm - 部门
 * @author Administrator
 *
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DepartmentVo extends BaseVo {
	private static final long serialVersionUID = -4813219363657312148L;
	/** "部门名"属性名称 */
	private Set<UserVo> users = new HashSet<UserVo>();

	private String name;
	
	/** "部门描述"属性名称 */
	private String desc;
	
	/** 上级部门ID */
	private String parentId;
	
	/** 状态：0 启用 1 禁用 2 删除*/
	private Integer status = 0;
	
	/** 是否单位：1是单位 0非单位*/
	private Integer isZone = 0;

	private String unitCode;
	
}
