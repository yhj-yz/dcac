package com.huatusoft.dcac.separateapproval.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 工作流业务类
 * @author WangShun
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class WorkFlowVo {

    public WorkFlowVo(String id, String workFlowName) {
        this.id = id;
        this.workFlowName = workFlowName;
    }

    private String id;

    /**
     *  新增工作流名称
     */
    private String workFlowName;

    /**
     * 0.管理员  1.指定其他审批人
     */
    private Integer approveUserType;

    /**
     * 审批人
     */
    private String approveUser;

    private String state;  // 0.激活  1.挂起

    private String createTime;

    private String updateTime;

    private String defaultApproveTime; //默认审批时间


    private String defaultApproveUnit;  //默认审批单位

    private String defaultApproveState;  //默认审批状态

    private String description;     //流程描述

}
