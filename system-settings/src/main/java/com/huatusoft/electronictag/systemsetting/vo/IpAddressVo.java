package com.huatusoft.electronictag.systemsetting.vo;

import com.huatusoft.electronictag.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.Pattern;
import java.util.Date;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 18:02
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IpAddressVo extends BaseEntity {

    private String ipAddress;
}
