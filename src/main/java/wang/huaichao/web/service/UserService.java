package wang.huaichao.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import wang.huaichao.web.dao.UserDao;
import wang.huaichao.web.model.User;

import java.util.List;

/**
 * Created by Administrator on 2015/1/6.
 */
@Service
@Transactional
public class UserService {
    @Autowired
    private UserDao userDao;

    public User getUser(String username) {
        return userDao.getUser(username);
    }

    public List<User> getUsers() {
        return userDao.getUsers();
    }
}
