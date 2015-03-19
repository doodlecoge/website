package wang.huaichao.web.action;

import com.google.gson.JsonObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created by Administrator on 2015/2/13.
 */
@Controller
@RequestMapping("/delay")
public class DelayController {
    public static final DateFormat df =
            new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");

    @RequestMapping("/{ms}")
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
}
