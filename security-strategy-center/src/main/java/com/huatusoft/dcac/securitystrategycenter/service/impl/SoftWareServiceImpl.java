/**
 * @author yhj
 * @date 2019-11-4
 */
package com.huatusoft.dcac.securitystrategycenter.service.impl;

import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.organizationalstrucure.entity.ManagerTypeEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.ProcessEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.SoftWareEntity;
import com.huatusoft.dcac.securitystrategycenter.dao.ManagerTypeDao;
import com.huatusoft.dcac.securitystrategycenter.dao.ProcessDao;
import com.huatusoft.dcac.securitystrategycenter.dao.SoftWareDao;
import com.huatusoft.dcac.securitystrategycenter.service.SoftWareService;
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

@Service
public class SoftWareServiceImpl extends BaseServiceImpl<SoftWareEntity, SoftWareDao> implements SoftWareService{
    @Autowired
    private SoftWareDao softWareDao;

    @Autowired
    private ProcessDao processDao;

    @Autowired
    private ManagerTypeDao managerTypeDao;

    @Override
    public Page<SoftWareEntity> findAllByPage(Pageable pageable, String softName) {
        Specification<SoftWareEntity> specification = new Specification<SoftWareEntity>() {
            @Override
            public Predicate toPredicate(Root<SoftWareEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(softName)) {
                    predicates.add(criteriaBuilder.like(root.get("softName").as(String.class), "%" + softName +"%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public boolean isNameRepeat(String softName) {
        Integer count= softWareDao.countBySoftName(softName);
        if(count == 0){
            return false;
        }else {
            return true;
        }
    }

    @Override
    public void addRest(ProcessEntity processEntity, ManagerTypeEntity managerTypeEntity) {
        processDao.add(processEntity);
        managerTypeDao.add(managerTypeEntity);
    }

    @Override
    public void deleteConfig(String[] processIds) {
        processDao.delete(ProcessEntity.class,processIds);
    }

    @Override
    public ProcessEntity findProcessById(String id) {
        return processDao.find(id);
    }

    @Override
    public void updateConfig(ProcessEntity processEntity) {
        processDao.update(processEntity);
    }

    @Override
    public boolean isProcessRepeat(String softId,String processName) {
        boolean isRepeat = false;
        List<ProcessEntity> list= processDao.findByProcessName(processName);
        for(ProcessEntity entity : list){
            if(entity.getSoftWareEntity().getId().equals(softId)){
                isRepeat = true;
                break;
            }
        }
        return isRepeat;
    }

}
