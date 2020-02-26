package com.huatusoft.dcac.web.interceptor;

import com.huatusoft.dcac.common.util.HttpUtils;
import com.huatusoft.dcac.systemsetting.exception.cast.SystemSettingExceptionCast;
import com.huatusoft.dcac.systemsetting.service.IpAddressAuthenticationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Objects;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 17:53
 */
public class URLInterceptor implements HandlerInterceptor {

    @Autowired
    private IpAddressAuthenticationService ipAddressAuthenticationService;

    @Autowired
    private SystemSettingExceptionCast systemSettingExceptionCast;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String realIp = HttpUtils.getRealIp(request);
        return isLocalHost(realIp) || isContains(realIp);
    }



    private boolean isContains(String ip) {
        List<String> ips = ipAddressAuthenticationService.findAllIp();
        return !ips.isEmpty() && ips.contains(ip);
    }

    private boolean isLocalHost(String ip) {
        return Objects.equals("0:0:0:0:0:0:0:1",ip);
    }
}
