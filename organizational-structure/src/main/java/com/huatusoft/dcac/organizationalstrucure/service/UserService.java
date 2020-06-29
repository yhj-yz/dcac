package com.huatusoft.dcac.organizationalstrucure.service;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.organizationalstrucure.dao.UserDao;
import com.huatusoft.dcac.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.LoginParamEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import org.springframework.data.domain.Page;

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

    /**
     * 客户端登陆
     * @param paramEntity
     * @return 找不到用户返回null
     */
    UserEntity login(LoginParamEntity paramEntity) throws Exception;

    /**
     * 外部访问系统页面
     * @param url
     * @param userNo
     * @return
     */
    String visitByOut(String url,String userNo);

    /**
     * 新增用户
     * @param departmentId
     * @param account
     * @param name
     * @param password
     * @return
     */
    Result addUser(String departmentId,String account, String name, String password);

    /**
     *
     * @param userId
     * @param account
     * @param userName
     * @param password
     * @param passwordSure
     * @return
     */
    Result updateUser(String userId,String account,String name,String password,String passwordSure);
}
