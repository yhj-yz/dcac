package com.huatusoft.dcac.strategymanager.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @author yhj
 * @date 2020-3-20
 */
@Entity
@Getter
@Setter
@Table(name = "HT_DCAC_DATA_LEVEL_RULE")
public class DataLevelRuleEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 832352195335259119L;

    /**匹配范围编码*/
    @Column(name = "RULE_SCOPE_CODE",length = 1)
    private String ruleScopeCode;

    /**匹配范围值*/
    @Column(name = "RULE_SCOPE_VALUE",length = 100)
    private String ruleScopeValue;

    /**数据严重程度编码*/
    @Column(name = "LEVEL_CODE",length = 1)
    private String levelCode;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "RULE_ID")
    @JsonIgnore
    StrategyRuleEntity strategyRuleEntity;
}
