package org.jiahao.qa.service;

import org.jiahao.qa.pojo.View;

/**
 * Created by Alvin on 2016/11/19.
 */
public interface ViewService {

    View getTodayView(String userid, String questionid);

    int addTodayView(String userid, String questionid);

}
