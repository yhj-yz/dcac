package com.huatusoft.dcac.strategymanager.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author yhj
 * @date 2020-4-18
 */
@Entity
@Getter
@Setter
@Table(name = "HT_DCAC_STRATEGY_GROUP")
public class StrategyGroupEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 231565713963122305L;
    /**组策略名称*/
    @Column(name = "GROUP_NAME",length = 100)
    private String groupName;
    /**组策略描述*/
    @Column(name = "GROUP_DESC",length = 255)
    private String groupDesc;

    @ManyToMany(cascade = {CascadeType.PERSIST,CascadeType.MERGE})
    @JoinTable(name = "STRATEGY_GROUP",joinColumns = @JoinColumn(name = "groupId"),inverseJoinColumns = @JoinColumn(name = "strategyId"))
    private List<StrategyEntity> strategyEntities = new ArrayList<StrategyEntity>();
}
