package com.huatusoft.dcac.strategymanager.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

/**
 * @author yhj
 * @date 2020-3-25
 */
@Getter
@Setter
@Entity
@Table(name = "HT_DCAC_DATA_SMALL_CLASSIFY")
public class DataClassifySmallEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 723563713495234326L;
    /**数据分类名称*/
    @Column(name = "CLASSIFY_NAME",length = 100)
    private String classifyName;
    /**描述*/
    @Column(name = "CLASSIFY_DESC",length = 255)
    private String classifyDesc;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "BIG_ID")
    @JsonIgnore
    private DataClassifyBigEntity dataClassifyBigEntity;
}
