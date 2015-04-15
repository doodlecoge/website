package wang.huaichao.web.action;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/4/14.
 */
@Controller
@RequestMapping("/t")
public class ToolsController {
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "/tools/index";
    }

    @RequestMapping("/reqinfo")
    @ResponseBody
    public String reqinfo(HttpServletRequest request, ModelMap map) {
        Enumeration headerNames = request.getHeaderNames();
        Map<String, String> req = new HashMap<String, String>();
        while (headerNames.hasMoreElements()) {
            Object name = headerNames.nextElement();
            if (name == null) continue;
            req.put(name.toString(), request.getHeader(name.toString()));
        }
        return "tools/reqinfo";
    }
}
