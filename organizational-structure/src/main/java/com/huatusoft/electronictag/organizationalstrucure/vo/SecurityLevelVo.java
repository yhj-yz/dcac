package com.huatusoft.electronictag.organizationalstrucure.vo;

import com.huatusoft.electronictag.base.entity.BaseEntity;
import com.huatusoft.electronictag.base.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 11:09
 */
@Getter
@Setter
public class SecurityLevelVo extends BaseVo {

    /** 密级名称 */
    private String securityName;
    /** 密级描述 */
    private String securityDesc;
}
