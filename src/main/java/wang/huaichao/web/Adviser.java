package wang.huaichao.web;

import com.google.gson.JsonObject;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import wang.huaichao.security.UserUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2015/5/8.
 */
@ControllerAdvice
public class Adviser {
    @ModelAttribute
    public void addAttr(ModelMap map, HttpServletRequest request) {
        map.put("username", UserUtils.getUsername());
        map.put("cp", request.getContextPath());
    }

    @ExceptionHandler({Exception.class})
    public ModelAndView globalErrorHandler(
            HttpServletRequest request, HttpServletResponse response,
            Exception ex) {
        if (isAjax(request)) {
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("error", true);
            jsonObject.addProperty("message", ex.getMessage());
            try {
                response.getWriter().write(
                        jsonObject.toString()
                );
                response.getWriter().close();
                return null;
            } catch (IOException e) {
                return null;
            }
        } else {
            ModelAndView mav = new ModelAndView();
            mav.addObject("message", ex.getMessage());
            mav.addObject("url", request.getRequestURL());
            mav.setViewName("error");
            return mav;
        }
    }

    public static boolean isAjax(HttpServletRequest request) {
        return "XMLHttpRequest"
                .equals(request.getHeader("X-Requested-With"));
    }
}
