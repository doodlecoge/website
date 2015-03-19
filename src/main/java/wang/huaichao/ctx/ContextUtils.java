package wang.huaichao.ctx;

import org.springframework.web.context.WebApplicationContext;

/**
 * Created by hch on 2014/8/12.
 */
public class ContextUtils {
    private static WebApplicationContext CTX;

    private ContextUtils() {
    }

    public static WebApplicationContext getContext() {
        return CTX;
    }

    public static void setContext(WebApplicationContext context) {
        CTX = context;
    }
}
