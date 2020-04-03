package com.huatusoft.dcac.strategymanager.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
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
@Table(name = "HT_DCAC_DATA_LEVEL")
public class DataLevelEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 722342345325234319L;

    /**数据严重程度编码*/
    @Column(name = "LEVEL_CODE",length = 1)
    private String levelCode;

    /**数据严重程度名称*/
    @Column(name = "LEVEL_NAME",length = 50)
    private String levelName;
}
