package com.huatusoft.electronictag.basicplatforminteraction.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/25 17:25
 */
@Setter
@Getter
public class PlatformLoginUserVo {

    /**
     * 基础平台当前登陆用户的id
     */
    private String id;

    /**
     * 基础平台当前登陆用户的账号
     */
    private String account;

}
