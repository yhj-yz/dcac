package com.huatusoft.electronictag.authentication.exception.cast;

import com.huatusoft.electronictag.authentication.exception.AuthenticationException;
import com.huatusoft.electronictag.authentication.response.message.AuthenticationResultMessage;
import com.huatusoft.electronictag.base.exception.CustomException;
import com.huatusoft.electronictag.base.exception.cast.AbsBaseExceptionCast;
import com.huatusoft.electronictag.base.response.message.ResultMessage;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/11 16:46
 */
public abstract class AbsAuthenticationExceptionCast extends AbsBaseExceptionCast {

    public abstract void castAuthenticationException(AuthenticationResultMessage message) throws AuthenticationException;

    public abstract void castAuthenticationException(AuthenticationResultMessage message, Object data) throws AuthenticationException;

    @Override
    public void castCustomerException(ResultMessage resultMessage) throws CustomException {
        if(resultMessage instanceof AuthenticationResultMessage) {
            castAuthenticationException(((AuthenticationResultMessage) resultMessage));
        }
    }

    @Override
    public void castCustomerException(ResultMessage resultMessage, Object data) throws CustomException {
        if(resultMessage instanceof AuthenticationResultMessage) {
            castAuthenticationException(((AuthenticationResultMessage) resultMessage), data);
        }
    }
}
