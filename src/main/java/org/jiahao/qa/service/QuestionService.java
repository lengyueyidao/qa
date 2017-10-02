package org.jiahao.qa.service;

import org.jiahao.qa.pojo.Question;
import org.jiahao.qa.util.Page;

import java.util.List;

/**
 * Created by Alvin on 2016/10/4.
 */
public interface QuestionService {

    /**
     * 查询问题列表
     * @param isover 结束标志
     * @param page 分页
     * @param pageNow 当前页
     * @return
     */
    List<Question> getQuestionList(Integer isover, Page page, String pageNow, List<String> qList, String q);

    /**
     * 根据id查询问题
     * @param id
     * @return
     */
    Question getQuestion(String id);

    /**
     * 结束问题
     * @param id 问题id
     * @param isover 结束标志
     * @return
     */
    int overQuestion(String id, Integer isover);

    /**
     * 根据tagid查询问题列表
     * @param tagid
     * @param page
     * @param pageNow
     * @return
     */
    List<Question> getQuestionListByTag(String tagid, Page page, String pageNow, List<String> qList, String q);

    /**
     * 根据用户id查询问题列表
     * @param isover
     * @param userid
     * @param page
     * @param pageNow
     * @return
     */
    List<Question> getQuestionListByUserId(Integer isover, String userid, Page page, String pageNow, String q);

    /**
     * 插入问题
     * @param title
     * @param content
     * @param userid
     * @param tags
     * @return
     */
    int insertQuestion(String title, String content, String userid, String tags);

    /**
     * 删除问题
     * @param id
     * @return
     */
    int deleteQuestion(String id);

    /**
     * 根据用户id获取对应类型的问题数
     * @param isover
     * @param userid
     * @return
     */
    int getQuestionCountByUserId(Integer isover, String userid, String q);

    /**
     * 更新问题
     * @param id
     * @param title
     * @param content
     * @param userid
     * @param tags
     * @return
     */
    int updateQuestion(String id, String title, String content, String userid, String tags);

    /**
     * 获得前五问题
     * @return
     */
    List<Question> getTop5Questions();

    /**
     * 获取问题数
     * @param isover
     * @return
     */
    int getQuestionCount(Integer isover);

    /**
     * 获取动态
     * @param id
     * @param page
     * @param pageNow
     * @return
     */
    List<Question> getDynamics(String id, Page page, String pageNow);

    /**
     * 获取当前阅读量
     * @param id
     * @return
     */
    int getViews(String id);

    /**
     * 增加当前阅读量
     * @param id
     * @return
     */
    int addViews(String id);

    /**
     * 查询所有问题
     * @return
     */
    List<Question> getQuestions();
}
