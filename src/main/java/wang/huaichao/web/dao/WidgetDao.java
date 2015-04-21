package wang.huaichao.web.dao;

import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.springframework.stereotype.Repository;
import wang.huaichao.web.model.User;
import wang.huaichao.web.model.Widget;

/**
 * Created by Administrator on 2015/4/21.
 */
@Repository
public class WidgetDao extends TheDao {
    public Widget get(int id) {
        Session session = sessionFactory.getCurrentSession();
        Criteria widget = session.createCriteria(Widget.class);
        Object o = widget.uniqueResult();
        return o == null ? null : (Widget) o;
    }

    public void delete(int id) {
        // todo: check if id exists
        Widget widget = new Widget();
        widget.setId(id);
        Session session = sessionFactory.getCurrentSession();
        session.delete(widget);
    }

    public void add(String html, String js, String css, String username) {
        Widget widget = new Widget();
        widget.setHtml(html);
        widget.setJs(js);
        widget.setCss(css);
        User user = new User();
        user.setUsername(username);
        widget.setUser(user);
        Session session = sessionFactory.getCurrentSession();
        session.save(widget);
    }

    public void update(int id, String html, String js, String css) {
        Widget widget = get(id);
        if (widget == null) return;
        widget.setCss(css);
        widget.setJs(js);
        widget.setHtml(html);
        Session session = sessionFactory.getCurrentSession();
        session.update(widget);
    }
}
