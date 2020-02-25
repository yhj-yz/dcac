package com.huatusoft.dcac.base.service;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.base.entity.BaseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/26 17:37
 */
@Transactional(rollbackFor = Exception.class, readOnly = true)
public class BaseServiceImpl<E extends BaseEntity, D extends BaseDao> implements BaseService<E, D> {

    @Autowired
    protected D dao;

    @Override
    public <O> List<O> listBySql(Class<O> entityClass, String sql) {
        return dao.listBySql(entityClass,sql);
    }

    @Override
    @Transactional(rollbackFor = Exception.class, readOnly = false)
    public void add(E entity) {
        dao.add(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class, readOnly = false)
    public void update(E entity) {
        dao.update(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class, readOnly = false)
    public void delete(Class<E> entityClass, String[] entityIds) {
        dao.delete(entityClass, entityIds);
    }

    @Override
    public E find(String entityId) {
        return (E)dao.find(entityId);
    }

    @Override
    public List<E> findAll() {
        return dao.findAll();
    }

    @Override
    public Page<E> findAllPage() {
        return findAllPage(null, null);
    }

    @Override
    public Page<E> findAllPage(Integer currentPageNumber, Integer pageRows) {
        if(Objects.isNull(currentPageNumber)) {
            currentPageNumber = 0;
        }
        if(Objects.isNull(pageRows)) {
            pageRows = 10;
        }
        Pageable pageable = PageRequest.of(currentPageNumber - 1, pageRows);
        return findAllPage(pageable);
    }

    @Override
    public Page<E> findAllPage(Pageable pageable) {
        return findAllPageByCondition(null, pageable);
    }

    @Override
    public Page<E> findAllPageByCondition(Specification<E> specification, Pageable pageable) {
        return dao.findAll(specification, pageable);
    }
}