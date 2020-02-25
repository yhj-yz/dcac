package com.huatusoft.dcac.organizationalstrucure.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 10:37
 */
@Entity
@Getter
@Setter
@Table(name="HT_ELECTRONICTAG_CONTROLLED_STRATEGY")
public class ControlledStrategyEntity extends BaseEntity {

    /**受控策略名称*/
    @Column(name = "STRATEGY_NAME", length = 32)
    private String name;
    /**受控策略描述*/
    @Column(name = "STRATEGY_DESC", length = 256)
    private String desc;
    /**关联应用程序*/
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "HT_ELECTRONICTAG_CONTROLLED_STRATEGY_PROGRAMENTITY_LINK"
            , joinColumns = @JoinColumn(name = "STRATEGY_ID")
            , inverseJoinColumns = @JoinColumn(name = "PROGRAM_ID"))
    private List<ProgramEntity> programs=new ArrayList<ProgramEntity>();

    @OneToMany(mappedBy = "controlledStrategy", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<UserEntity> users=new ArrayList<UserEntity>();
}
