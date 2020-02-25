package com.huatusoft.electronictag.web.config.property;

import com.huatusoft.electronictag.common.util.Rc4Utils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

import java.util.Enumeration;
import java.util.Properties;

/**
 * @author Shun
 */
public class ElectronicTagPropertyPlaceholderConfigurer extends PropertyPlaceholderConfigurer {
    @Override
    protected void processProperties(ConfigurableListableBeanFactory beanFactoryToProcess, Properties props) throws BeansException {
          
        Enumeration<?> keys = props.propertyNames();
        while (keys.hasMoreElements()) {  
            String key = (String)keys.nextElement();
            String value = props.getProperty(key);
            if (key.endsWith(".encryption") && null != value) {  
                props.remove(key);  
                key = key.substring(0, key.length() - 11);  
                value = Rc4Utils.decode(value.trim());
                props.setProperty(key, value);  
            }  
            System.setProperty(key, value);
        }  
          
        super.processProperties(beanFactoryToProcess, props);  
    }  
}  