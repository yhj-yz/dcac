/**
 * @author yhj
 * @date 2019-10-31
 */
package com.huatusoft.dcac.organizationalstrucure.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name="HT_ELECTRONICTAG_PROCESS")
public class ProcessEntity extends BaseEntity {
    /**名称*/
    @Column(name = "PROCESS_NAME",length = 2048)
    private String processName;
    @OneToMany(mappedBy = "processEntity",fetch = FetchType.LAZY,cascade = {CascadeType.REMOVE})
    private List<ManagerTypeEntity> managerTypeEntities = new ArrayList<ManagerTypeEntity>();
    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "SOFT_ID")
    @JsonIgnore
    private SoftWareEntity softWareEntity;

    /**
     * 添加受控类型
     * @param managerTypeEntity
     */
    public void addManagerType(ManagerTypeEntity managerTypeEntity){
        this.managerTypeEntities.add(managerTypeEntity);
        managerTypeEntity.setProcessEntity(this);
    }
}
