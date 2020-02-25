package com.huatusoft.electronictag.base.service;

import com.huatusoft.electronictag.common.constant.PlatformConstants;
import org.springframework.web.context.ServletContextAware;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Map;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/25 17:35
 */
public interface BasicPlatformService extends PlatformConstants, ServletContextAware {
    /**
     * 请求基础平台参数准备
     * @return
     */
    Map<String, String> requestPreparationParam(ArrayList<String> keys, ArrayList<String> values);
}
