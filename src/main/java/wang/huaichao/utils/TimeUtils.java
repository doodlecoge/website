package wang.huaichao.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

/**
 * Created by Administrator on 2015/4/17.
 */
public class TimeUtils {
    public static final int YEAR_MS = 365 * 24 * 60 * 60 * 1000;

    public static String format(Date date, String fmt) {
        return format(date, fmt, "GMT", Locale.ENGLISH);
    }

    public static String format(Date date, String fmt,
                                String timeZone, Locale locale) {
        DateFormat df = new SimpleDateFormat(fmt, locale);
        df.setTimeZone(TimeZone.getTimeZone(timeZone));
        return df.format(date);
    }

    public static String getTimeStamp() {
        return getTimeStamp("yyyyMMddHHmmss.SSS");
    }

    public static String getTimeStamp(String fmt) {
        return getTimeStamp(fmt, "GMT", Locale.ENGLISH);
    }

    public static String getTimeStamp(String fmt, String timeZone, Locale locale) {
        DateFormat df = new SimpleDateFormat(fmt, locale);
        df.setTimeZone(TimeZone.getTimeZone(timeZone));
        return df.format(new Date());
    }

    public static void main(String[] args) {
        Date date = new Date();
        System.out.println(getTimeStamp("EEE, dd MMM yyyy HH:mm:ss z"));
        System.out.println(getTimeStamp("EEE, dd MMM yyyy HH:mm:ss zzz"));
        System.out.println(format(date, "EEE, dd MMM yyyy HH:mm:ss z"));
    }
}
