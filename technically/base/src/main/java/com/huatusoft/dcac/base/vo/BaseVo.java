package com.huatusoft.dcac.base.vo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/25 16:04
 */

@Getter
@Setter
public class BaseVo implements Serializable {

    private String id;

    /** 创建者*/
    private String createUserAccount;

    private Date createDateTime;

    /** 修改者*/
    private String updateUserAccount;

    private Date updateDateTime;
}
