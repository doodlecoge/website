package wang.huaichao.web.action;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import wang.huaichao.security.UserUtils;
import wang.huaichao.utils.PropertiesLoader;
import wang.huaichao.utils.TextUtils;
import wang.huaichao.utils.TimeUtils;
import wang.huaichao.web.model.Image;
import wang.huaichao.web.service.ImageService;
import wang.huaichao.web.service.UserService;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Calendar;
import java.util.Iterator;
import java.util.Set;

/**
 * Created by Administrator on 2015/4/17.
 */
@Controller
@RequestMapping("/image")
public class ImageController {
    private static final Logger log =
            LoggerFactory.getLogger(ImageController.class);
    private static final PropertiesLoader pl =
            PropertiesLoader.getInstance("sys");
    private static String uploadDir;

    public ImageController() {
        uploadDir = pl.getString("upload_dir");
        if (uploadDir == null || uploadDir.trim().isEmpty()) {
            uploadDir = System.getProperty("web.root.dir") +
                    File.separator + "upload" + File.separator;
        }
    }

    @Autowired
    private UserService userService;
    @Autowired
    private ImageService imageService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap map) {
        Set<Image> images = userService.getImages(UserUtils.getUsername());
        map.put("images", images);

        return "/img/index";
    }

    @RequestMapping("/{id}")
    public void getImage(@PathVariable int id,
                         HttpServletResponse response) {
        Image image = imageService.getImage(id);
        File file = null;
        if (image != null) {
            file = new File(uploadDir +
                    File.separator + image.getDirname() +
                    File.separator + image.getFilename());
        }

        if (file == null || !file.exists()) {
            file = new File(System.getProperty("web.root.dir") +
                    File.separator + "upload" +
                    File.separator + "no-img.png");
        }

        FileInputStream fis = null;
        try {
            fis = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            log.error("file not found: " + file.getAbsolutePath());
            return;
        }

        int len;
        byte[] bytes = new byte[2048];
        try {
            response.setContentType("image/png");
            ServletOutputStream os = response.getOutputStream();
            while ((len = fis.read(bytes)) != -1)
                os.write(bytes, 0, len);
            fis.close();
            os.close();
        } catch (IOException e) {
            log.error("write image failed", e);
        }
    }

    @RequestMapping(value = "/upload", method = RequestMethod.POST,
            produces = "text/html; charset=UTF-8")
    public String upload(@RequestParam MultipartFile img,
                         @RequestParam String imageName) {
        if (img.isEmpty()) {
            return "please select file to upload";
        }


        Calendar now = Calendar.getInstance();
        String ext = img.getOriginalFilename().substring(
                img.getOriginalFilename().lastIndexOf(".")
        );
        String dirName = TimeUtils.getTimeStamp("yyyy-MM-dd");
        String timeStamp = TimeUtils.getTimeStamp("HH.mm.ss.SSS");
        new File(uploadDir + dirName).mkdirs();
        String saveName = timeStamp + TextUtils.makeFileName(imageName) + ext;

        Image image = null;
        try {
            FileUtils.copyInputStreamToFile(img.getInputStream(),
                    new File(uploadDir + dirName + File.separator + saveName)
            );
            image = imageService.addImage(dirName, saveName,
                    now.getTime(), now.getTime(),
                    UserUtils.getUsername());
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/image/" + image.getId() + "/edit";
    }

    @RequestMapping("/{id}/edit")
    public String edit(@PathVariable int id, ModelMap map) {
        Image image = imageService.getImage(id);
        map.put("image", image);
        return "img/edit";
    }

    @RequestMapping(value = "/{id}/cut", method = RequestMethod.POST)
    @ResponseBody
    public String cut(@PathVariable int id,
                      @RequestParam int img_w,
                      @RequestParam int img_h,
                      @RequestParam int cut_w,
                      @RequestParam int cut_h,
                      @RequestParam int cut_x,
                      @RequestParam int cut_y) {
        Image image = imageService.getImage(id);

        String path = uploadDir + image.getDirname() + File.separator;
        File file = new File(path + image.getFilename());

        String subfix = image.getFilename().substring(image.getFilename().lastIndexOf(".") + 1);

        if (!file.exists())
            return "{\"error\":true, \"msg\":\"file not exists\"}";

        try {
            BufferedImage bi = ImageIO.read(file);
            int width = bi.getWidth();
            int height = bi.getHeight();

            cut_x = cut_x * width / img_w;
            cut_y = cut_y * height / img_h;
            cut_w = cut_w * width / img_w;
            cut_h = cut_h * height / img_h;

            bi = bi.getSubimage(cut_x, cut_y, cut_w, cut_h);


            BufferedImage zoomImage = new BufferedImage(100, 100, bi.getType());
            java.awt.Image zimg = bi.getScaledInstance(100, 100, java.awt.Image.SCALE_SMOOTH);
            Graphics gc = zoomImage.getGraphics();
            gc.setColor(Color.WHITE);
            gc.drawImage(zimg, 0, 0, null);

            ImageIO.write(zoomImage, subfix, new File(path +
                    image.getFilename()));
        } catch (IOException e) {
            return "{\"error\":true, \"msg\":\"cut error\"}";
        }

        return "{\"error\": false}";
    }
}
