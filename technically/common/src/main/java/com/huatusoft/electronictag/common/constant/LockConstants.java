/**
 * @author yhj
 * @date 2019-10-24
 */
package com.huatusoft.electronictag.common.constant;

import java.util.concurrent.locks.ReentrantLock;

/**
 * Constant - 锁对象
 */
public class LockConstants {

    public static final ReentrantLock IMPORT_LOCK = new ReentrantLock(true);

    public static final int IMPORT_WAIT_SECOND = 10;
}
