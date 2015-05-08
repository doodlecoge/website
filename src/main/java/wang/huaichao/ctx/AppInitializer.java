package wang.huaichao.ctx;

import wang.huaichao.utils.PropertiesLoader;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;

/**
 * Created by hch on 2015/5/8.
 */
public class AppInitializer implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        PropertiesLoader pl = PropertiesLoader.getInstance("sys");
        String uploadDir = pl.getString("upload_dir");
        if (uploadDir == null || uploadDir.trim().isEmpty()) {
            uploadDir = System.getProperty("web.root.dir") +
                    File.separator + "upload" + File.separator;
        }
        Config.UPLOAD_DIR = uploadDir;
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
