package wang.huaichao.web;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import wang.huaichao.security.UserUtils;

/**
 * Created by Administrator on 2015/5/8.
 */
@ControllerAdvice
public class Adviser {
    @ModelAttribute(value = "username")
    public String getUsername() {
        return UserUtils.getUsername();
    }

    @ExceptionHandler(Exception.class)
    public String globalErrorHandler() {
        return "error";
    }
}
