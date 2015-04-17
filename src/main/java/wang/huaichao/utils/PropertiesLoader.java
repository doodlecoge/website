package wang.huaichao.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Created by Administrator on 2015/4/17.
 */
public class PropertiesLoader {
    private static final String suffix = ".properties";
    private Properties properties;

    private PropertiesLoader(String name) {
        if (name == null)
            throw new RuntimeException("file name not specified");
        if (!name.endsWith(suffix)) name = name + suffix;
        properties = new Properties();
        try {
            InputStream is = PropertiesLoader.class.getResourceAsStream("/" + name);
            properties.load(is);
        } catch (IOException e) {
            throw new RuntimeException("failed to get content of " + name);
        }
    }

    public static PropertiesLoader getInstance(String name) {
        return new PropertiesLoader(name);
    }

    public String getString(String key) {
        return properties.getProperty(key);
    }
}
