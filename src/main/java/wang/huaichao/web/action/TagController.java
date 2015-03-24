package wang.huaichao.web.action;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import wang.huaichao.web.model.Tag;
import wang.huaichao.web.model.User;
import wang.huaichao.web.service.TagService;
import wang.huaichao.web.service.UserService;

import java.util.List;

/**
 * Created by Administrator on 2015/1/5.
 */
@Controller
@RequestMapping("/tag")
public class TagController {
    @Autowired
    private TagService tagService;

    @ResponseBody
    @RequestMapping("/json")
    public String tags() {
        List<Tag> tags = tagService.getUsers();
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

