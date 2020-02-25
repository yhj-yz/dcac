/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.dcac.common.bo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 分页
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
@Getter
@Setter
public class PageVo<T> implements Serializable {

	private static final long serialVersionUID = -2053800594583879853L;

	/** 内容 */
	private List<T> content = new ArrayList<T>();

	/** 总记录数 */
	private final long total;

	/** 分页信息 */
	private final PageableVo pageable;

	/**
	 * 初始化一个新创建的Page对象
	 */
	public PageVo() {
		this.total = 0L;
		this.pageable = new PageableVo();
	}

	/**
	 * @param content
	 *            内容
	 * @param total
	 *            总记录数
	 * @param pageable
	 *            分页信息
	 */
	public PageVo(List<T> content, long total, PageableVo pageable) {
		this.content = content;
		this.total = total;
		this.pageable = pageable;
	}

	/**
	 * 获取页码
	 * 
	 * @return 页码
	 */
	public int getPageNumber() {
		return pageable.getPageNumber();
	}

	/**
	 * 获取每页记录数
	 * 
	 * @return 每页记录数
	 */
	public int getPageSize() {
		return pageable.getPageSize();
	}

	/**
	 * 获取搜索属性
	 * 
	 * @return 搜索属性
	 */
	public String getSearchProperty() {
		return pageable.getSearchProperty();
	}

	/**
	 * 获取搜索值
	 * 
	 * @return 搜索值
	 */
	public String getSearchValue() {
		return pageable.getSearchValue();
	}

	/**
	 * 获取排序属性
	 * 
	 * @return 排序属性
	 */
	public String getOrderProperty() {
		return pageable.getOrderProperty();
	}



	/**
	 * 获取总页数
	 * 
	 * @return 总页数
	 */
	public int getTotalPages() {
		return (int) Math.ceil((double) getTotal() / (double) getPageSize());
	}

	
	/**
	 * 获取内容
	 * 
	 * @return 内容
	 */
	public List<T> getContent() {
		return content;
	}

	/**
	 * 获取总记录数
	 * 
	 * @return 总记录数
	 */
	public long getTotal() {
		return total;
	}

	/**
	 * 获取分页信息
	 * 
	 * @return 分页信息
	 */
	public PageableVo getPageable() {
		return pageable;
	}

}