/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.dcac.common.bo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;

/**
 * 身份信息
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
@Getter
@Setter
@ToString
public class Principal implements Serializable {

	private static final long serialVersionUID = 5798882004228239559L;

	/** ID */
	private String id;

	/** 账号 */
	private String account;
	
	/** 用户姓名 */
	private String user_name;
	/**
	 * @param id
	 *            ID
	 * @param account
	 *            用户名
	 */
	public Principal(String id, String account) {
		this(id, account, null);
	}
	/**
	 * @param id
	 *            ID
	 * @param account
	 *            用户名
	 * @param user_name
	 */
	public Principal(String id, String account, String user_name) {
		this.id = id;
		this.account = account;
		this.user_name = user_name;
	}
}