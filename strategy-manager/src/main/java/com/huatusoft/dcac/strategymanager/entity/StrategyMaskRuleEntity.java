package com.huatusoft.dcac.strategymanager.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Controller;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author yhj
 * @date 2020-4-3
 */
@Entity
@Getter
@Setter
@Table(name = "HT_DCAC_STRATEGY_MASK_RULE")
public class StrategyMaskRuleEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 133563713963421305L;
    /**规则名称*/
    @Column(name = "RULE_NAME",length = 100)
    private String ruleName;

    /**规则类型编码*/
    @Column(name = "RULE_TYPE_CODE",length = 1)
    private String ruleTypeCode;

    /**脱敏类型编码*/
    @Column(name = "MASK_TYPE_CODE",length = 1)
    private String maskTypeCode;

    /**脱敏效果(替换内容)*/
    @Column(name = "MASK_EFFECT",length = 100)
    private String maskEffect;

    /**脱敏内容*/
    @Column(name = "MASK_CONTENT",length = 100)
    private String maskContent;

    /**规则描述*/
    @Column(name = "RULE_DESC",length = 255)
    private String ruleDesc;

    @ManyToMany(cascade = {CascadeType.PERSIST,CascadeType.MERGE})
    @JoinTable(name = "STRATEGY_MASK",joinColumns = @JoinColumn(name = "ruleId"),inverseJoinColumns = @JoinColumn(name = "strategyId"))
    @JsonIgnore
    private List<StrategyEntity> strategyEntities = new ArrayList<StrategyEntity>();
}
