package com.huatusoft.dcac.systemsetting.vo;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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
