package com.huatusoft.electronictag.basicplatforminteraction.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 12:42
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PlatformInteractionResult<T> {
    /**
     * { "status":"0", "msg":"成功",
     * "data": { } }
     */

    private String status;

    private String msg;

    private T data;

    public static PlatformInteractionResult success() {
        return new PlatformInteractionResult("0", "成功", null);
    }

    public static <T> PlatformInteractionResult success(T data) {
        return new PlatformInteractionResult("0", "成功", data);
    }
}
