package com.huatusoft.electronictag.organizationalstrucure.service;

import com.huatusoft.electronictag.base.service.BaseService;
import com.huatusoft.electronictag.organizationalstrucure.dao.UserDao;
import com.huatusoft.electronictag.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/27 16:06
 */
public interface UserService extends BaseService<UserEntity, UserDao> {

    /**
     * 根据账号获取用户信息
     * @param account
     * @return
     */
    UserEntity getUserByAccount(String account);

    /**
     * 根据用户名查询用户是否存在
     * @param account
     * @return
     */
    boolean isExistsByAccount(String account);
    /**
     * 根据用户名查询用户是否不存在
     * @param account
     * @return
     */
    boolean isNotExistsByAccount(String account);

    /**
     * 查询所有可用用户
     * @return
     */
    List<UserEntity> findAllAvailable();

    /**
     * 根据部门id查询该部门下所有用户
     * @param dept 部门
     * @param pageNumber 当前页
     * @param pageSize 每页显示条数
     * @param account 用户账号
     * @return
     */
    Page<UserEntity> findUsersByDept(DepartmentEntity dept, Integer pageNumber, Integer pageSize, String account);

    /**
     * 保存或者更新
     * @param userEntities
     */
    void saveOrUpdate(List<UserEntity> userEntities);

    /**
     * 查询用户是否是内置用户
     * @param isSystem
     * @return
     */
    List<UserEntity> findByIsSystem(Integer isSystem);

    /**
     * 获取当前用户名
     * @return
     */
    UserEntity getCurrentUser();
    /**
     *
     * @param userId
     * @param acount
     */
    void updateLoginCount(String userId, Integer acount);

}
