/**
 * @author yhj
 * @date 2019-10-18
 */
package com.huatusoft.electronictag.systemsetting.service.impl;

import com.huatusoft.electronictag.base.service.BaseServiceImpl;
import com.huatusoft.electronictag.systemsetting.dao.NetworkProcessDao;
import com.huatusoft.electronictag.systemsetting.entity.NetworkProcessEntity;
import com.huatusoft.electronictag.systemsetting.service.NetworkProcessService;
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
public class NetworkProcessServiceImpl extends BaseServiceImpl<NetworkProcessEntity, NetworkProcessDao> implements NetworkProcessService {
    @Override
    public Page<NetworkProcessEntity> findAll(Pageable pageable, String processName) {
        Specification<NetworkProcessEntity> specification = new Specification<NetworkProcessEntity>() {
            @Override
            public Predicate toPredicate(Root<NetworkProcessEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(processName)) {
                    predicates.add(criteriaBuilder.like(root.get("processName").as(String.class), "%" + processName +"%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }
}
