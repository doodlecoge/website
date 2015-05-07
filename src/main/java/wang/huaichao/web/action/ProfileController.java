package wang.huaichao.web.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import wang.huaichao.security.UserUtils;
import wang.huaichao.web.model.User;
import wang.huaichao.web.service.UserService;

import java.util.List;

/**
 * Created by Administrator on 2015/5/6.
 */
@Controller
@RequestMapping("/profile")
public class ProfileController {
    @Autowired
    private UserService userService;


    @RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap map) {
        final User user = userService.getUser(UserUtils.getUsername());
        map.put("user", user);
        return "user/profile";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(@RequestParam String username,
                         @RequestParam String opassword,
                         @RequestParam String npassword,
                         @RequestParam String npassword2) {
        final User user = userService.getUser(username);
        if (!user.getPassword().equals(opassword)) {
            throw new RuntimeException("incorrect old password");
        }
        if (!npassword.equals(npassword2)) {
            throw new RuntimeException("two new passwords not equal");
        }
        user.setPassword(npassword);
        userService.update(user);
        return "redirect:/profile";
    }
}
