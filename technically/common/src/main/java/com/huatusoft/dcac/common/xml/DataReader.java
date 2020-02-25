/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.common.xml;

public interface DataReader<E> {

    /**
     * 加载
     * @param clazz
     */
    void init(Class<?> clazz);

    boolean valid() throws Exception;
}
