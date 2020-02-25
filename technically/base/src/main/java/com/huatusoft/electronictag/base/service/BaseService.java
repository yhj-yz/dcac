package com.huatusoft.electronictag.base.service;
import com.huatusoft.electronictag.base.dao.BaseDao;
import com.huatusoft.electronictag.base.entity.BaseEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.QueryHints;

import javax.persistence.QueryHint;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/26 17:36
 */
public interface BaseService<E extends BaseEntity, D extends BaseDao> {

    /**
     * 用sql查询
     * @param entityClass 实体类
     * @param sql sql语句
     * @return
     */
    @QueryHints(@QueryHint(name = "org.hibernate.cacheable", value = "true"))
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
    void delete(Class<E> entityClass, String[] entityIds);

    /**
     * 获取实体
     *
     * @param entityId   实体id
     * @return
     */
    @QueryHints(@QueryHint(name = "org.hibernate.cacheable", value = "true"))
    E find(String entityId);


    /**
     * 查询所有
     * @returnE
     */
    @QueryHints(@QueryHint(name = "org.hibernate.cacheable", value = "true"))
    List<E> findAll();


    /**
     * 分页查询所有
     * @return
     */
    Page<E> findAllPage();

    /**
     * 分页查询所有
     *@param pageable 分页
     * @return
     */
    Page<E> findAllPage(Pageable pageable);

    /**
     * 分页查询
     * @param currentPageNumber 当前页
     * @param pageRows 每页显示的条数
     * @return
     */
    Page<E> findAllPage(Integer currentPageNumber, Integer pageRows);


    /**
     * 分页查询
     * @param specification 分页条件
     * @param pageable 分页
     * @return
     */
    @QueryHints(@QueryHint(name = "org.hibernate.cacheable", value = "true"))
    Page<E> findAllPageByCondition(Specification<E> specification, Pageable pageable);

}
