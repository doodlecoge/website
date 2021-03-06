package wang.huaichao.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import wang.huaichao.web.dao.ArticleDao;
import wang.huaichao.web.dao.TagDao;
import wang.huaichao.web.model.Article;
import wang.huaichao.web.model.Tag;
import wang.huaichao.web.model.User;

import java.util.List;

/**
 * Created by Administrator on 2015/1/6.
 */
@Service
@Transactional
public class ArticleService {
    @Autowired
    private ArticleDao articleDao;
    @Autowired
    private TagDao tagDao;

    public Article getArticleById(int id) {
        return articleDao.getArticleById(id);
    }

    public List<Article> getArticlesByUser(String username) {
        return articleDao.getArticlesByUser(username);
    }

    public List<Article> getArticlesByTag(int id) {
        return articleDao.getArticlesByTag(id);
    }


    public List<Article> getArticles(int pageNum, int pageSize) {
        return articleDao.getArticles(pageNum, pageSize);
    }

    public Article addArticle(int iid, String title, String content, String username, List<Integer> tids) {
        List<Tag> tags = tagDao.getTags(tids);
        return articleDao.addArticle(iid, title, content, username, tags);
    }

    public Article updateArticle(int id, int iid, String title, String content, String username, List<Integer> tids) {
        List<Tag> tags = tagDao.getTags(tids);
        return articleDao.updateArticle(id, iid, title, content, username, tags);
    }

    public void delete(int id) {
        articleDao.delete(id);
    }
}
