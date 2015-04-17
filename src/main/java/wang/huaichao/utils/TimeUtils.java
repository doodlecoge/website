package wang.huaichao.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created by Administrator on 2015/4/17.
 */
public class TimeUtils {

    public static String getTimeStamp() {
        return getTimeStamp("yyyyMMddHHmmss.SSS");
    }

    public static String getTimeStamp(String fmt) {
        return new SimpleDateFormat(fmt).format(
                Calendar.getInstance().getTime()
        );
    }

    public static void main(String[] args) {
        System.out.println(getTimeStamp());
    }
}
