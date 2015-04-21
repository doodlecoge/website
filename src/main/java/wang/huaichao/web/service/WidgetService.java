package wang.huaichao.web.service;

import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import wang.huaichao.web.dao.ImageDao;
import wang.huaichao.web.dao.WidgetDao;
import wang.huaichao.web.model.Image;
import wang.huaichao.web.model.User;
import wang.huaichao.web.model.Widget;

import java.util.Date;

/**
 * Created by Administrator on 2015/4/17.
 */
@Service
@Transactional
public class WidgetService {
    @Autowired
    private WidgetDao widgetDao;

    public Widget get(int id) {
        return widgetDao.get(id);
    }

    public Widget getLatest() {
        return widgetDao.getLatest();
    }

    public void delete(int id) {
        widgetDao.delete(id);
    }

    public void add(String html, String js, String css, String username) {
        widgetDao.add(html, js, css, username);
    }

    public void update(int id, String html, String js, String css) {
        widgetDao.update(id, html, js, css);
    }
}
