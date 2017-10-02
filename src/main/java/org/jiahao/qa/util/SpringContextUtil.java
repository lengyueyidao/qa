package org.jiahao.qa.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import java.util.Properties;

/**
 * 上下文工具类，用来获取配置文件（sysparm.properties）中的参数
 * Created by Alvin on 2016/11/5.
 */
public class SpringContextUtil implements ApplicationContextAware{

    private static ApplicationContext context;

    public void setApplicationContext(ApplicationContext context) throws BeansException {
        this.context = context;
    }

    public static ApplicationContext getApplicationContext() {
        return context;
    }

    public static String getSysParamsByName(String name) {
        Properties p = (Properties) context.getBean("sysparamproperties");
        return p.getProperty(name);
    }

}
