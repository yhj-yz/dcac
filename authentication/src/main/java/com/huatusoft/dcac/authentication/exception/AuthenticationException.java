package com.huatusoft.dcac.authentication.exception;


import com.huatusoft.dcac.base.exception.CustomException;
import com.huatusoft.dcac.base.response.message.ResultMessage;
import lombok.Getter;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/29 13:24
 */
@Getter
public class AuthenticationException extends CustomException {

    private static final long serialVersionUID = -8764191822448875681L;

    public AuthenticationException(ResultMessage resultMessage) {
        this(resultMessage, null);
    }

    public AuthenticationException(ResultMessage resultMessage, String userAccount) {
        super(resultMessage, userAccount);
    }
}
