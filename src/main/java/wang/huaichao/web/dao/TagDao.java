package wang.huaichao.web.dao;

import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import wang.huaichao.web.model.ArticleTag;
import wang.huaichao.web.model.Tag;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Created by Administrator on 2015/1/6.
 */
@Repository
public class TagDao extends TheDao {
    public List<Tag> getTags() {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Tag.class);
        return criteria.list();
    }

    public List<Tag> getTags(List<Integer> tids) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Tag.class)
                .add(Restrictions.in("id", tids));
        return criteria.list();
    }

    public List<Tag> getTagsByArticleId(int aid) {
        Session session = sessionFactory.getCurrentSession();
        String sql = "SELECT aid, tid from articles_tags WHERE aid=" + aid;
        List<ArticleTag> ats = session.createSQLQuery(sql).addEntity(ArticleTag.class).list();
        if (ats == null || ats.size() == 0) return null;
        Object[] tids = new Object[ats.size()];
        for (int i = 0; i < ats.size(); i++) {
            tids[i] = ats.get(i).getTid();
        }
        return session.createCriteria(Tag.class).add(Restrictions.in("id", tids)).list();
    }
}
