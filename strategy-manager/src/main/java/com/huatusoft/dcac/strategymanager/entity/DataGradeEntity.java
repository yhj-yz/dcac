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
@Table(name = "HT_DCAC_DATA_GRADE")
public class DataGradeEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 722342623154625226L;
    /**数据分级定义*/
    @Column(name = "GRADE_NAME",length = 50)
    private String gradeName;
    /**数据分级描述*/
    @Column(name = "GRADE_DESC",length = 255)
    private String gradeDesc;
    /**策略*/
    @OneToMany(mappedBy = "dataGradeEntity",fetch = FetchType.LAZY,cascade = {CascadeType.PERSIST,CascadeType.MERGE})
    @JsonIgnore
    private List<StrategyEntity> strategyEntities = new ArrayList<StrategyEntity>();
}
