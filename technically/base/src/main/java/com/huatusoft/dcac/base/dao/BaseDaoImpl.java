package com.huatusoft.dcac.base.dao;

import com.huatusoft.dcac.base.entity.BaseEntity;
import org.springframework.data.jpa.repository.support.SimpleJpaRepository;

import javax.persistence.EntityManager;
import java.io.Serializable;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/26 16:05
 * <p>
 * Spring Data JPA都是调用SimpleJpaRepository来创建实例
 */
public class BaseDaoImpl<E extends BaseEntity, ID extends Serializable>
        extends SimpleJpaRepository<E, ID>
        implements BaseDao<E, ID> {

    /**
     * 用于操作数据库
     */
    protected final EntityManager em;

    /**
     * 父类没有不带参数的构造方法，这里手动构造父类
     */

    public BaseDaoImpl(Class<E> domainClass, EntityManager entityManager) {
        super(domainClass, entityManager);
        this.em = entityManager;
    }

    /**
     * 通过EntityManager来完成查询
     */

    @Override
    public <O> List<O> listBySql(Class<O> entityClass, String sql) {

        return (List<O>) em.createNativeQuery(sql, entityClass).getResultList();
    }

    @Override
    public void add(E entity) {
        save(entity);
    }

    @Override
    public void update(E entity) {
        saveAndFlush(entity);
    }

    @Override
    public void delete(Class<E> entityClass, ID[] entityIds) {
        for (Object id : entityIds) {
            em.remove(em.getReference(entityClass, id));
        }
    }

    @Override
    public E find(ID entityId) {
        return (E) super.findById(entityId).get();
    }
}
