package com.huatusoft.dcac.separateapproval.service.impl;

import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.separateapproval.dao.WorkFlowDao;
import com.huatusoft.dcac.separateapproval.entity.WorkFlowEntity;
import com.huatusoft.dcac.separateapproval.service.WorkFlowService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/29 10:08
 */
@Service
public class WorkFlowServiceImpl extends BaseServiceImpl<WorkFlowEntity, WorkFlowDao> implements WorkFlowService {
    @Override
    public boolean isWorkFlowNameRepeat(String workFlowName) {
        return Objects.nonNull(dao.findByFlowName(workFlowName));
    }

    @Override
    public Page<WorkFlowEntity> findPage(String workFlowName, Integer PageNumber, Integer PageSize, String curLoginUserAccount) {
        Pageable pageable = PageRequest.of(PageNumber - 1, PageSize);
        return dao.findAll(new Specification<WorkFlowEntity>() {
            @Override
            public Predicate toPredicate(Root<WorkFlowEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(workFlowName)) {
                    predicates.add(criteriaBuilder.like(root.get("flowName").as(String.class), "%"+ workFlowName +"%"));
                }
                predicates.add(criteriaBuilder.equal(root.get("createUserAccount").as(String.class), curLoginUserAccount));
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        }, pageable);
    }

    @Override
    public List<WorkFlowEntity> findWorkFlowByCreateAccount(String account) {
        return dao.findByCreateUserAccountEquals(account);
    }


}
