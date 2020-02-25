package com.huatusoft.electronictag.separateapproval.service.impl;

import com.huatusoft.electronictag.base.service.BaseServiceImpl;
import com.huatusoft.electronictag.common.bo.PageableVo;
import com.huatusoft.electronictag.separateapproval.dao.WorkTaskDao;
import com.huatusoft.electronictag.separateapproval.entity.WorkTaskEntity;
import com.huatusoft.electronictag.separateapproval.service.WorkTaskService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.*;
import java.util.*;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/30 16:03
 */
@Service
public class WorkTaskServiceImpl extends BaseServiceImpl<WorkTaskEntity, WorkTaskDao> implements WorkTaskService {
    @Override
    public List<WorkTaskEntity> findListByProcessName(String processName) {
        return dao.findByProcessNameLike(" %" + processName + "% ");
    }

    @Override
    public Page<WorkTaskEntity> findPageByCondition(PageableVo pageableVo, String processName, String approveUser, String applyUserAccount, Date applyTime, Integer... status) {
        Pageable pageable = PageRequest.of(pageableVo.getPageNumber() - 1, pageableVo.getPageSize());
        return dao.findAll(new Specification<WorkTaskEntity>() {
            @Override
            public Predicate toPredicate(Root<WorkTaskEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = addCondition(root, criteriaBuilder, processName, approveUser, applyUserAccount, applyTime, status);
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        }, pageable);
    }

    @Override
    public WorkTaskEntity findByProcessName(String processName) {
        return dao.findWorkTaskEntityByProcessNameEquals(processName);
    }



    private List<Predicate> addCondition(Root<WorkTaskEntity> root, CriteriaBuilder criteriaBuilder, String processName, String approveUser, String applyUserAccount, Date applyTime, Integer... status) {
        List<Predicate> predicates = new ArrayList<>();
        if (StringUtils.isNotBlank(processName)) {
            predicates.add(criteriaBuilder.like(root.get("processName").as(String.class), "%" + processName + "%"));
        }
        if (StringUtils.isNotBlank(approveUser)) {
            predicates.add(criteriaBuilder.like(root.get("workFlow").get("approveAccount").as(String.class), "%" + approveUser + "%"));
        }
        if (StringUtils.isNotBlank(applyUserAccount)) {
            predicates.add(criteriaBuilder.equal(root.get("createUserAccount").as(String.class), applyUserAccount));
        }
        if (StringUtils.isNotBlank(approveUser)) {
            predicates.add(criteriaBuilder.equal(root.get("workFlow").get("approveAccount").as(String.class), approveUser));
        }
        if (Objects.nonNull(status)) {
            for (Integer integer : status) {
                predicates.add(criteriaBuilder.notEqual(root.get("status").as(Integer.class), integer));
            }
        }
        if (Objects.nonNull(applyTime)) {
            Calendar instance = Calendar.getInstance();
            instance.setTime(applyTime);
            instance.set(Calendar.DAY_OF_MONTH, +1);
            instance.set(Calendar.MINUTE, -1);
            predicates.add(criteriaBuilder.between(root.<Date>get("createDateTime"), applyTime, instance.getTime()));
        }
        return predicates;
    }
}
