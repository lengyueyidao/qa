package org.jiahao.qa.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 日期工具类
 * Created by Alvin on 2016/10/1.
 */
public class DateUtil {

    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /**
     * Date转字符串
     * @param date
     * @return
     */
    public static String format(Date date) {

        String formatDate = null;
        formatDate = sdf.format(date.getTime());
        return formatDate;
    }

    /**
     * 获取当前时间Date
     * @return
     */
    public static Date getNowTime() {
        String datetime = sdf.format(new Date().getTime());
        Date nowtime = null;
        try {
            nowtime = sdf.parse(datetime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return nowtime;
    }
}
