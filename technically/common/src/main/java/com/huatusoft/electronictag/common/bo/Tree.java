package com.huatusoft.electronictag.common.bo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.MappedSuperclass;
import java.io.Serializable;

/**
 * 用于Ztree显示数据的实体类
 * 
 * @author Vamtoo.Java.Cao
 *
 */
@MappedSuperclass
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Tree implements Serializable {
	
	private static final long serialVersionUID = 2498786710806880188L;
	/** 自定义图标-组织架构*/
	public static final String OGNI_ICON = "z_icon01";
	/** 自定义图标-部门*/
	public static final String DEPT_ICON = "z_icon02";
	/** 自定义图标-用户*/
	public static final String MEMBER_ICON = "z_icon03";
	
	private String id;
	
	private String name;
	
	private String parentId;
	
	private String iconSkin = DEPT_ICON;
	
	private Boolean isParent = Boolean.FALSE;
	
	private Boolean open = Boolean.FALSE;
	
	private Boolean checked = Boolean.FALSE;
	
	private String ext1;
	
	private String ext2;

	public Tree(String id, String name, String pId) {
		this.id = id;
		this.parentId = pId;
		this.name = name;
	}
}
