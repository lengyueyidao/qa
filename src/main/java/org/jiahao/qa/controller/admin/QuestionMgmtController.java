package org.jiahao.qa.controller.admin;

import org.jiahao.qa.pojo.Question;
import org.jiahao.qa.pojo.Tag;
import org.jiahao.qa.pojo.User;
import org.jiahao.qa.service.AnswerService;
import org.jiahao.qa.service.QuestionService;
import org.jiahao.qa.service.TagService;
import org.jiahao.qa.util.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * toQuestionMgmt 访问管理员中问题管理界面
 * setQuestionTagsAndAnswers 设置问题标签和回答数的关联
 * Created by Alvin on 2016/12/10.
 */
@Controller
public class QuestionMgmtController {

    @Resource
    private QuestionService questionService;

    @Resource
    private TagService tagService;

    @Resource
    private AnswerService answerService;

    @RequestMapping("/adminquestion")
    public String toQuestionMgmt(String pageNow, String q, Model model) {
        Page page = new Page();
        List<Question> questionList = questionService.getQuestionList(null, page, pageNow, null, "".equals(q)?null:q);
        setQuestionTagsAndAnswers(questionList);
        model.addAttribute("questions", questionList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        return "admin/questionmgmt";
    }

    public void setQuestionTagsAndAnswers(List<Question> questionList) {
        for(Question q : questionList) {
            // 获取问题对应标签
            List<Tag> tags = tagService.getTagsByQuestionId(q.getId());
            q.setTags(tags);
            // 获取问题回答数
            int cnt = answerService.getAnswerCntByQid(q.getId());
            q.setAnswers(cnt);
        }

    }

}
