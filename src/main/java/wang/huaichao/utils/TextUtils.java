package wang.huaichao.utils;

/**
 * Created by Administrator on 2015/4/17.
 */
public class TextUtils {
    public static String makeFileName(String str) {
        return str.replaceAll("[\\/?*|:<>\"]","");
    }
}
