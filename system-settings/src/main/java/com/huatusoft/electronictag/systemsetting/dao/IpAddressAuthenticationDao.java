package com.huatusoft.electronictag.systemsetting.dao;

import com.huatusoft.electronictag.base.dao.BaseDao;
import com.huatusoft.electronictag.systemsetting.entity.IpAddressEntity;
import com.querydsl.core.annotations.QueryInit;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;

import javax.persistence.QueryHint;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 18:12
 */
public interface IpAddressAuthenticationDao extends BaseDao<IpAddressEntity, String> {
    @QueryHints(@QueryHint(name = "org.hibernate.cacheable", value = "true"))
    List<IpAddressEntity> findAll();

    @QueryHints(@QueryHint(name = "org.hibernate.cacheable", value = "true"))
    @Query(value = "SELECT ipAddress FROM HT_ELECTRONICTAG_IPADDRESS", nativeQuery = true)
    List<String> findAllIpAddress();
}
