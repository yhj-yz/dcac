package com.huatusoft.dcac.base.dao;

import com.huatusoft.dcac.base.entity.BaseEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.NoRepositoryBean;

import java.io.Serializable;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/26 16:33
 */

@NoRepositoryBean
public interface BaseDao<E extends BaseEntity,ID extends Serializable> extends JpaRepository<E, ID>, JpaSpecificationExecutor<E> {

    /**
     * 用sql查询
     * @param entityClass 实体类
     * @param sql sql语句
     * @return
     */
    <O> List<O> listBySql(Class<O> entityClass, String sql);

    /**
     * 保存实体
     * @param entity 实体id
     */
    void add(E entity);

    /**
     * 更新实体
     * @param entity 实体
     */
    void update(E entity);

    /**
     * 删除实体
     * @param entityClass 实体类
     * @param entityIds   实体id数组
     */
    void delete(Class<E> entityClass, ID[] entityIds);

    /**
     * 获取实体
     *
     * @param entityId   实体id
     * @return
     */
     E find(ID entityId);

}
