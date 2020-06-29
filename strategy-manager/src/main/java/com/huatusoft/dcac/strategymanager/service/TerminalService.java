package com.huatusoft.dcac.strategymanager.service;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.strategymanager.dao.TerminalDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;
import com.huatusoft.dcac.strategymanager.entity.TerminalEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * @author yhj
 * @date 2020-6-24
 */
public interface TerminalService extends BaseService<TerminalEntity, TerminalDao> {

    /**
     * 分页查询
     * @param pageable
     * @param deviceName
     * @param ipAddress
     * @param systemVersion
     * @param versionInform
     * @param connectStatus
     * @param scanStatus
     * @return
     */
    Page<TerminalEntity> findAllByPage(Pageable pageable, String deviceName, String ipAddress, String systemVersion,String versionInform,String connectStatus,String scanStatus);

    /**
     * 根据客户端id获取客户端
     * @param clientId
     * @return
     */
    TerminalEntity findByClientId(String clientId);

    /**
     * 终端关联用户
     * @param terminalId
     * @param userId
     * @return
     */
    Result setUser(String terminalId, String userId);

    /**
     * 终端关联组策略
     * @param terminalId
     * @param groupId
     * @return
     */
    Result setStrategyGroup(String terminalId,String groupId);
}
