package wang.huaichao.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import wang.huaichao.web.dao.TagDao;
import wang.huaichao.web.model.Tag;

import java.util.List;

/**
 * Created by Administrator on 2015/1/6.
 */
@Service
@Transactional
public class TagService {
    @Autowired
    private TagDao tagDao;

    public List<Tag> getUsers() {
        return tagDao.getTags();
    }
}
