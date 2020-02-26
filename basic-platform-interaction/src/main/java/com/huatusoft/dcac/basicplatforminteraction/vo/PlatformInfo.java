package com.huatusoft.dcac.basicplatforminteraction.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 12:46
 */

@Getter
@Setter
public class PlatformInfo {
    private String app_id;
    private String app_secret;
    /**
     * 1 表示部门变化，2 表示用户变化，3 表示部门用户变化。
     */
    private String type;
}
