package com.huatusoft.dcac.auditlog.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 用于生成1000条数据
 */
@Getter
@Setter
public class FileLog{
    private String fileName;
    private String fileMd5;
}
