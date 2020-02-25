package com.huatusoft.electronictag.client.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/11/7 16:09
 */
@Setter
@Getter
public class TranInfoVo {

    /**
     * 流转时所有者用户
     */
    private String openuser;
    /**
     * 流转时所有者终端编码
     */
    private String termcode;
    /**
     * 流转时时间
     */
    private String opetime;
    /**
     * 流转类型
     */
    private String opetype;
    
}
