/**
 * 应用程序控制实体类
 * @author yhj
 * @date 2019-10-31
 */
package com.huatusoft.dcac.organizationalstrucure.entity;

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
@Table(name="HT_ELECTRONICTAG_SOFTWARE")
public class SoftWareEntity extends BaseEntity {
    /**是否是配置*/
    @Column(name = "IS_CONFIG", length = 1)
    private Boolean isConfig;
    /**是否系统内置*/
    @Column(name = "IS_SYSTEM", length  = 1)
    private Boolean isSystem;
    /**软件名称*/
    @Column(name = "SOFT_NAME", length = 256)
    private String softName;
    /**进程*/
    @OneToMany(mappedBy = "softWareEntity",fetch = FetchType.LAZY,cascade = {CascadeType.REMOVE})
    private List<ProcessEntity> processEntities = new ArrayList<ProcessEntity>();
    /**用户*/
    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "USER_ID")
    private UserEntity userEntity;

    /**
     * 添加进程
     * @param processEntity
     */
    public void addProcess(ProcessEntity processEntity){
        this.processEntities.add(processEntity);
        processEntity.setSoftWareEntity(this);
    }
}
