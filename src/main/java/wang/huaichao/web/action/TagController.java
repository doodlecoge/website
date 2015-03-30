package wang.huaichao.web.action;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import wang.huaichao.web.model.Tag;
import wang.huaichao.web.service.TagService;

import java.util.List;

/**
 * Created by Administrator on 2015/1/5.
 */
@Controller
@RequestMapping("/tag")
public class TagController {
    @Autowired
    private TagService tagService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap map) {
        List<Tag> tags = tagService.getTags();
        map.put("tags", tags);
        return "tag/index";
    }

    @RequestMapping("/{id}/del")
    public String del(@PathVariable int id) {
        tagService.deleteTag(id);
        return "redirect:/tag";
    }

    @RequestMapping("/add")
    public String add(@RequestParam String name) {
        tagService.addTag(name.trim());
        return "redirect:/tag";
    }

    @ResponseBody
    @RequestMapping("/json")
    public String tags() {
        List<Tag> tags = tagService.getTags();
        JsonArray jarr = new JsonArray();
        JsonObject jobj;
        for (Tag tag : tags) {
            jobj = new JsonObject();
            jobj.addProperty("id", tag.getId());
            jobj.addProperty("text", tag.getName());
            jarr.add(jobj);
        }
        return jarr.toString();
    }
}

