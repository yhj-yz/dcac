/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.dcac.authentication.shiro;

import com.huatusoft.dcac.organizationalstrucure.entity.AuthorityEntity;
import com.huatusoft.dcac.common.bo.BasisPlatformInfo;
import com.huatusoft.dcac.common.bo.CommonAttributes;
import com.huatusoft.dcac.common.bo.Principal;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


/**
 * 权限认证
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public class AuthenticationRealm extends AuthorizingRealm {

    private SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();

    @Autowired
    private UserService userService;

    private UsernamePasswordToken token;

    private UserEntity user;

    private ByteSource credentialsSalt;

    private SimpleAuthenticationInfo authenticationInfo;

    private String account;

    private String password;



    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        //获取用户信息
        Principal principal = (Principal) principals.fromRealm(getName()).iterator().next();
        if (principal != null) {
            List<String> authorities = this.getAuthorities(principal.getId());
            if (authorities != null && authorities.size() > 0) {
                authorizationInfo.addStringPermissions(authorities);
                return authorizationInfo;
            }
        }
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken)  {
        //获取Session
        Session session = SecurityUtils.getSubject().getSession();
        //查看是否是基础平台单点登陆
        String basicPlatformReturnCurLoginAccount = String.valueOf(session.getAttribute(BasisPlatformInfo.CURRENT_LOGIN_ACCOUNT));
        //获取用户名密码
        token = (UsernamePasswordToken) authenticationToken;
        if(StringUtils.isBlank(token.getUsername())) {
            account = basicPlatformReturnCurLoginAccount;
            token.setUsername(account);
        } else {
            account = String.valueOf(token.getUsername());
        }
        if(Objects.isNull(token.getPassword())) {
            password = basicPlatformReturnCurLoginAccount;
            token.setPassword(password.toCharArray());
        } else {
            password = String.valueOf(token.getPassword());
        }
        //加盐
        credentialsSalt = ByteSource.Util.bytes(account);
        user = userService.getUserByAccount(account);
        //如果是基础平台登陆
        if(StringUtils.isNotBlank(basicPlatformReturnCurLoginAccount) && !Objects.equals(CommonAttributes.STRING_NULL, basicPlatformReturnCurLoginAccount)) {
            session.removeAttribute(BasisPlatformInfo.CURRENT_LOGIN_ACCOUNT);
            password = new SimpleHash("MD5",password,credentialsSalt,10).toString();
            authenticationInfo = new SimpleAuthenticationInfo(new Principal(user.getId(), user.getAccount(), user.getName()), password, credentialsSalt, getName());
            return authenticationInfo;
        } else {
            authenticationInfo = new SimpleAuthenticationInfo(new Principal(user.getId(), user.getAccount(), user.getName()), user.getPassword(), credentialsSalt, getName());
        }
        return authenticationInfo;
    }

    private List<String> getAuthorities(String id) {
        ArrayList<String> authoritys = new ArrayList<>();
        for (AuthorityEntity authorityEntity : userService.find(id).getRole().getAuthorities()) {
            authoritys.add(authorityEntity.getAuthorityName());
        }
        return authoritys;
    }

}
