package wang.huaichao.web.action;

import com.google.gson.JsonObject;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import wang.huaichao.security.UserUtils;
import wang.huaichao.web.model.Widget;
import wang.huaichao.web.service.WidgetService;

import java.util.List;

/**
 * Created by Administrator on 2015/4/21.
 */
@Controller
@RequestMapping("/widget")
public class WidgetController {
    @Autowired
    private WidgetService widgetService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap map) {
        List<Widget> widgets = widgetService.listAll();
        map.put("widgets", widgets);
        return "widget/index";
    }

    @RequestMapping("/new")
    public String addNew() {
        return "widget/new";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public String save(@RequestParam int id,
                       @RequestParam String title,
                       @RequestParam String html,
                       @RequestParam String js,
                       @RequestParam String css) {
        // todo: check if current user have privileges to add/update this widget
        if (id == 0)
            widgetService.add(title, html, js, css, UserUtils.getUsername());
        else
            widgetService.update(id, title, html, js, css);

        return "{\"error\":false}";
    }

    @RequestMapping("/{id}")
    public String show(@PathVariable int id, ModelMap map) {
        Widget widget = widgetService.get(id);
        widget.setHtml(StringEscapeUtils.escapeHtml4(widget.getHtml()));
        map.put("widget", widget);
        return "widget/new";
    }

    @RequestMapping("/{id}/del")
    @ResponseBody
    public String del(@PathVariable int id) {
        widgetService.delete(id);
        return "{\"error\":false}";
    }

    @RequestMapping("/{id}/json")
    @ResponseBody
    public String json(@PathVariable int id) {
        Widget widget = widgetService.get(id);
        JsonObject jobj = new JsonObject();
        jobj.addProperty("html", widget.getHtml());
        jobj.addProperty("css", widget.getCss());
        jobj.addProperty("js", widget.getJs());
        return jobj.toString();
    }
}
