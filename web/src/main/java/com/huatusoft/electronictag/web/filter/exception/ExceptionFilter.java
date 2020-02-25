package com.huatusoft.electronictag.web.filter.exception;
import com.huatusoft.electronictag.authentication.exception.AuthenticationException;
import com.huatusoft.electronictag.common.util.SpringContextUtils;
import com.huatusoft.electronictag.authentication.exception.handler.AuthenticationExceptionHandler;
import com.huatusoft.electronictag.securitystrategycenter.exception.PermissionException;
import com.huatusoft.electronictag.securitystrategycenter.exception.handler.PermissionExceptionHandler;
import com.huatusoft.electronictag.systemsetting.exception.SystemSettingException;
import com.huatusoft.electronictag.systemsetting.exception.handler.SystemSettingExceptionHandler;
import org.springframework.web.filter.OncePerRequestFilter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author WangShun
 */
public class ExceptionFilter extends OncePerRequestFilter {

    @Override
    public void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        try {
            filterChain.doFilter(request, response);
        } catch (Exception e) {
            String json = null;
            if(e instanceof AuthenticationException) {
                json = SpringContextUtils.getBean(AuthenticationExceptionHandler.class).handlingException((AuthenticationException)e);
            } else if (e instanceof SystemSettingException) {
                json = SpringContextUtils.getBean(SystemSettingExceptionHandler.class).handlingException((SystemSettingException)e);
            } else if (e instanceof PermissionException){
                json = SpringContextUtils.getBean(PermissionExceptionHandler.class).handlingException((PermissionException)e);
            }
            if(json != null) {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write(json);
            } else {
                e.printStackTrace();
            }
        }
    }
}