package com.huatusoft.dcac.base.response.code;

import com.huatusoft.dcac.base.response.info.ResultInfo;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/8 0:16
 */
public interface ResultCode extends ResultInfo {

    /**
     * 获取结果代码
     * @return
     */
    String getCode();

}
