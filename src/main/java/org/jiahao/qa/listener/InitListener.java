package org.jiahao.qa.listener;

import org.jiahao.qa.pojo.Question;
import org.jiahao.qa.service.QuestionService;
import org.jiahao.qa.util.SearchUtil;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.annotation.Resource;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;

/**
 * 监听器
 * Created by Alvin on 2016/12/7.
 */
public class InitListener implements ServletContextListener {


    public void contextInitialized(ServletContextEvent servletContextEvent) {
        /*QuestionService questionService = WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext()).getBean(QuestionService.class);
        List<Question> questionList = questionService.getQuestions();
        SearchUtil.createIndexFile(questionList);*/
    }

    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
