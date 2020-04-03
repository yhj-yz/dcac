package com.huatusoft.dcac.strategymanager.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

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
    /**策略类型*/
    @Column(name = "STRATEGY_TYPE",length = 1)
    private String strategyType;
}
