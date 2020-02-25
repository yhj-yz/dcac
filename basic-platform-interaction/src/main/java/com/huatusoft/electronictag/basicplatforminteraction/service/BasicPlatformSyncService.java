package com.huatusoft.electronictag.basicplatforminteraction.service;

import com.huatusoft.electronictag.base.service.BasicPlatformService;
import com.huatusoft.electronictag.basicplatforminteraction.vo.BasicPlatformDepartmentVo;
import com.huatusoft.electronictag.basicplatforminteraction.vo.BasicPlatformUserVo;
import com.huatusoft.electronictag.basicplatforminteraction.vo.PlatformSyncResult;

import java.util.Date;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 14:02
 */
public interface BasicPlatformSyncService extends BasicPlatformService {

    /**
     * 同步基础平台用户
     * @param syncTime
     * @param accessToken
     * @param pageNumber
     * @param pageSize
     * @return 同步用户列表
     */
    PlatformSyncResult<BasicPlatformUserVo> syncUsers(Date syncTime, String accessToken, Integer pageNumber, Integer pageSize) throws Exception;

    /**
     * 同步基础平台部门
     * @param syncTime 子系统部门信息的最后变更时间（指基础平台时间）。时间格式为yyyy-MM-dd HH:mm:ss，如果时间为””，则请求服务器返回所有部门信息。
     * @param accessToken 认证令牌
     * @param pageNumber 页数，从 1 开始
     * @param pageSize 每页记录数
     * @return 同步部门列表
     */
    PlatformSyncResult<BasicPlatformDepartmentVo> syncDepartments(Date syncTime, String accessToken, Integer pageNumber, Integer pageSize) throws Exception;



}
