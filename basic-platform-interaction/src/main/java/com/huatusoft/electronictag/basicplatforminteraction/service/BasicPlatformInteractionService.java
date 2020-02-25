package com.huatusoft.electronictag.basicplatforminteraction.service;
import com.huatusoft.electronictag.base.service.BasicPlatformService;
import com.huatusoft.electronictag.basicplatforminteraction.service.impl.AbstractBasicPlatformService;
import com.huatusoft.electronictag.organizationalstrucure.service.DepartmentService;
import com.huatusoft.electronictag.organizationalstrucure.service.UserService;

import java.util.Date;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 16:02
 */
public interface BasicPlatformInteractionService extends BasicPlatformService {

    /**
     * 同步并保存基础平台部门信息
     * @param basicPlatformSyncService 同步服务
     * @param departmentService 保存所需部门服务
     * @param accessToken 访问基础平台token
     * @param syncDate 最后同步时间
     * @param pageNumber 当前页
     * @param pageRows 每页条数
     * @return 基础平台总部门数量
     * @throws Exception
     */
    Integer syncSaveDepartments(
            BasicPlatformSyncService basicPlatformSyncService
            , DepartmentService departmentService
            , String accessToken
            , Date syncDate
            , Integer pageNumber
            , Integer pageRows) throws Exception;

    /**
     * 同步并保存基础平台用户信息
     * @param basicPlatformSyncService 同步服务
     * @param userService 保存所需部门服务
     * @param accessToken 访问基础平台token
     * @param syncDate 最后同步时间
     * @param pageNumber 当前页
     * @param pageRows 每页条数
     * @return 基础平台总用户数量
     * @throws Exception
     */
    Integer syncSaveUsers(
            BasicPlatformSyncService basicPlatformSyncService
            , UserService userService
            , String accessToken
            , Date syncDate
            , Integer pageNumber
            , Integer pageRows) throws Exception;
}
