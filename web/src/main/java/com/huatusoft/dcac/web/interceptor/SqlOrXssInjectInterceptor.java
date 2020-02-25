/**
 * 防止XSS攻击和Sql注入
 * @author yhj
 * @date 2019-11-7
 */
package com.huatusoft.dcac.web.interceptor;

import org.apache.xmlbeans.impl.piccolo.io.IllegalCharException;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;

public class SqlOrXssInjectInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {

        Enumeration names = request.getParameterNames();

        while (names.hasMoreElements()) {

            String name = (String) names.nextElement();

            String[] values = request.getParameterValues(name);

            for (String value : values) {
                String newValue = clearXss(value);
                if (!value.equals(newValue)) {
                    throw new IllegalCharException("您输入了非法字符,请重新输入");
                }
            }

        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object o, Exception e)
            throws Exception {

    }

    /**
     * 处理字符转义
     *
     * @param value * @return
     */
    private String clearXss(String value) {

        if (value == null || "".equals(value)) {

            return value;

        }
        //建议下面片段使用StringBuffer对象处理。
        value = value.replaceAll("<", "<").replaceAll(">", ">");

        value = value.replaceAll("\\(", "(").replace("\\)", ")");

        value = value.replaceAll("'", "'");

        value = value.replaceAll("eval\\((.*)\\)", "");

        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");

        value = value.replace("script", "");

        return value;

    }
}