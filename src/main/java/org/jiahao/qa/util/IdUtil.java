package org.jiahao.qa.util;

import java.util.UUID;

/**
 * UUID工具类
 * Created by Alvin on 2016/10/30.
 */
public class IdUtil {

    /**
     * 获取UUID
     * @return
     */
    public static String getUUID() {
        String uuid = UUID.randomUUID().toString();
        //System.out.println(uuid);
        return uuid.replaceAll("-", "");
    }

    public static void main(String[] args) {
        System.out.println(getUUID());
    }
}
