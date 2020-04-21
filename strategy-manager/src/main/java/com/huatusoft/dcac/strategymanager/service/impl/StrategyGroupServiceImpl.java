package com.huatusoft.dcac.strategymanager.service.impl;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.strategymanager.dao.StrategyDao;
import com.huatusoft.dcac.strategymanager.dao.StrategyGroupDao;
import com.huatusoft.dcac.strategymanager.dao.StrategyGroupRelationDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;
import com.huatusoft.dcac.strategymanager.entity.StrategyGroup;
import com.huatusoft.dcac.strategymanager.entity.StrategyGroupEntity;
import com.huatusoft.dcac.strategymanager.service.StrategyGroupService;
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
 * @date 2020-4-18
 */
@Service
public class StrategyGroupServiceImpl extends BaseServiceImpl<StrategyGroupEntity, StrategyGroupDao> implements StrategyGroupService {

    @Autowired
    private StrategyGroupDao strategyGroupDao;

    @Autowired
    private StrategyDao strategyDao;

    @Autowired
    private StrategyGroupRelationDao strategyGroupRelationDao;

    @Override
    public Page<StrategyGroupEntity> findAllByPage(Pageable pageable, String groupName, String groupDesc, String createUserAccount) {
        Specification<StrategyGroupEntity> specification = new Specification<StrategyGroupEntity>() {
            @Override
            public Predicate toPredicate(Root<StrategyGroupEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(groupName)) {
                    predicates.add(criteriaBuilder.like(root.get("groupName").as(String.class), "%" + groupName + "%"));
                }
                if (StringUtils.isNotBlank(createUserAccount)) {
                    predicates.add(criteriaBuilder.like(root.get("createUserAccount").as(String.class), "%" + createUserAccount + "%"));
                }
                if (StringUtils.isNotBlank(groupDesc)) {
                    predicates.add(criteriaBuilder.like(root.get("groupDesc").as(String.class), "%" + groupDesc + "%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public Result addStrategyGroup(String groupName, String groupDesc, String strategyId) {
        if(isGroupNameRepeat(groupName)){
            return new Result("组策略名称重复,请重新输入!");
        }
        try {
            StrategyGroupEntity strategyGroupEntity = new StrategyGroupEntity();
            strategyGroupEntity.setGroupName(groupName);
            strategyGroupEntity.setGroupDesc(groupDesc);
            strategyGroupDao.add(strategyGroupEntity);
            String[] idAndPriorities = strategyId.split(",");
            for(String idAndPriority : idAndPriorities){
                String[] idPriority = idAndPriority.split(";");
                String id = idPriority[0];
                int priority = 0;
                try {
                    priority = Integer.parseInt(idPriority[1]);
                }catch (NumberFormatException e){
                    e.printStackTrace();
                    return new Result("优先级错误!");
                }
                StrategyGroup strategyGroup = new StrategyGroup();
                StrategyEntity strategyEntity = strategyDao.find(id);
                strategyGroup.setStrategyEntity(strategyEntity);
                strategyGroup.setStrategyGroupEntity(strategyGroupEntity);
                strategyGroup.setPriority(priority);
                strategyGroupRelationDao.add(strategyGroup);
            }
        }catch (Exception e){
            e.printStackTrace();
            return new Result("添加组策略失败,请稍后再试!");
        }
        return new Result("200","添加组策略成功!",null);
    }

    @Override
    public StrategyGroupEntity findById(String id) {
        StrategyGroupEntity strategyGroupEntity = strategyGroupDao.find(id);
        for(StrategyEntity strategyEntity : strategyGroupEntity.getStrategyEntities()){
            StrategyGroup strategyGroup = strategyGroupRelationDao.findByStrategyGroupEntityAndStrategyEntity(strategyGroupEntity,strategyEntity);
            strategyEntity.setId(strategyEntity.getId()+";"+strategyGroup.getPriority());
        }
        return strategyGroupEntity;
    }

    @Override
    public Result updateStrategyGroup(String groupId, String groupName, String groupDesc, String strategyId) {
        StrategyGroupEntity strategyGroupEntity = strategyGroupDao.find(groupId);
        if(isGroupNameRepeat(groupName) && !strategyGroupEntity.getGroupName().equals(groupName)){
            return new Result("组策略名称重复,请重新输入!");
        }
        strategyGroupEntity.setGroupName(groupName);
        strategyGroupEntity.setGroupDesc(groupDesc);
        strategyGroupEntity.setStrategyEntities(null);
        strategyGroupDao.update(strategyGroupEntity);
        String[] idAndPriorities = strategyId.split(",");
        for(String idAndPriority : idAndPriorities){
            String[] idPriority = idAndPriority.split(";");
            String id = idPriority[0];
            int priority = 0;
            try {
                priority = Integer.parseInt(idPriority[1]);
            }catch (NumberFormatException e){
                e.printStackTrace();
                return new Result("优先级错误!");
            }
            StrategyEntity strategyEntity = strategyDao.find(id);
            StrategyGroup strategyGroup = new StrategyGroup();
            strategyGroup.setStrategyEntity(strategyEntity);
            strategyGroup.setStrategyGroupEntity(strategyGroupEntity);
            strategyGroup.setPriority(priority);
            strategyGroupRelationDao.add(strategyGroup);
        }
        return new Result("200","修改组策略成功!",null);
    }

    /**
     * 判断组策略名称是否重复
     * @param groupName
     * @return
     */
    private boolean isGroupNameRepeat(String groupName){
        List<StrategyGroupEntity> strategyGroupEntities = strategyGroupDao.findAll();
        for(StrategyGroupEntity strategyGroupEntity : strategyGroupEntities){
            if(strategyGroupEntity.getGroupName().equals(groupName)){
                return true;
            }
        }
        return false;
    }
}
