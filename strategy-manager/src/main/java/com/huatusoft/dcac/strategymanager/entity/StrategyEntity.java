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
    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "DATA_CLASSIFY_ID")
    private DataClassifySmallEntity dataClassifySmallEntity;
    /**数据分级编号*/
    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "DATA_GRADE_ID")
    private DataGradeEntity dataGradeEntity;
    /**扫描类型*/
    @Column(name = "SCAN_TYPE_CODE",length = 1)
    private String scanTypeCode;
    /**响应类型*/
    @Column(name = "RESPONSE_TYPE_CODE",length = 1)
    private String responseTypeCode;
    /**扫描路径*/
    @Column(name = "SCAN_PATH",length = 255)
    private String scanPath;
    /**匹配数*/
    @Column(name = "MATCH_VALUE",length = 10)
    private int matchValue;

    @ManyToMany(cascade = {CascadeType.PERSIST,CascadeType.MERGE})
    @JoinTable(name = "STRATEGY_RULE",joinColumns = @JoinColumn(name = "strategyId"),inverseJoinColumns = @JoinColumn(name = "ruleId"))
    private List<StrategyRuleEntity> strategyRuleEntities = new ArrayList<StrategyRuleEntity>();

    @ManyToMany(cascade = {CascadeType.PERSIST,CascadeType.MERGE})
    @JoinTable(name = "STRATEGY_MASK",joinColumns = @JoinColumn(name = "strategyId"),inverseJoinColumns = @JoinColumn(name = "ruleId"))
    private List<StrategyMaskRuleEntity> strategyMaskRuleEntities = new ArrayList<StrategyMaskRuleEntity>();

    @ManyToMany
    @JsonIgnore
    @JoinTable(name = "STRATEGY_GROUP",joinColumns = @JoinColumn(name = "strategyId"),inverseJoinColumns = @JoinColumn(name = "groupId"))
    private List<StrategyGroupEntity> strategyGroupEntities = new ArrayList<StrategyGroupEntity>();

}
