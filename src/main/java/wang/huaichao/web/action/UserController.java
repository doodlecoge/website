package wang.huaichao.web.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import wang.huaichao.web.model.User;
import wang.huaichao.web.service.UserService;

import java.util.List;

/**
 * Created by Administrator on 2015/5/6.
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;


    @RequestMapping(method = RequestMethod.GET)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String index(ModelMap map) {
        final List<User> users = userService.getUsers();
        map.put("users", users);
        return "user/index";
    }

    @RequestMapping("/{username}/edit")
    public String edit(@PathVariable String username, ModelMap map) {
        final User user = userService.getUser(username);
        map.put("user", user);
        return "user/info";
    }

    @RequestMapping("/{username}/del")
    public String delete(@PathVariable String username, ModelMap map) {
        userService.delete(username);
        return "redirect:/user";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(@RequestParam String username,
                      @RequestParam String password,
                      @RequestParam String fullname) {
        final User user = new User();
        user.setFullname(fullname);
        user.setPassword(password);
        user.setUsername(username);
        userService.add(user);
        return "redirect:/user/" + user.getUsername();
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(@RequestParam String username,
                         @RequestParam String fullname,
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
        user.setFullname(fullname);
        user.setPassword(npassword);
        user.setUsername(username);
        userService.update(user);
        return "redirect:/user/" + username;
    }

    @RequestMapping(value = "/{username}", method = RequestMethod.GET)
    public String info(@PathVariable String username, ModelMap map) {
        final User user = userService.getUser(username);
        map.put("user", user);
        return "user/info";
    }
}
