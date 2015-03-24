package wang.huaichao.web.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import wang.huaichao.web.model.Article;
import wang.huaichao.web.model.User;
import wang.huaichao.web.service.ArticleService;

import java.util.List;

/**
 * Created by Administrator on 2015/1/17.
 */
@Controller
@RequestMapping("/article")
public class ArticleController {
    @Autowired
    private ArticleService articleService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap map) {
        List<Article> articles = articleService.getArticles(1, 10);
        map.put("articles", articles);
        return "article/index";
    }

    @RequestMapping(value = "/{id}")
    public String show(@PathVariable int id, ModelMap map) {
        Article article = articleService.getArticleById(id);
        map.put("article", article);
        article.getTags();
        return "article/show";
    }

    @RequestMapping(value = "/new")
    public String addNew() {
        return "article/new";
    }

    @ResponseBody
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String save(@RequestParam String title,
                       @RequestParam String tags,
                       @RequestParam String content) {
        SecurityContext context = SecurityContextHolder.getContext();
        Authentication auth = context.getAuthentication();

        if (auth.getPrincipal() instanceof UserDetails) {
            String username = ((UserDetails) auth.getPrincipal()).getUsername();
            articleService.addArticle(title, content, username);
        } else return "{error:true}";

        String[] ids = tags.split(",");
        int[] ints = new int[ids.length];
        for (int i = 0; i < ids.length; i++) {
            ints[i] = Integer.valueOf(ids[i]);
        }

        return "{error:false}";
    }
}
