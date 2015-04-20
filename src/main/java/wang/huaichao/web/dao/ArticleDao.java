package wang.huaichao.web.dao;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.stereotype.Repository;
import wang.huaichao.web.model.Article;
import wang.huaichao.web.model.Image;
import wang.huaichao.web.model.Tag;
import wang.huaichao.web.model.User;

import java.util.ArrayList;
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
        criteria.add(Restrictions.eq("username", username))
        .addOrder(Order.desc("updatedAt"));
        return criteria.list();
    }

    public List<Article> getArticlesByTag(int id) {
        Session session = sessionFactory.getCurrentSession();

        List rows = session.createSQLQuery("" +
                " select aid" +
                " from website.articles_tags at" +
                " where at.tid=:id")
                .addScalar("aid", StandardBasicTypes.INTEGER)
                .setParameter("id", id)
                .list();
        if (rows.size() == 0) return null;
        List<Integer> aids = new ArrayList<Integer>();
        for (Object row : rows) {
            aids.add(Integer.valueOf(row.toString()));
        }

        return session.createCriteria(Article.class)
                .add(Restrictions.in("id", aids))
                .addOrder(Order.desc("updatedAt"))
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
                .list();
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
                .addOrder(Order.desc("updatedAt"))
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        return criteria.list();
    }

    public Article addArticle(int iid, String title, String content, String username, List<Tag> tags) {
        Session session = sessionFactory.getCurrentSession();
        Calendar now = Calendar.getInstance();
        Article article = new Article();

        // todo: check if username exists
        User user = new User();
        user.setUsername(username);


        article.setUser(user);
        article.setTitle(title);
        article.setContent(content);
        article.setCreatedAt(now.getTime());
        article.setUpdatedAt(now.getTime());
        if (tags != null)
            article.getTags().addAll(tags);

        if (iid != 0) {
            // todo: check if iid exists
            Image img = new Image();
            img.setId(iid);
            article.setImage(img);
        }

        session.save(article);
        return article;
    }

    public Article updateArticle(int id, int iid, String title, String content,
                                 String username, List<Tag> tags) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Article.class);
        criteria.add(Restrictions.eq("id", id));
        Calendar now = Calendar.getInstance();
        Article article = (Article) criteria.uniqueResult();
        if (!article.getUser().getUsername().equals(username))
            throw new RuntimeException("no privilege to update article " + id);
        article.setTitle(title);
        article.setContent(content);
        article.setUpdatedAt(now.getTime());
        article.getTags().clear();
        if (tags != null)
            article.getTags().addAll(tags);
        if (iid != 0) {
            // todo: check if iid exists
            Image img = new Image();
            img.setId(iid);
            article.setImage(img);
        }
        session.update(article);
        return article;
    }

    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();
        session.delete(id);
    }

}
