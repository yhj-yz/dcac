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
 * @date 2020-3-30
 */
@Entity
@Getter
@Setter
@Table(name = "HT_DCAC_DATA_LEVEL_RULE_SCOPE")
public class DataLevelRuleScopeEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 832423206436321239L;

    @Column(name = "SCOPE_CODE",length = 1)
    private String scopeCode;

    @Column(name = "SCOPE_NAME",length = 100)
    private String scopeName;
}
