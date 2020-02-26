package com.huatusoft.dcac.common.util;



/**
 * @author WangShun
 */
public class ExceptionCastUtils {

	/** 使用此静态方法抛出未定义异常 */
	public static void castSystemException(String message) {
		throw new RuntimeException(message);
	}
}