package com.huatusoft.dcac.strategymanager.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.w3c.dom.stylesheets.LinkStyle;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author yhj
 * @date 2020-3-20
 */
@Getter
@Setter
@Entity
@Table(name = "HT_DCAC_DATA_BIG_CLASSIFY")
public class DataClassifyBigEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 723563712384625226L;
    /**数据分类名称*/
    @Column(name = "CLASSIFY_NAME",length = 100)
    private String classifyName;
    /**描述*/
    @Column(name = "CLASSIFY_DESC",length = 255)
    private String classifyDesc;

    @OneToMany(mappedBy = "dataClassifyBigEntity",fetch = FetchType.LAZY,cascade = {CascadeType.REMOVE})
    private List<DataClassifySmallEntity> dataClassifySmallEntities = new ArrayList<DataClassifySmallEntity>();
}
