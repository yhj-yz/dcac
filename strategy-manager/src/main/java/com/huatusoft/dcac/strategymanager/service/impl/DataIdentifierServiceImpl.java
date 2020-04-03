package com.huatusoft.dcac.strategymanager.service.impl;

import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.strategymanager.dao.DataIdentifierDao;
import com.huatusoft.dcac.strategymanager.entity.DataGradeEntity;
import com.huatusoft.dcac.strategymanager.entity.DataIdentifierEntity;
import com.huatusoft.dcac.strategymanager.service.DataIdentifierService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

/**
 * @author yhj
 * @date 2020-3-27
 */
@Service
public class DataIdentifierServiceImpl extends BaseServiceImpl<DataIdentifierEntity, DataIdentifierDao> implements DataIdentifierService{
    @Autowired
    private DataIdentifierDao dataIdentifierDao;

    @Override
    public Page<DataIdentifierEntity> findAllByPage(Pageable pageable, String identifierName, String identifierType) {
        Specification<DataIdentifierEntity> specification = new Specification<DataIdentifierEntity>() {
            @Override
            public Predicate toPredicate(Root<DataIdentifierEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(identifierName)) {
                    predicates.add(criteriaBuilder.like(root.get("identifierName").as(String.class), "%" + identifierName + "%"));
                }
                if (StringUtils.isNotBlank(identifierType)) {
                    predicates.add(criteriaBuilder.like(root.get("createUserAccount").as(String.class), "%" + identifierType + "%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }
}
