package com.huatusoft.dcac.auditlog.model;

import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/10 16:52
 */
public class ManagerLogDescriptionParse {
    public static String parse(UserEntity user, ManagerLogOperationModel operationModel, ManagerLogOperationType operationType, String cause) {
       return  "<账号:["+user.getAccount()+"], 身份:["+user.getRole().getName()+"]>" + operationModel.getName() + operationType.getName() + ",原因:" + cause;
    }
}
