package com.huatusoft.dcac.authentication.filter;

import java.util.Date;
import java.util.Objects;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.huatusoft.dcac.authentication.exception.cast.AuthenticationExceptionCast;
import com.huatusoft.dcac.authentication.response.message.AuthenticationResultMessage;
import com.huatusoft.dcac.base.exception.CustomException;
import com.huatusoft.dcac.basicplatforminteraction.service.BasicPlatformAccessControlService;
import com.huatusoft.dcac.basicplatforminteraction.service.BasicPlatformSingleSignOnService;
import com.huatusoft.dcac.common.bo.BasisPlatformInfo;
import com.huatusoft.dcac.common.constant.SystemConstants;
import com.huatusoft.dcac.common.util.SpringContextUtils;
import com.huatusoft.dcac.auditlog.service.ManagerLogService;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

/**
 * 自定义登陆认证filter
 *
 * @author WangShun
 */
@Getter
@Setter
@Component
public class AdminAuthenticationFilter extends FormAuthenticationFilter {

    private Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    private UserService userService;

    private ManagerLogService managerLogService;

    private String adminIndex;

    private String adminLogin;

    private Subject subject;

    private AuthenticationToken authenticationToken;

    @Autowired
    private AuthenticationExceptionCast authenticationExceptionCast;

    @Autowired
    private BasicPlatformAccessControlService basicPlatformAccessControlService;

    @Autowired
    private BasicPlatformSingleSignOnService basicPlatformSingleSignOnService;

    /**
     * 执行登陆操作
     */
    @Override
    protected boolean executeLogin(ServletRequest request, ServletResponse response) throws Exception {
        //1.创建依赖对象,获取依赖数据
        //获取subject
        subject = super.getSubject(request, response);
        //创建token
        authenticationToken = super.createToken(request, response);
        //获取当前输入账号
        String account = String.valueOf(authenticationToken.getPrincipal());
        HttpServletRequest rq = (HttpServletRequest) request;
        //获取基础平台传递过来的token
        String basicPlatformToken = getBasicPlatformToken(rq.getQueryString());
        //获取验证码
        String systemGeneratorCode = String.valueOf(rq.getSession().getAttribute("code"));
        //删除验证码,用于一次性登陆,避免重复登陆
        rq.getSession().removeAttribute("code");
        //获取用户输入的验证码
        String userInputCode = rq.getParameter("checkCode");
        //初始化当前登陆用户
        UserEntity user = null;
        //2.如果基础平台token不为空,首先请求基础平台,获取当前基础平台登陆用户,执行单点登陆功能
        if (StringUtils.isNotBlank(basicPlatformToken)) {
            //请求基础平台,获取当前基础平台登陆用户
            account = requestBasePlatformGetUserAccountByToken(basicPlatformToken);
            //像数据库中查询当前登陆用户,查看用户是否存在,如果存在,将当前用户信息存入session中, 跳过验证码验证
            user = userService.getUserByAccount(account);
            if (Objects.nonNull(user)) {
                rq.getSession().setAttribute(BasisPlatformInfo.CURRENT_LOGIN_ACCOUNT, account);
                userInputCode = systemGeneratorCode;
            }
        }
        //校验验证码
        if (!systemGeneratorCode.equalsIgnoreCase(userInputCode)) {
            return onLoginFailure(account, authenticationToken, AuthenticationResultMessage.VERIFICATION_CODE_INPUT_IS_INCORRECT_MESSAGE, request, response);
        } else {
            //如果user为null,说明不包含token,走正常登陆流程,如果user不为null,说明基础平台返回了当前登陆用户
            if (Objects.isNull(user)) {
                user = userService.getUserByAccount(account);
                if (Objects.isNull(user)) {
                    // 用户名不存在
                    return onLoginFailure(account, authenticationToken, AuthenticationResultMessage.USER_NOT_EXIST_MESSAGE, request, response);
                } else {
                    // 校验用户状态
                    if (!Objects.equals(user.getStatus(), 0) || Objects.equals(user.getIsDisable(), 1) || Objects.equals(user.getIsLocked(), 1)) {
                        //锁定尚未结束
                        if (new Date().before(user.getLockedDate())) {
                            return onLoginFailure(account, authenticationToken, AuthenticationResultMessage.USER_HAS_DISABLED_MESSAGE, request, response);
                        }
                    }
                    //登陆,走ream
                    try {
                        subject.login(authenticationToken);
                    } catch (IncorrectCredentialsException e) {
                        return onLoginFailure(account, authenticationToken, AuthenticationResultMessage.PASSWORD_WRONG_MESSAGE, request, response);
                    }
                }
            }
            return onLoginSuccess(user, authenticationToken, subject, request, response);
        }
    }

    /**
     * 初始化service及登陆跳转
     */
    @Override
    public boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        if (userService == null) {
            userService = (UserService) SpringContextUtils.getBean(UserService.class);
        }
        if (managerLogService == null) {
            managerLogService = (ManagerLogService) SpringContextUtils.getBean(ManagerLogService.class);
        }
        boolean isAllowed = isAccessAllowed(request, response, mappedValue);
        // 登陆跳转
        if (isAllowed && isLoginRequest(request, response)) {
            try {
                issueSuccessRedirect(request, response);
            } catch (Exception e) {
                LOGGER.error("", e);
            }
            return false;
        }
        return isAllowed || onAccessDenied(request, response, mappedValue);
    }

    @Override
    protected void issueSuccessRedirect(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String successUrl = getAdminIndex() != null ? getAdminIndex() : super.getSuccessUrl();
        WebUtils.redirectToSavedRequest(req, res, successUrl);
    }

    @Override
    protected boolean isLoginRequest(ServletRequest req, ServletResponse resp) {
        String loginUrl = getAdminLogin() != null ? getAdminLogin() : super.getLoginUrl();
        return pathsMatch(loginUrl, req);
    }

    /**
     * 登陆成功
     */
    private boolean onLoginSuccess(UserEntity user, AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response)
            throws Exception {
        //记录登陆成功日志
        addManagerLog(user);
        // 将系统当前登陆用户信息放入session
        subject.getSession().setAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_ACCOUNT, user.getAccount());
        subject.getSession().setAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_KEY, user);
        return super.onLoginSuccess(token, subject, request, response);
    }

    /**
     * 登陆失败
     */
    private boolean onLoginFailure(String username, AuthenticationToken token, AuthenticationResultMessage message, ServletRequest request,
                                   ServletResponse response) throws CustomException {
        authenticationExceptionCast.castCustomerException(message, username);
        return super.onLoginFailure(token, null, request, response);
    }

    private String getBasicPlatformToken(String queryString) {
        String token = null;
        if (queryString != null && queryString.contains(BasisPlatformInfo.TOKEN)) {
            String[] split = queryString.split("&");
            if (split != null) {
                for (String str : split) {
                    String[] split1 = str.split("=");
                    if ("token".equals(split1[0])) {
                        token = split1[1];
                        break;
                    }
                }
            }
        }
        return token;
    }

    private String requestBasePlatformGetUserAccountByToken(String token) throws Exception {
        /*String account = singleSignOnService.requestPlatformLoginUser(accessControlService.getBasicPlatformAccessToken()
                , String.valueOf(getServletContext().getAttribute(PlatformConstants.ACCESS_APP_ID))).getAccount();*/
        return token;
    }

    private void addManagerLog(UserEntity user) {
        user.setLoginDate(new Date());
        user.setLoginFailureCount(0);
        userService.update(user);
        //记录登陆成功日志
        managerLogService.addLoginSuccessLog(user);
    }
}