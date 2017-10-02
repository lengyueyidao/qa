package org.jiahao.qa.service.impl;

import org.jiahao.qa.dao.ViewMapper;
import org.jiahao.qa.pojo.View;
import org.jiahao.qa.service.ViewService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Alvin on 2016/11/19.
 */
@Service("viewService")
public class ViewServiceImpl implements ViewService {

    @Resource
    private ViewMapper viewMapper;

    public View getTodayView(String userid, String questionid) {
        return viewMapper.selectTodayView(userid, questionid);
    }

    public int addTodayView(String userid, String questionid) {
        return viewMapper.insertView(userid, questionid);
    }
}
