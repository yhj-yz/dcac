package com.huatusoft.electronictag.organizationalstrucure.vo;

import com.huatusoft.electronictag.base.entity.BaseEntity;
import com.huatusoft.electronictag.base.vo.BaseVo;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 10:21
 */
@Getter
@Setter
public class PermissionVo extends BaseVo {

    /** 权限集名称 */
    private String permissionName;

    /** 权限集描述 */
    private String permissionDesc;

    /** 权限 */
    private Integer userAuthority = 0;

    private List<UserVo> users = new ArrayList<UserVo>();

}
