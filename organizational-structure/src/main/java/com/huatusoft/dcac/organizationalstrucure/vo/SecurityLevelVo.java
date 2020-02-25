package com.huatusoft.dcac.organizationalstrucure.vo;

import com.huatusoft.dcac.base.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

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
