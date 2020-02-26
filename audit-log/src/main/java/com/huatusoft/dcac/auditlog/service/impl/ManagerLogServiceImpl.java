package com.huatusoft.dcac.auditlog.service.impl;

import com.huatusoft.dcac.auditlog.dao.ManagerLogDao;
import com.huatusoft.dcac.auditlog.entity.ManagerLogEntity;
import com.huatusoft.dcac.auditlog.service.ManagerLogService;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/29 11:52
 */
@Service
public class ManagerLogServiceImpl extends BaseServiceImpl<ManagerLogEntity, ManagerLogDao> implements ManagerLogService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ManagerLogServiceImpl.class);

    @Autowired
    private UserService userService;

    @Override
    public Page<ManagerLogEntity> findAll(Pageable pageable, String userAccount, String userName, String ip, String operateTime, String operationModel, String operationType, String operationContent, String orderby) {
        Specification<ManagerLogEntity> specification = new Specification<ManagerLogEntity>() {
            @Override
            public Predicate toPredicate(Root<ManagerLogEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(userAccount)) {
                    predicates.add(criteriaBuilder.like(root.get("userAccount").as(String.class), "%" + userAccount + "%"));
                }
                if (StringUtils.isNotBlank(userName)) {
                    predicates.add(criteriaBuilder.like(root.get("userName").as(String.class), "%" + userName + "%"));
                }
                if (StringUtils.isNotBlank(ip)) {
                    predicates.add(criteriaBuilder.like(root.get("ip").as(String.class), "%" + ip + "%"));
                }
                if (StringUtils.isNotBlank(operateTime)) {
                    String[] operationTime= operateTime.split("_");
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    Date startTime = null;
                    Date endTime = null;
                    try {
                        startTime = format.parse(operationTime[0]);
                        endTime  = format.parse(operationTime[1]);
                    }catch (ParseException e){
                        LOGGER.info("日期转换错误!");
                        e.printStackTrace();
                    }
                    predicates.add(criteriaBuilder.between(root.get("operateTime"),startTime,endTime));
                }
                if (StringUtils.isNotBlank(operationModel)) {
                    predicates.add(criteriaBuilder.equal(root.get("operationModel"),"%" + operationModel + "%"));
                }
                if (StringUtils.isNotBlank(operationType)) {
                    predicates.add(criteriaBuilder.equal(root.get("operationType"),"%" + operationType + "%"));
                }
                if (StringUtils.isNotBlank(operationContent)) {
                    predicates.add(criteriaBuilder.equal(root.get("operationContent"),"%" + operationContent + "%"));
                }
                if (StringUtils.isNotBlank(orderby)) {
                    if(orderby.equals("asc")){
                        criteriaQuery.orderBy(criteriaBuilder.asc(root.get("createDateTime")));
                    }
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public void addManagerLog(ManagerLogEntity managerLogEntity) {
        super.dao.save(managerLogEntity);
    }

    @Override
    public void addLoginFailLog(String userAccount) {
        ManagerLogEntity managerLogEntity = new ManagerLogEntity();
        UserEntity loginUser = userService.getUserByAccount(userAccount);
        if (Objects.isNull(loginUser)) {
            managerLogEntity.setDescription("账号[" + userAccount + "]不存在");
            managerLogEntity.setOperationModel("登陆认证");
            managerLogEntity.setOperationType("登陆失败");
            managerLogEntity.setGuid(UUID.randomUUID().toString().replace("-", ""));
        }
        super.dao.save(managerLogEntity);
    }

    @Override
    public void addLoginSuccessLog(UserEntity user) {
        ManagerLogEntity managerLogEntity = new ManagerLogEntity();
        managerLogEntity.setGuid(UUID.randomUUID().toString().replace("-",""));
        managerLogEntity.setDescription("<账号:["+user.getAccount()+"], 身份:["+user.getRole().getDescription()+"]>成功登陆");
        managerLogEntity.setOperationType("登陆成功");
        managerLogEntity.setOperationModel("登陆认证");
        super.dao.save(managerLogEntity);
    }
}
