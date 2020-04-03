package com.huatusoft.dcac.strategymanager.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author yhj
 * @date 2020-3-20
 */
@Entity
@Getter
@Setter
@Table(name = "HT_DCAC_STRATEGY_RULE")
public class StrategyRuleEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 223355195435319119L;

    /**规则名称*/
    @Column(name = "RULE_NAME", length = 100)
    private String ruleName;

    /**规则描述*/
    @Column(name = "RULE_DESC",length = 255)
    private String ruleDesc;

    /**默认值*/
    @Column(name = "LEVEL_DEFAULT_CODE",length = 1)
    private String levelDefaultCode;

    @OneToMany(mappedBy = "strategyRuleEntity",fetch = FetchType.LAZY,cascade = {CascadeType.REMOVE})
    private List<DataLevelRuleEntity> dataLevelRuleEntities = new ArrayList<DataLevelRuleEntity>();

    @OneToMany(mappedBy = "strategyRuleEntity",fetch = FetchType.LAZY,cascade = {CascadeType.REMOVE})
    private List<StrategyRuleContentEntity> strategyRuleContentEntities = new ArrayList<StrategyRuleContentEntity>();
}
