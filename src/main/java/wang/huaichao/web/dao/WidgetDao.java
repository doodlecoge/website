package wang.huaichao.web.dao;

import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import wang.huaichao.web.model.User;
import wang.huaichao.web.model.Widget;

import java.util.Calendar;
import java.util.List;

/**
 * Created by Administrator on 2015/4/21.
 */
@Repository
public class WidgetDao extends TheDao {
    public List<Widget> listAll() {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Widget.class)
                .addOrder(Order.desc("updatedAt"));
        return criteria.list();
    }

    public Widget get(int id) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Widget.class)
                .add(Restrictions.eq("id", id));
        Object o = criteria.uniqueResult();
        return o == null ? null : (Widget) o;
    }

    public Widget getLatest() {
        Session session = sessionFactory.getCurrentSession();
        return (Widget) session.createSQLQuery(
                "select * from widgets order by id desc limit 1"
        ).addEntity(Widget.class).uniqueResult();
    }

    public void delete(int id) {
        // todo: check if id exists
        Widget widget = new Widget();
        widget.setId(id);
        Session session = sessionFactory.getCurrentSession();
        session.delete(widget);
    }

    public void add(String title, String html, String js, String css, String username) {
        Calendar now = Calendar.getInstance();

        Widget widget = new Widget();
        widget.setTitle(title);
        widget.setHtml(html);
        widget.setJs(js);
        widget.setCss(css);
        widget.setCreatedAt(now.getTime());
        widget.setUpdatedAt(now.getTime());
        User user = new User();
        user.setUsername(username);
        widget.setUser(user);
        Session session = sessionFactory.getCurrentSession();
        session.save(widget);
    }

    public void update(int id, String title, String html, String js, String css) {
        Widget widget = get(id);
        if (widget == null) return;
        widget.setTitle(title);
        widget.setCss(css);
        widget.setJs(js);
        widget.setHtml(html);
        widget.setUpdatedAt(Calendar.getInstance().getTime());
        Session session = sessionFactory.getCurrentSession();
        session.update(widget);
    }
}
