package com.huatusoft.electronictag.systemsetting.entity;

import com.huatusoft.electronictag.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Cacheable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 18:02
 */
@Entity
@Getter
@Setter
@Cacheable
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "HT_ELECTRONICTAG_IPADDRESS")
public class IpAddressEntity extends BaseEntity {

    @Column(name = "IP", length = 32)
    private String ipAddress;

    @Column(name = "ACCESS_TIME")
    private Date authenticationDateTime;
}
