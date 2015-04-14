package wang.huaichao.web.action.helper;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;

/**
 * Created by Administrator on 2015/4/14.
 */
@Controller
@RequestMapping("/helper")
public class RequestController {
    @RequestMapping("/reqinfo")
    @ResponseBody
    public String reqinfo(HttpServletRequest request) {
        StringBuilder sb = new StringBuilder();
        Enumeration headerNames = request.getHeaderNames();
        sb.append("<table>");
        while (headerNames.hasMoreElements()) {
            Object name = headerNames.nextElement();
            if (name == null) continue;
            sb.append("<tr>").append("<td>").append(name).append("</td><td>")
                    .append(name).append("=").append("</td><td>")
                    .append(request.getHeader(name.toString()))
                    .append("</td></tr>").append("<br/>");
        }
        sb.append("</table>");
        return sb.toString();
    }
}
