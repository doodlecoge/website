package wang.huaichao.web.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/1/6.
 */
@Repository
public abstract class TheDao {
    @Autowired
    @Qualifier(value = "h2Sf")
    protected SessionFactory sessionFactory;
}
