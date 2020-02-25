/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.common.xml;

import java.util.Collection;
import java.util.Iterator;

public abstract class BaseDataStore<E>{

    protected String title;
    protected Collection<E> data;
    protected String[] colNames;
    protected String[] colProNames;
    protected Class<?> clazz;

    public BaseDataStore() {
    }

    public BaseDataStore(Collection<E> data) {
        this();
        if (data == null) {
            return;
        }
        this.data = data;
        for (Iterator<E> iterator = data.iterator(); iterator.hasNext(); ) {
            E next = iterator.next();
            clazz = next.getClass();
            break;
        }
        init(clazz);
    }

    protected abstract void init(Class<?> clazz);

}
