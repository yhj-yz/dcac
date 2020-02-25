package com.huatusoft.electronictag.basicplatforminteraction.vo;

import lombok.*;

import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 12:42
 */
@Data
public class PlatformSyncData<R> {
    private String total;
    private List<R> info;
}
