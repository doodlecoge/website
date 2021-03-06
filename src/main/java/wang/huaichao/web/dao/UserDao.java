package wang.huaichao.web.dao;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import wang.huaichao.web.model.Image;
import wang.huaichao.web.model.User;

import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2015/1/6.
 */
@Repository
public class UserDao extends TheDao {
    public User getUser(String username) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(User.class);
        criteria.add(Restrictions.eq("username", username));
        return (User) criteria.uniqueResult();
    }

    public void delete(String username) {
        Session session = sessionFactory.getCurrentSession();
        final User user = new User();
        user.setUsername(username);
        session.delete(user);
    }

    public void add(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.save(user);
    }

    public void update(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.update(user);
    }

    @SuppressWarnings("unchecked")
    public List<User> getUsers() {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(User.class);
        return criteria.list();
    }

    public List<Image> getImages(String username) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(User.class)
                .add(Restrictions.eq("username", username));
        User user = (User) criteria.uniqueResult();
        Hibernate.initialize(user.getImages());
        return user.getImages();
    }
}
