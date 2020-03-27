package com.huatusoft.dcac.strategymanager.service.impl;

import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.strategymanager.dao.StrategyDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;
import com.huatusoft.dcac.strategymanager.service.StrategyService;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.helper.StringUtil;
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

/**
 * @author yhj
 * @date 2020-3-20
 */
@Service
public class StrategyServiceImpl extends BaseServiceImpl<StrategyEntity, StrategyDao> implements StrategyService{
    @Autowired
    private StrategyDao strategyDao;

    @Override
    public Page<StrategyEntity> findAllByPage(Pageable pageable, String strategyName, String strategyDesc,String updateTime) {
        Specification<StrategyEntity> specification = new Specification<StrategyEntity>() {
            @Override
            public Predicate toPredicate(Root<StrategyEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(strategyName)) {
                    predicates.add(criteriaBuilder.like(root.get("strategyName").as(String.class), "%" + strategyName + "%"));
                }
                if(StringUtils.isNotBlank(strategyDesc)){
                    predicates.add(criteriaBuilder.like(root.get("strategyDesc").as(String.class),"%" + strategyDesc + "%"));
                }
                if(StringUtils.isNotBlank(updateTime)){
                    String[] updateTimes = updateTime.split("-");
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    Date startTime = null;
                    Date endTime = null;
                    try {
                        startTime = format.parse(updateTimes[0]);
                        endTime = format.parse(updateTimes[1]);
                    }catch (ParseException e){
                        e.printStackTrace();
                    }
                    predicates.add(criteriaBuilder.between(root.get("updateDateTime"),startTime,endTime));
                 }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }
}
