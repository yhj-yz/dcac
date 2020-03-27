package com.huatusoft.dcac.auditlog.service.impl;

import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.auditlog.dao.AlarmLogDao;
import com.huatusoft.dcac.auditlog.entity.AlarmLogEntity;
import com.huatusoft.dcac.auditlog.service.AlarmLogService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

/**
 * @author yhj
 * @date 2019-2-25
 */
@Service
public class AlarmLogServiceImpl extends BaseServiceImpl<AlarmLogEntity, AlarmLogDao> implements AlarmLogService{
    private static final Logger LOGGER = LoggerFactory.getLogger(AlarmLogServiceImpl.class);

    @Override
    public Page<AlarmLogEntity> findAll(Pageable pageable, String warnDetail, String level, String userAccount, String operateTime, String readFlag) {
        Specification<AlarmLogEntity> specification = new Specification<AlarmLogEntity>() {
            @Override
            public Predicate toPredicate(Root<AlarmLogEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(userAccount)) {
                    predicates.add(criteriaBuilder.like(root.get("userAccount").as(String.class), "%" + userAccount + "%"));
                }
                if (StringUtils.isNotBlank(warnDetail)) {
                    predicates.add(criteriaBuilder.like(root.get("warnDetail").as(String.class), "%" + warnDetail + "%"));
                }
                if (StringUtils.isNotBlank(level)) {
                    predicates.add(criteriaBuilder.like(root.get("level").as(String.class), "%" + level + "%"));
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
                if (StringUtils.isNotBlank(readFlag)) {
                    predicates.add(criteriaBuilder.equal(root.get("readFlag"),Enum.valueOf(AlarmLogEntity.ReadFlag.class,readFlag)));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }
}
