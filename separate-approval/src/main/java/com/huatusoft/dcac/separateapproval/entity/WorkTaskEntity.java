package com.huatusoft.dcac.separateapproval.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/30 15:39
 */
@Entity
@Table(name = "HT_ELECTRONICTAG_WORK_TASK")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class WorkTaskEntity extends BaseEntity {

    /**
     * 流程名称
     */
    @Column(name = "TASK_PROCESS_NAME", length = 50, unique = true)
    private String processName;

    /**
     * 申请原因(描述)
     */
    @Column(name = "TASK_APPLY_REASON", length = 255)
    private String applyReason;

    /**
     * 文件上传位置
     */
    @Column(name = "TASK_UPLOAD_FILE_PATH", length = 255)
    private String uploadFilePath;

    /**
     * 审批通过后文件位置
     */
    @Column(name = "TASK_DOWNLOAD_FILE_PATH", length = 255)
    private String downloadPath;

    /**
     * 审批状态, 0 未处理, 1.审批通过, 2.审批尚未通过
     */
    @Column(name = "TASK_status", length = 1)
    private Integer status = 0;

    /**
     * 原因
     */
    @Column(name = "TASK_CAUSE", length = 255)
    private String cause;

    /**
     * 流程信息
     */
    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "WORKFLOW_ID")
    private WorkFlowEntity workFlow;

    public WorkTaskEntity(String processName, String applyReason, String filePath, WorkFlowEntity o, Integer status) {
        this.processName = processName;
        this.applyReason = applyReason;
        this.uploadFilePath = filePath;
        this.workFlow = o;
        this.status = status;
    }
}
