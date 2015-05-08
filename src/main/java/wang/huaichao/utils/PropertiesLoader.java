package wang.huaichao.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Created by Administrator on 2015/4/17.
 */
public class PropertiesLoader {
    private static final Logger log =
            LoggerFactory.getLogger(PropertiesLoader.class);
    private static final String suffix = ".properties";
    private Properties properties;

    private PropertiesLoader(String name) {
        if (name == null) {
            throw new RuntimeException("file name not specified");
        }
        try {
            InputStream is = _getStreamFromClassPath(name);
            if (is == null)
                throw new RuntimeException("get resource failed: " + name);
            properties = new Properties();
            properties.load(is);
        } catch (IOException e) {
            throw new RuntimeException("failed to get content of " + name);
        }
    }

    private static InputStream _getStreamFromClassPath(String name) {
        if (name == null) return null;
        if (!name.endsWith(suffix)) name = name + suffix;
        if (!name.startsWith("/")) name = "/" + name;
        return PropertiesLoader.class.getResourceAsStream(name);
    }

    public static PropertiesLoader getInstance(String name) {
        return new PropertiesLoader(name);
    }

    public String getString(String key) {
        return properties.getProperty(key);
    }
}
