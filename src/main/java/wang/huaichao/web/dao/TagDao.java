package wang.huaichao.web.dao;

import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.springframework.stereotype.Repository;
import wang.huaichao.web.model.Tag;

import java.util.List;

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
}
