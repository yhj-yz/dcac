package com.huatusoft.electronictag.base.response.message;

import com.huatusoft.electronictag.base.response.info.ResultInfo;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/8 0:26
 */
public interface ResultMessage extends ResultInfo {

    /**
     * 获取结果集信息
     * @return
     */
    String getMessage();

}
