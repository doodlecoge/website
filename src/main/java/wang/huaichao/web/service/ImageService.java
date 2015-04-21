package wang.huaichao.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import wang.huaichao.web.dao.ImageDao;
import wang.huaichao.web.model.Image;

import java.util.Date;

/**
 * Created by Administrator on 2015/4/17.
 */
@Service
@Transactional
public class ImageService {
    @Autowired
    private ImageDao imageDao;

    public Image getImage(int id) {
        return imageDao.getImage(id);
    }

    public Image addImage(String dirname, String filename,
                          Date createdAt, Date updatedAt,
                          String username) {
        return imageDao.addImage(
                dirname, filename, createdAt, updatedAt, username);
    }

    public void delete(int id) {
        imageDao.delete(id);
    }

    public void update(Image image) {
        imageDao.update(image);
    }
}
