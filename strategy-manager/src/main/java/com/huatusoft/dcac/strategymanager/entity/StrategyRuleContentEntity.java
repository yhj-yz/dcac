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
@Table(name = "HT_DCAC_STRATEGY_RULE_CONTENT")
public class StrategyRuleContentEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 223455295535319112L;

    /**规则类型编码*/
    @Column(name = "RULE_TYPE_CODE",length = 1)
    private String ruleTypeCode;

    /**是否添加规则*/
    @Column(name = "IS_CONTAIN",length = 1)
    private boolean isContain;

    /**匹配内容(输入内容)*/
    @Column(name = "MATCH_CONTENT",length = 100)
    private String matchContent;

    /**规则内容*/
    @Column(name = "RULE_CONTENT",length = 255)
    private String ruleContent;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "RULE_ID")
    @JsonIgnore
    private StrategyRuleEntity strategyRuleEntity;
}
