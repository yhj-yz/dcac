/**
 * @author yhj
 * @date 2019-11-12
 */
package com.huatusoft.dcac.securitystrategycenter.exception;

import com.huatusoft.dcac.base.exception.CustomException;
import com.huatusoft.dcac.base.response.message.ResultMessage;

public class PermissionException extends CustomException {

    private static final long serialVersionUID = -8164192832748881781L;

    public PermissionException(ResultMessage resultMessage) {
        this(resultMessage, null);
    }

    public PermissionException(ResultMessage resultMessage, String userAccount) {
        super(resultMessage, userAccount);
    }
}
