package wang.huaichao.web.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import wang.huaichao.security.UserUtils;
import wang.huaichao.web.model.Widget;
import wang.huaichao.web.service.WidgetService;

/**
 * Created by Administrator on 2015/4/21.
 */
@Controller
@RequestMapping("/widget")
public class WidgetController {
    @Autowired
    private WidgetService widgetService;

    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "widget/new";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public String save(@RequestParam int id,
                       @RequestParam String html,
                       @RequestParam String js,
                       @RequestParam String css) {
        // todo: check if current user have privileges to add/update this widget
        if (id == 0)
            widgetService.add(html, js, css, UserUtils.getUsername());
        else
            widgetService.update(id, html, js, css);

        return "{\"error\":false}";
    }

    @RequestMapping("/{id}")
    public String show(@PathVariable int id, ModelMap map) {
        Widget widget = widgetService.get(id);
        map.put("widget", widget);
        return "widget/new";
    }
}
