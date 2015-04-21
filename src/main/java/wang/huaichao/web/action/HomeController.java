package wang.huaichao.web.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import wang.huaichao.web.model.User;
import wang.huaichao.web.model.Widget;
import wang.huaichao.web.service.UserService;
import wang.huaichao.web.service.WidgetService;

import java.util.List;

/**
 * Created by Administrator on 2015/1/5.
 */
@Controller
@RequestMapping("/")
public class HomeController {
    @Autowired
    private UserService userService;

    @Autowired
    private WidgetService widgetService;

    @RequestMapping("/")
    public String home(ModelMap map) {
        Widget latest = widgetService.getLatest();
        map.put("widget", latest);
        return "home";
    }

    @RequestMapping("/login_page")
    public String loginPage() {
        return "login_page";
    }
}

