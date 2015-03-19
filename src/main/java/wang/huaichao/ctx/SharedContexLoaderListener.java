package wang.huaichao.ctx;

import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

/**
 * Created by hch on 2014/8/7.
 */
public class SharedContexLoaderListener extends ContextLoaderListener {
    @Override
    public void contextInitialized(ServletContextEvent event) {
        super.contextInitialized(event);

        ServletContext sctx = event.getServletContext();
        WebApplicationContext wac =
                WebApplicationContextUtils.getRequiredWebApplicationContext(sctx);
        ContextUtils.setContext(wac);
    }
}
