package com.huatusoft.dcac.basicplatforminteraction.vo;

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
public class PlatformSyncResult<R> {

    private String status;

    private String msg;

    private PlatformSyncData<R> data;

}
