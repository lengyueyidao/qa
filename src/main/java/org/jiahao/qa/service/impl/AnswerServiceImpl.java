package org.jiahao.qa.service.impl;

import org.jiahao.qa.dao.AnswerMapper;
import org.jiahao.qa.pojo.Answer;
import org.jiahao.qa.service.AnswerService;
import org.jiahao.qa.util.Page;
import org.jiahao.qa.util.PageUtil;
import org.pegdown.PegDownProcessor;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Alvin on 2016/10/23.
 */
@Service("answerService")
public class AnswerServiceImpl implements AnswerService {

    @Resource
    private AnswerMapper answerMapper;

    public List<Answer> getAnswerListByQuestionId(String questionId) {

        List<Answer> list = answerMapper.selectByQuestionId(questionId);
        List<Answer> answers = new ArrayList<Answer>();
        for(Answer a : list) {

            if(a.getParentid() == null) {

                List<Answer> childs = new ArrayList<Answer>();

                for(Answer a1 : list) {
                    if(a1.getIdpath().startsWith(a.getIdpath()+"/")) {
                        Answer temp = answerMapper.selectByPrimaryKey(a1.getParentid());
                        a1.setParentname(temp.getUsername());
                        childs.add(a1);
                    }
                }
                a.setChilds(childs);
                PegDownProcessor pdp = new PegDownProcessor(Integer.MAX_VALUE);
                a.setContent(pdp.markdownToHtml(a.getContent()));
                answers.add(a);
            }
        }

        return answers;
    }

    public List<Answer> getAnswerListByUserId(String userId, Page page, String pageNow, String q) {
        int totalCount = answerMapper.selectCountByUserId(userId, q);
        PageUtil.createPage(page, pageNow, totalCount);
        return answerMapper.selectByUserId(userId, page.getStartPos(), page.getPageSize(), q);
    }

    public int deleteAnswer(String id) {
        return answerMapper.deleteByPrimaryKey(id);
    }

    public int addAnswer(Answer answer) {
        return answerMapper.insert(answer);
    }

    public List<Answer> getTop5Answers() {
        return answerMapper.selectTop5Answers();
    }

    public Answer getAnswerById(String id) {
        return answerMapper.selectByPrimaryKey(id);
    }

    public int getAnswerCntByQid(String id) {
        return answerMapper.selectAnswerCntByQid(id);
    }

    public List<Answer> getUnLookAnswers(String id) {
        return answerMapper.selectUnLookAnswers(id);
    }

    public void lookAnswer(String aid) {
        answerMapper.updateAnswerLook(aid);
    }

    public List<Answer> getAnswerList(Page page, String pageNow, String q) {

        int totalCount = answerMapper.selectCount(q);
        PageUtil.createPage(page, pageNow, totalCount);
        return answerMapper.selectAnswerList(page.getStartPos(), page.getPageSize(), q);
    }
}
