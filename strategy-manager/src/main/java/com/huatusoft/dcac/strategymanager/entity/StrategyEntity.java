package com.huatusoft.dcac.strategymanager.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
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
@Table(name = "HT_DCAC_STRATEGY")
public class StrategyEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 823563713963418105L;
    /**策略名称*/
    @Column(name = "STRATEGY_NAME",length = 100)
    private String strategyName;
    /**策略描述*/
    @Column(name = "STRATEGY_DESC",length = 255)
    private String strategyDesc;
    /**数据分类编号*/
    @Column(name = "DATA_CLASSIFY_ID",length = 32)
    private String dataClassifyId;
    /**数据分级编号*/
    @Column(name = "DATA_GRADE_ID",length = 32)
    private String dataGradeId;
    /**扫描类型*/
    @Column(name = "SCAN_TYPE_CODE",length = 1)
    private String scanTypeCode;
    /**响应类型*/
    @Column(name = "RESPONSE_TYPE_CODE",length = 1)
    private String responseTypeCode;

    @ManyToMany(cascade = CascadeType.PERSIST)
    @JoinTable(name = "STRATEGY_RULE",joinColumns = @JoinColumn(name = "strategyId"),inverseJoinColumns = @JoinColumn(name = "ruleId"))
    private List<StrategyRuleEntity> strategyRuleEntities = new ArrayList<StrategyRuleEntity>();

    @ManyToMany(cascade = CascadeType.PERSIST)
    @JoinTable(name = "STRATEGY_MASK",joinColumns = @JoinColumn(name = "strategyId"),inverseJoinColumns = @JoinColumn(name = "ruleId"))
    private List<StrategyMaskRuleEntity> strategyMaskRuleEntities = new ArrayList<StrategyMaskRuleEntity>();
}
