package wang.huaichao.web.dao;

import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import wang.huaichao.web.model.Article;
import wang.huaichao.web.model.Tag;
import wang.huaichao.web.model.User;

import java.util.Calendar;
import java.util.List;

/**
 * Created by Administrator on 2015/1/19.
 */
@Repository
public class ArticleDao extends TheDao {
    public Article getArticleById(int id) {
        Session session = sessionFactory.getCurrentSession();
        return (Article) session.get(Article.class, id);
    }

    public List<Article> getArticlesByUser(String username) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Article.class);
        criteria.add(Restrictions.eq("username", username));
        return criteria.list();
    }

    public List<Article> getArticles(int pageNum, int pageSize) {
//        int idx = Math.max(0, pageNum * pageSize - pageSize);
//        int len = Math.max(10, pageSize);
//
//        Session session = sessionFactory.getCurrentSession();
//        Criteria criteria = session.createCriteria(Article.class);
////        criteria.setFirstResult(idx);
////        criteria.setMaxResults(len);
//
//        return criteria.list();


        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Article.class)
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        return criteria.list();
    }

    public Article addArticle(String title, String content, String username, List<Tag> tags) {
        Session session = sessionFactory.getCurrentSession();
        Calendar now = Calendar.getInstance();
        Article article = new Article();

        article.setUsername(username);
        article.setTitle(title);
        article.setContent(content);
        article.setCreatedAt(now.getTime());
        article.setUpdatedAt(now.getTime());
        article.getTags().addAll(tags);

        session.save(article);
        return article;
    }

    public Article updateArticle(int id, String title, String content, String username, List<Tag> tags) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Article.class);
        criteria.add(Restrictions.eq("id", id));
        Calendar now = Calendar.getInstance();
        Article article = (Article) criteria.uniqueResult();
        if (!article.getUsername().equals(username))
            throw new RuntimeException("no privilege to update article " + id);
        article.setTitle(title);
        article.setContent(content);
        article.setUpdatedAt(now.getTime());
        article.getTags().clear();
        article.getTags().addAll(tags);
        session.update(article);
        return article;
    }

}
