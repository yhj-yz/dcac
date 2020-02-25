package com.huatusoft.electronictag.authentication.exception.cast;

import com.huatusoft.electronictag.authentication.exception.AuthenticationException;
import com.huatusoft.electronictag.authentication.response.message.AuthenticationResultMessage;
import org.springframework.stereotype.Component;

/**
 * @author WangShun
 */
@Component
public class AuthenticationExceptionCast extends AbsAuthenticationExceptionCast {

	@Override
	public void castAuthenticationException(AuthenticationResultMessage message) throws AuthenticationException {
		castAuthenticationException(message, null);
	}

	@Override
	public void castAuthenticationException(AuthenticationResultMessage message, Object data) throws AuthenticationException {
		throw new AuthenticationException(message,String.valueOf(data));
	}

}