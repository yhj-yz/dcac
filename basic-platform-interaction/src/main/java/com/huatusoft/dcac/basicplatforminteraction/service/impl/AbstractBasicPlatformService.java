package com.huatusoft.dcac.basicplatforminteraction.service.impl;

import com.google.inject.internal.util.$Maps;
import com.huatusoft.dcac.base.service.BasicPlatformService;

import javax.servlet.ServletContext;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/25 17:44
 */
public abstract class AbstractBasicPlatformService implements BasicPlatformService {

    protected ServletContext servletContext;

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    @Override
    public Map<String, String> requestPreparationParam(ArrayList<String> keys, ArrayList<String> values) {
        HashMap<String, String> params = $Maps.newHashMap();
        for (int i = 0; i < keys.size(); i++) {
            String key = keys.get(i);
            String value = values.get(i);
            params.put(key,value);
        }
        return params;
    }
}
