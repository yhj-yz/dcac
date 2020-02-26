package com.huatusoft.dcac.systemsetting.service;

import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.systemsetting.dao.IpAddressAuthenticationDao;
import com.huatusoft.dcac.systemsetting.entity.IpAddressEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.QueryHints;

import javax.persistence.QueryHint;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 18:11
 */
public interface IpAddressAuthenticationService extends BaseService<IpAddressEntity, IpAddressAuthenticationDao> {
    /**
     * 根据ip分页查询
     * @param pageNumber 页码
     * @param pageSize 每页显示条数
     * @param ip ip地址
     * @return 分页后
     */
    @QueryHints(@QueryHint(name = "org.hibernate.cacheable", value = "true"))
    Page<IpAddressEntity> search(Integer pageNumber, Integer pageSize, String ip);

    @QueryHints(@QueryHint(name = "org.hibernate.cacheable", value = "true"))
    List<String> findAllIp();

}
