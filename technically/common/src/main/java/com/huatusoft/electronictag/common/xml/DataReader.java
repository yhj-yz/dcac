/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.electronictag.common.xml;

import java.io.InputStream;
import java.util.List;

public interface DataReader<E> {

    /**
     * 加载
     * @param clazz
     */
    void init(Class<?> clazz);

    boolean valid() throws Exception;
}
