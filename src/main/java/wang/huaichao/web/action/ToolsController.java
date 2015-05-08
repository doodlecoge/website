package wang.huaichao.web.action;

import com.google.gson.JsonObject;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/4/14.
 */
@Controller
@RequestMapping("/t")
public class ToolsController {
    public static final DateFormat df =
            new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");

    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "/tools/index";
    }

    @RequestMapping("/reqinfo")
    public String reqinfo(HttpServletRequest request, ModelMap map) {
        Enumeration headerNames = request.getHeaderNames();
        Map<String, String> req = new HashMap<String, String>();
        while (headerNames.hasMoreElements()) {
            Object name = headerNames.nextElement();
            if (name == null) continue;
            req.put(name.toString(), request.getHeader(name.toString()));
        }
        map.put("reqinfo", req);
        return "tools/reqinfo";
    }

    @RequestMapping("/runjs")
    public String runjs() {
        return "tools/runjs";
    }


    @RequestMapping("/delay/{ms}")
    @ResponseBody
    public String delay(@PathVariable int ms) {
        Calendar from = Calendar.getInstance();
        try {
            Thread.sleep(ms);
        } catch (InterruptedException e) {
        }
        Calendar to = Calendar.getInstance();
        JsonObject jobj = new JsonObject();
        jobj.addProperty("from", df.format(from.getTime()));
        jobj.addProperty("to", df.format(to.getTime()));
        return jobj.toString();
    }

    @RequestMapping("/exception")
    public String exception() {
        throw new RuntimeException("hello exception");
    }
}
