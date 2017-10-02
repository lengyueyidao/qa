package org.jiahao.qa.service.impl;

import org.jiahao.qa.dao.QuestionMapper;
import org.jiahao.qa.dao.QuestiontagMapper;
import org.jiahao.qa.dao.TagMapper;
import org.jiahao.qa.pojo.Question;
import org.jiahao.qa.pojo.QuestiontagKey;
import org.jiahao.qa.pojo.Tag;
import org.jiahao.qa.service.QuestionService;
import org.jiahao.qa.util.*;
import org.springframework.stereotype.Service;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Alvin on 2016/10/4.
 */
@Service("questionService")
public class QuestionServiceImpl implements QuestionService {

    @Resource
    private QuestionMapper questionMapper;

    @Resource
    private TagMapper tagMapper;

    @Resource
    private QuestiontagMapper questiontagMapper;

    public List<Question> getQuestionList(Integer isover, Page page, String pageNow, List<String> qList, String q) {
        List<Question> questionList;
        if(q == null || "".equals(q)) {
            int totalCount = questionMapper.selectQuestionCount(isover, null);
            PageUtil.createPage(page, pageNow, totalCount);
            questionList = questionMapper.selectQuestionList(isover, page.getStartPos(), page.getPageSize(), null);
        }
        else {
            Integer startPos = pageNow != null?(Integer.parseInt(pageNow)-1)*page.getPageSize():1;
            HashMap map = SearchUtil.searchIndexFile(q, startPos, page.getPageSize(), isover, null);
            PageUtil.createPage(page, pageNow, Integer.parseInt(map.get("total").toString()));
            questionList = (List<Question>) map.get("questions");
        }
        return questionList;
    }


    public Question getQuestion(String id) {
        return questionMapper.selectQuestion(id);
    }

    public int overQuestion(String id, Integer isover) {
        return questionMapper.overQuestion(id, isover);
    }

    public List<Question> getQuestionListByTag(String tagid, Page page, String pageNow, List<String> qList, String q) {
        List<Question> questionList;
        if(q == null || "".equals(q)) {
            int totalCount = questionMapper.selectQuestionCountByTag(tagid, qList);
            PageUtil.createPage(page, pageNow, totalCount);
            questionList = questionMapper.selectQuestionListByTag(tagid, page.getStartPos(), page.getPageSize(), null);
        }
        else {
            Integer startPos = pageNow != null?(Integer.parseInt(pageNow)-1)*page.getPageSize():1;
            HashMap map = SearchUtil.searchIndexFile(q, startPos, page.getPageSize(), null, tagid);
            PageUtil.createPage(page, pageNow, Integer.parseInt(map.get("total").toString()));
            questionList = (List<Question>) map.get("questions");
        }
        return questionList;
    }

    public List<Question> getQuestionListByUserId(Integer isover, String userid, Page page, String pageNow, String q) {

        if(page != null) {
            int totalCount = questionMapper.selectQuestionCountByUserId(isover, userid, q);

            PageUtil.createPage(page, pageNow, totalCount);

            return questionMapper.selectQuestionListByUserId(isover, userid, q, page.getStartPos(), page.getPageSize());
        }
        else {
            return questionMapper.selectQuestionListByUserId(isover, userid, q, null, null);
        }
    }

    @Transactional
    public int insertQuestion(String title, String content, String userid, String tags) {

        try {
            String[] tagList = tags.split(";");

            Question q = new Question();

            String id = IdUtil.getUUID();
            q.setId(id);
            q.setTitle(title);
            q.setContent(content);
            q.setUserid(userid);
            q.setAnswers(0);
            q.setIsover(0);
            q.setViews(0);

            questionMapper.insert(q);


            for (String tagStr : tagList) {
                Tag tag = tagMapper.selectByName(tagStr);
                // 判断标签是否存在
                // 如果存在，那就添加问题与标签的对应关系
                if (tag != null) {
                    QuestiontagKey qtk = new QuestiontagKey();
                    qtk.setTagid(tag.getId());
                    qtk.setQuestionid(id);
                    questiontagMapper.insert(qtk);
                }
                // 如果不存在，那就添加一个标签，然后建立对应关系
                else {
                    Tag newtag = new Tag();
                    String tagid = IdUtil.getUUID();
                    newtag.setId(tagid);
                    newtag.setName(tagStr);
                    // 添加标签
                    tagMapper.insert(newtag);
                    // 建立对应关系
                    QuestiontagKey qtk = new QuestiontagKey();
                    qtk.setTagid(tagid);
                    qtk.setQuestionid(id);
                    questiontagMapper.insert(qtk);

                }
            }
            // 新增索引
            Question indexQ = questionMapper.selectQuestion(id);
            SearchUtil.addIndexFile(indexQ);
        } catch (Exception e) {
            return 0;
        }
        return 1;
    }

    public int deleteQuestion(String id) {
        int r = questionMapper.deleteByPrimaryKey(id);
        if(r > 0) {
            // 删除索引
            SearchUtil.deleteIndexFile(id);
            return 1;
        }
        return 0;
    }

    public int getQuestionCountByUserId(Integer isover, String userid, String q) {
        return questionMapper.selectQuestionCountByUserId(isover, userid, q);
    }

    @Transactional
    public int updateQuestion(String id, String title, String content, String userid, String tags) {
        try {
            String[] tagList = tags.split(";");

            Question q = new Question();
            q.setId(id);
            q.setTitle(title);
            q.setContent(content);
            q.setUserid(userid);

            questionMapper.updateByPrimaryKeySelective(q);

            for (String tagStr : tagList) {

                Tag tag = tagMapper.selectByName(tagStr);
                // 判断标签是否存在
                // 如果存在，首先判断是否有对应关联，如果没有那就添加问题与标签的对应关系
                if (tag != null) {

                    QuestiontagKey qt = questiontagMapper.selectQuestionTagByQT(id, tag.getId());

                    if(qt == null) {

                        QuestiontagKey qtk = new QuestiontagKey();
                        qtk.setTagid(tag.getId());
                        qtk.setQuestionid(id);
                        questiontagMapper.insert(qtk);
                    }
                }
                // 如果不存在，那就添加一个标签，然后建立对应关系
                else {
                    Tag newtag = new Tag();
                    String tagid = IdUtil.getUUID();
                    newtag.setId(tagid);
                    newtag.setName(tagStr);
                    // 添加标签
                    tagMapper.insert(newtag);
                    // 建立对应关系
                    QuestiontagKey qtk = new QuestiontagKey();
                    qtk.setTagid(tagid);
                    qtk.setQuestionid(id);
                    questiontagMapper.insert(qtk);

                }
            }
            // 更新索引
            Question indexQ = questionMapper.selectQuestion(id);
            SearchUtil.updateIndexFile(indexQ);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 1;
    }

    public List<Question> getTop5Questions() {
        return questionMapper.selectTop5Questions();
    }

    public int getQuestionCount(Integer isover) {
        return questionMapper.selectQuestionCount(isover, null);
    }

    public List<Question> getDynamics(String id, Page page, String pageNow) {

        int totalCount = questionMapper.selectDynamicsCount(id);

        PageUtil.createPage(page, pageNow, totalCount);

        return questionMapper.selectDynamics(id, page.getStartPos(), page.getPageSize());
    }

    public int getViews(String id) {
        return questionMapper.selectViews(id);
    }

    public int addViews(String id) {
        return questionMapper.updateViews(id);
    }

    public List<Question> getQuestions() {
        return questionMapper.selectQuestions();
    }
}
