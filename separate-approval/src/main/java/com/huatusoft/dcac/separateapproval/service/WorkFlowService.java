package com.huatusoft.dcac.separateapproval.service;

import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.separateapproval.dao.WorkFlowDao;
import com.huatusoft.dcac.separateapproval.entity.WorkFlowEntity;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/29 10:05
 */
public interface WorkFlowService extends BaseService<WorkFlowEntity, WorkFlowDao> {
    /**
     * 查询工作流名称是否重复
     * @param workFlowName
     * @return
     */
    boolean isWorkFlowNameRepeat(String workFlowName);

    /**
     * 根据流程名称分页查询
     * @param workFlowName 流程名称
     * @param PageNumber 当前页码
     * @param PageSize 每页显示条数
     * @param curLoginUserAccount 当前用户登陆账号
     * @return
     */
    Page<WorkFlowEntity> findPage(String workFlowName, Integer PageNumber, Integer PageSize, String curLoginUserAccount);

    /**
     * 查询流程根据当前账号
     * @param account 账号
     * @return
     */
    List<WorkFlowEntity> findWorkFlowByCreateAccount(String account);
}
