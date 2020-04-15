package com.huatusoft.dcac.strategymanager.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author yhj
 * @date 2020-4-8
 */
@Entity
@Getter
@Setter
@Table(name = "HT_DCAC_STRATEGY_SCAN")
public class StrategyScanEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 323356212521419235L;

    /**扫描类型编码*/
    @Column(name = "SCAN_TYPE_CODE",length = 1)
    private String scanTypeCode;

    /**扫描类型名称*/
    @Column(name = "SCAN_TYPE_NAME",length = 255)
    private String scanTypeName;
}
