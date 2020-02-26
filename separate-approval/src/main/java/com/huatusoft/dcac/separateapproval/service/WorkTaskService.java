package com.huatusoft.dcac.separateapproval.service;

import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.separateapproval.dao.WorkTaskDao;
import com.huatusoft.dcac.separateapproval.entity.WorkTaskEntity;
import org.springframework.data.domain.Page;

import java.util.Date;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/30 16:02
 */
public interface WorkTaskService extends BaseService<WorkTaskEntity, WorkTaskDao> {
    /**
     * 根据流程名称查询
     * @param processName 流程名称
     * @return 流程任务集合
     */
    List<WorkTaskEntity> findListByProcessName(String processName);


    /**
     * 条件分页查询
     * @param pageableVo 分页信息
     * @param processName 流程任务名称
     * @param applyUserAccount 申请人账号
     * @param applyTime 申请时间
     * @param approveUser 申请者账号
     * @param status 审批状态
     *
     * @return
     */
    Page<WorkTaskEntity> findPageByCondition(PageableVo pageableVo, String processName, String approveUser, String applyUserAccount, Date applyTime, Integer... status);


    /**
     * 根据流程名称精确查询
     * @param processName 流程名称
     * @return 流程任务集合
     */
    WorkTaskEntity findByProcessName(String processName);



}
