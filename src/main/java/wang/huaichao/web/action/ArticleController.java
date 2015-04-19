package wang.huaichao.web.action;

import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import wang.huaichao.security.UserUtils;
import wang.huaichao.web.model.Article;
import wang.huaichao.web.model.Tag;
import wang.huaichao.web.model.User;
import wang.huaichao.web.service.ArticleService;
import wang.huaichao.web.service.TagService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/1/17.
 */
@Controller
@RequestMapping("/article")
public class ArticleController {
    @Autowired
    private ArticleService articleService;
    @Autowired
    private TagService tagService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap map) {
        List<Article> articles = articleService.getArticles(1, 10);
        map.put("articles", articles);
        map.put("username", UserUtils.getUsername());
        return "article/index";
    }

    // show articles by tag
    @RequestMapping("/{id}/tag")
    public String showArticlesByTag(@PathVariable int id, ModelMap map) {
        List<Article> articles = articleService.getArticlesByTag(id);
        map.put("articles", articles);
        map.put("username", UserUtils.getUsername());
        return "article/index";
    }

    @RequestMapping(value = "/{id}")
    public String show(@PathVariable int id, ModelMap map) {
        Article article = articleService.getArticleById(id);
        map.put("article", article);
        map.put("username", UserUtils.getUsername());

        return "article/show";
    }

    @RequestMapping(value = "/new")
    public String addNew() {
        return "article/new";
    }

    @RequestMapping(value = "/{id}/edit")
    public String edit(@PathVariable int id, ModelMap map) {
        Article article = articleService.getArticleById(id);
        map.put("article", article);
        return "article/new";
    }

    @ResponseBody
    @RequestMapping(value = "/{id}/save", method = RequestMethod.POST)
    public String save(@PathVariable int id,
                       @RequestParam int iid,
                       @RequestParam String title,
                       @RequestParam String tags,
                       @RequestParam String content) {
        SecurityContext context = SecurityContextHolder.getContext();
        Authentication auth = context.getAuthentication();

        String[] ids = tags.split(",");
        List<Integer> tids = new ArrayList<Integer>();
        for (int i = 0; i < ids.length; i++) {
            try {
                tids.add(Integer.valueOf(ids[i]));
            } catch (NumberFormatException e) {
            }
        }

        JsonObject jobj = new JsonObject();

        if (auth.getPrincipal() instanceof UserDetails) {
            String username = ((UserDetails) auth.getPrincipal()).getUsername();
            Article a;
            if (id == 0)
                a = articleService.addArticle(
                        iid, title, content, username, tids
                );
            else
                a = articleService.updateArticle(
                        id, iid,title, content, username, tids
                );
            jobj.addProperty("error", false);
            jobj.addProperty("aid", a.getId());
        } else jobj.addProperty("error", true);
        return jobj.toString();
    }
}
