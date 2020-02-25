package com.huatusoft.electronictag.web.config.database;

import com.huatusoft.electronictag.common.bo.Principal;
import com.huatusoft.electronictag.common.util.Rc4Utils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

import javax.lang.model.SourceVersion;
import java.util.ArrayList;
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
