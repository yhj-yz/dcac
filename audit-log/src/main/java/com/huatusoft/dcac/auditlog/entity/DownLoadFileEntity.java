package com.huatusoft.dcac.auditlog.entity;

import com.huatusoft.dcac.auditlog.entity.base.BaseLoginEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * @author yhj
 * @date 2020-4-9
 */
@Getter
@Setter
public class DownLoadFileEntity extends BaseLoginEntity {
    /**下载文件类型 1、DG.XML*/
    private Integer type;
    /**文件MD5码，MD5码与服务器一致，则不下载*/
    private String fileMd5;
}
