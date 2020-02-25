/**
 * @author yhj
 * @date 2019-10-16
 */
package com.huatusoft.dcac.securitystrategycenter.service.impl;


import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.organizationalstrucure.entity.ControlledStrategyEntity;
import com.huatusoft.dcac.securitystrategycenter.dao.ControlledStrategyDao;
import com.huatusoft.dcac.securitystrategycenter.service.ControlledStrategyService;
import org.apache.commons.lang3.StringUtils;
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

@Service
public class ControlledStrategyServiceImpl extends BaseServiceImpl<ControlledStrategyEntity, ControlledStrategyDao> implements ControlledStrategyService{
    @Override
    public Page<ControlledStrategyEntity> findAll(Pageable pageable,String name) {
        Specification<ControlledStrategyEntity> specification = new Specification<ControlledStrategyEntity>() {
            @Override
            public Predicate toPredicate(Root<ControlledStrategyEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(name)) {
                    predicates.add(criteriaBuilder.like(root.get("name").as(String.class), "%" + name +"%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

}
