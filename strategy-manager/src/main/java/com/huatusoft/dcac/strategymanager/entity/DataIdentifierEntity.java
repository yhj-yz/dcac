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
 * @date 2020-3-27
 */
@Entity
@Getter
@Setter
@Table(name = "HT_DCAC_DATA_IDENTIFIER")
public class DataIdentifierEntity extends BaseEntity{
    @Transient
    private static final long serialVersionUID = 722343234215234826L;

    /**标识符名称*/
    @Column(name = "IDENTIFIER_NAME",length = 100)
    private String identifierName;

    /**标识符类别*/
    @Column(name = "IDENTIFIER_TYPE",length = 100)
    private String identifierType;
}
