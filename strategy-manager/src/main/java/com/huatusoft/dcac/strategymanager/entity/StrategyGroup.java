package com.huatusoft.dcac.strategymanager.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @author yhj
 * @date 2020-4-18
 */
@Entity
@Getter
@Setter
@Table(name = "STRATEGY_GROUP")
public class StrategyGroup extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 232315713123222305L;

    @ManyToOne
    @JoinColumn(name = "strategyId")
    private StrategyEntity strategyEntity;

    @ManyToOne
    @JoinColumn(name = "groupId")
    private StrategyGroupEntity strategyGroupEntity;

    /**优先级*/
    @Column(name = "PRIORITY",length = 5)
    private int priority;
}
