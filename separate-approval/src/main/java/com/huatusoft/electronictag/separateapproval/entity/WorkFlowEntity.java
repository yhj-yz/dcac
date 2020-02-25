package com.huatusoft.electronictag.separateapproval.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.electronictag.base.entity.BaseEntity;
import com.huatusoft.electronictag.separateapproval.domain.ApproverType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

/**
 * @author WangShun
 */
@Getter
@Setter
@Entity
@Cacheable
@Table(name = "HT_ELECTRONICTAG_WORK_FLOW")
@NoArgsConstructor
@AllArgsConstructor
public class WorkFlowEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 535963672251176798L;
    @Column(name = "FLOW_NAME", length = 255)
    private String flowName;
    /**
     * 流程描述
     */
    @Column(name = "FLOW_DESC", length = 255)
    private String description;

    /**
     * 审批人员类型   1.管理员  0.指定其他审批人
     */
    @Column(name = "FLOW_APPROVER_TYPE", length = 10)
    private ApproverType approverType;
    /**
     * 审批人账号
     */
    @Column(name = "FLOW_APPROVE_USER")
    private String approveAccount;

    @OneToMany(mappedBy = "workFlow",fetch = FetchType.LAZY)
    @JsonIgnore
    private List<WorkTaskEntity> workTasks;

    public WorkFlowEntity(String workFlowName, String description, ApproverType approverType, String approveUser) {
        this.flowName = workFlowName;
        this.description = description;
        this.approverType = approverType;
        this.approveAccount = approveUser;
    }
}