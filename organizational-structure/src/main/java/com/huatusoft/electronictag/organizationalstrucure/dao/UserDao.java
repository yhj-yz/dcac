package com.huatusoft.electronictag.organizationalstrucure.dao;

import com.huatusoft.electronictag.base.dao.BaseDao;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;

import javax.persistence.QueryHint;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/27 16:11
 */
public interface UserDao extends BaseDao<UserEntity, String> {

    /**
     * 根据账号查询用户
     * @param account
     * @return
     */
    UserEntity findByAccountEquals(String account);

    /**
     * 根据用户账号查询用户数量
     * @param account
     * @return
     */
    @QueryHints(@QueryHint(name = "org.hibernate.cacheable", value = "true"))
    Long countByAccount(String account);

    /**
     * 查询所有状态可用的用户
     * @param disabledCode 禁用代码
     * @return
     */
    List<UserEntity> findByStatusNotIn(Integer... disabledCode);

    /**
     * 根据accounts查询用户数量
     * @param accounts
     * @return
     */
    Long countByAccountIn(List<String> accounts);

    /**
     * 根据是否是系统内置用户查询
     * @param status 状态
     * @return
     */
    List<UserEntity> findByIsSystem(Integer status);

    /**
     * 更新登陆失败次数
     * @param id
     * @param count
     */
    @Modifying
    @Query(value = "UPDATE FROM HT_ELECTRONICTAG_USER SET USER_LOGIN_FAILURE_COUNT = :count WHERE id = :id", nativeQuery = true)
    void updateLoginFailureCount(String id, Integer count);
}
