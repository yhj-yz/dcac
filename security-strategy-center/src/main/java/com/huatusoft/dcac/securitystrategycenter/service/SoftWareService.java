/**
 * @author yhj
 * @date 2019-11-4
 */
package com.huatusoft.dcac.securitystrategycenter.service;

import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.organizationalstrucure.entity.ManagerTypeEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.ProcessEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.SoftWareEntity;
import com.huatusoft.dcac.securitystrategycenter.dao.SoftWareDao;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface SoftWareService extends BaseService<SoftWareEntity, SoftWareDao>{
    /**
     * 分页查询
     * @param pageable
     * @param softName
     * @return
     */
    Page<SoftWareEntity> findAllByPage(Pageable pageable,String softName);

    /**
     * 判断软件名称是否重复
     * @param softName
     * @return
     */
    boolean isNameRepeat(String softName);

    /**
     * 将进程和受控类型持久化到数据库
     * @param processEntity
     * @param managerTypeEntity
     */
    void addRest(ProcessEntity processEntity, ManagerTypeEntity managerTypeEntity);

    /**
     * 删除配置
     * @param processIds
     */
    void deleteConfig(String[] processIds);

    /**
     * 根据id获取进程
     * @param id
     * @return
     */
    ProcessEntity findProcessById(String id);

    /**
     * 更新配置
     * @param processEntity
     */
    void updateConfig(ProcessEntity processEntity);

    /**
     * 根据进程名判断是否重复
     * @param processName
     * @return
     */
    boolean isProcessRepeat(String softId,String processName);
}
