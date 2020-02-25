/**
 * @author yhj
 * @date 2019-11-1
 */
package com.huatusoft.dcac.organizationalstrucure.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Getter
@Setter
@Entity
@Table(name="HT_ELECTRONICTAG_MANAGER_TYPE")
public class ManagerTypeEntity extends BaseEntity{
    /**节点名称 */
    @Column(name = "MANAGE_NAME",length = 2048)
    private String manageName;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "PROCESS_ID")
    @JsonIgnore
    private ProcessEntity processEntity;
}
