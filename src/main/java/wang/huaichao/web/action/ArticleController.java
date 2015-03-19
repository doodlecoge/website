package wang.huaichao.web.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import wang.huaichao.web.model.Article;
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

    @RequestMapping(value = "/new")
    public String addNew() {
        return "article/new";
    }
}
