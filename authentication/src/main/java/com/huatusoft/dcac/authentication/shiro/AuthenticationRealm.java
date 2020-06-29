/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.huatusoft.dcac.authentication.shiro;

import com.huatusoft.dcac.organizationalstrucure.entity.AuthorityEntity;
import com.huatusoft.dcac.common.bo.Principal;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
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

/**
 * 权限认证
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public class AuthenticationRealm extends AuthorizingRealm {

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
                SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
                authorizationInfo.addStringPermissions(authorities);
                return authorizationInfo;
            }
        }
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken)  {
        //session
        Session session = SecurityUtils.getSubject().getSession();
        //获取用户名密码
        token = (UsernamePasswordToken) authenticationToken;
        //用户名
        account = token.getUsername();
        //加盐
        credentialsSalt = ByteSource.Util.bytes(account);
        user = userService.getUserByAccount(account);
        //如果是基础平台登陆
        password = new String(token.getPassword());
        if(session.getAttribute("basicPlatformReturnCurLoginAccount") != null && session.getAttribute("basicPlatformReturnCurLoginAccount").equals(password)) {
            session.removeAttribute("basicPlatformReturnCurLoginAccount");
            password = new SimpleHash("MD5", token.getPassword(),null,10).toString();
            authenticationInfo = new SimpleAuthenticationInfo(new Principal(user.getId(), user.getAccount(), user.getName()),password, getName());
        } else {
            authenticationInfo = new SimpleAuthenticationInfo(new Principal(user.getId(), user.getAccount(), user.getName()),user.getPassword(), credentialsSalt, getName());
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
