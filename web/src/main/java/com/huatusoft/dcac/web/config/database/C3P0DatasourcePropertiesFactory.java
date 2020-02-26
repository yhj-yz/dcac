package com.huatusoft.dcac.web.config.database;

import com.huatusoft.dcac.common.util.Rc4Utils;

import java.util.Properties;

/**
 * @author WangShun
 */
public class C3P0DatasourcePropertiesFactory {
    private static final String PROP_PASSWORD = "password";

    public static Properties getProperties(String pwd) throws Exception {
        Properties p = new Properties();
        try {
            //解密操作
            p.setProperty(PROP_PASSWORD, Rc4Utils.decode(pwd));
        } catch (Exception e) {
            throw e;
        }
        return p;
    }

    public static void main(String[] args) {
    }
}
