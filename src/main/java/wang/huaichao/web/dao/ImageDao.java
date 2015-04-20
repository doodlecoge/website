package wang.huaichao.web.dao;

import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import wang.huaichao.web.model.Image;

import java.util.Date;

/**
 * Created by Administrator on 2015/4/17.
 */
@Repository
public class ImageDao extends TheDao {
    public Image getImage(int id) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Image.class);
        criteria.add(Restrictions.eq("id", id));
        Object o = criteria.uniqueResult();
        if (o == null) return null;
        else return (Image) o;
    }

    public Image addImage(String dirname, String filename,
                          Date createdAt, Date updatedAt, String username) {
        Image image = new Image();
        image.setFilename(filename);
        image.setDirname(dirname);
        image.setCreatedAt(createdAt);
        image.setUpdatedAt(updatedAt);
        image.setUsername(username);

        Session session = sessionFactory.getCurrentSession();
        session.save(image);
        return image;
    }

    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();
        Image image = new Image();
        image.setId(id);
        session.delete(image);
    }
}
