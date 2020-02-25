package com.huatusoft.electronictag.systemsetting.service.impl;

import com.huatusoft.electronictag.base.service.BaseServiceImpl;
import com.huatusoft.electronictag.systemsetting.dao.IpAddressAuthenticationDao;
import com.huatusoft.electronictag.systemsetting.entity.IpAddressEntity;
import com.huatusoft.electronictag.systemsetting.service.IpAddressAuthenticationService;
import org.apache.commons.lang.StringUtils;
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

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 18:12
 */
@Service
public class IpAddressAuthenticationServiceImpl extends BaseServiceImpl<IpAddressEntity, IpAddressAuthenticationDao> implements IpAddressAuthenticationService {

    @Override
    public Page<IpAddressEntity> search(Integer pageNumber, Integer pageSize, String ip) {
        Pageable pageable = PageRequest.of(pageNumber - 1, pageSize);
        Specification<IpAddressEntity> specification = new Specification<IpAddressEntity>() {
            @Override
            public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if(StringUtils.isNotBlank(ip)) {
                    predicates.add(criteriaBuilder.and(criteriaBuilder.like(root.get("ipAddress").as(String.class),  " %" + ip + "% ")));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return dao.findAll(specification, pageable);
    }

    @Override
    public List<String> findAllIp() {
        return dao.findAllIpAddress();
    }


}
