package org.jiahao.qa.util;

/**
 * 分页工具类
 * Created by Alvin on 2016/12/8.
 */
public class PageUtil {

    /**
     * 创建分页
     * @param page 分页对象
     * @param pageNow 当前页
     * @param totalCount 总数
     */
    public static void createPage(Page page, String pageNow, int totalCount) {

        if(pageNow != null) {
            int pn = 1;
            try {
                pn = Integer.parseInt(pageNow);
            } catch (Exception e) {
                pn = 1;
            }
            if(pn <= 0) {
                pn = 1;
            }
            page.setTotalCount(totalCount);
            page.setPageNow(pn);
            //page = new Page(totalCount, pn);
        } else {
            page.setTotalCount(totalCount);
            page.setPageNow(1);
            //page = new Page(totalCount, 1);
        }
    }

}
