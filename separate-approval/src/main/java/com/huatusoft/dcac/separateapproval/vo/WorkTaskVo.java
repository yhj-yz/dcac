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
public class WorkTaskVo {
    private String processName;
    private String applyReason;
    private String flowId;
}
