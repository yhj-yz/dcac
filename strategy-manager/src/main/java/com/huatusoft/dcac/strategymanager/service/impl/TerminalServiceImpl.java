package com.huatusoft.dcac.strategymanager.service.impl;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.organizationalstrucure.dao.UserDao;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.strategymanager.dao.StrategyGroupDao;
import com.huatusoft.dcac.strategymanager.dao.TerminalDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyGroupEntity;
import com.huatusoft.dcac.strategymanager.entity.TerminalEntity;
import com.huatusoft.dcac.strategymanager.service.TerminalService;
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
 * @date 2020-6-24
 */
@Service
public class TerminalServiceImpl extends BaseServiceImpl<TerminalEntity, TerminalDao> implements TerminalService {

    @Autowired
    private TerminalDao terminalDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private StrategyGroupDao strategyGroupDao;

    @Override
    public Page<TerminalEntity> findAllByPage(Pageable pageable, String deviceName, String ipAddress, String systemVersion, String versionInform, String connectStatus, String scanStatus) {
        Specification<TerminalEntity> specification = new Specification<TerminalEntity>() {
            @Override
            public Predicate toPredicate(Root<TerminalEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(deviceName)) {
                    predicates.add(criteriaBuilder.like(root.get("deviceName").as(String.class), "%" + deviceName + "%"));
                }
                if(StringUtils.isNotBlank(ipAddress)){
                    predicates.add(criteriaBuilder.like(root.get("ipAddress").as(String.class),"%" + ipAddress + "%"));
                }
                if(StringUtils.isNotBlank(systemVersion)){
                    predicates.add(criteriaBuilder.like(root.get("systemVersion").as(String.class),"%" + systemVersion + "%"));
                }
                if(StringUtils.isNotBlank(versionInform)){
                    predicates.add(criteriaBuilder.like(root.get("versionInform").as(String.class),"%" + versionInform + "%"));
                }
                if(StringUtils.isNotBlank(connectStatus)){
                    predicates.add(criteriaBuilder.like(root.get("connectStatus").as(String.class),"%" + connectStatus + "%"));
                }
                if(StringUtils.isNotBlank(scanStatus)){
                    predicates.add(criteriaBuilder.like(root.get("scanStatus").as(String.class),"%" + scanStatus + "%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public TerminalEntity findByClientId(String clientId) {
        return terminalDao.findByClientId(clientId);
    }

    @Override
    public Result setUser(String terminalId, String userId) {
        TerminalEntity terminalEntity = this.find(terminalId);
        UserEntity userEntity = userDao.find(userId);
        if(userEntity == null){
            return new Result("用户不存在!");
        }
        terminalEntity.setUserId(userId);
        terminalDao.update(terminalEntity);
        return new Result("200","关联用户成功",null);
    }

    @Override
    public Result setStrategyGroup(String terminalId, String groupId) {
        TerminalEntity terminalEntity = this.find(terminalId);
        StrategyGroupEntity strategyGroupEntity = strategyGroupDao.find(groupId);
        if(strategyGroupEntity == null){
            return new Result("组策略不存在!");
        }
        terminalEntity.setGroupId(groupId);
        terminalDao.update(terminalEntity);
        return new Result("200","关联组策略成功!",null);
    }
}
