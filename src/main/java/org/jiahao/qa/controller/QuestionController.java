package org.jiahao.qa.controller;

import com.alibaba.fastjson.JSON;
import org.jiahao.qa.pojo.*;
import org.jiahao.qa.service.*;
import org.jiahao.qa.util.AjaxResponse;
import org.jiahao.qa.util.Page;
import org.jiahao.qa.util.SearchUtil;
import org.pegdown.PegDownProcessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * toQuestion 访问对应问题页
 * add 提交问题
 * upd 修改问题
 * del 删除问题
 * loadDy 加载动态
 * over 设置问题是否解决
 * Created by Alvin on 2016/10/16.
 */
@Controller
public class QuestionController {

    @Resource
    private QuestionService questionService;

    @Resource
    private AnswerService answerService;

    @Resource
    private TagService tagService;

    @Resource
    private NoticeService noticeService;

    @Resource
    private ViewService viewService;

    @Resource
    private QuestionTagService questionTagService;

    @RequestMapping("/question")
    public String toQuestion(String id, Model model, HttpSession session) {

        User user = (User) session.getAttribute("user");

        Question question = questionService.getQuestion(id);

        // markdown转html工具
        PegDownProcessor pdp = new PegDownProcessor(Integer.MAX_VALUE);
        question.setContent(pdp.markdownToHtml(question.getContent()));

        System.out.println(question.getContent());
        List<Tag> tags = tagService.getTagsByQuestionId(question.getId());
        question.setTags(tags);

        int cnt = answerService.getAnswerCntByQid(id);
        question.setAnswers(cnt);

        List<Answer> answerList = answerService.getAnswerListByQuestionId(question.getId());

        if(user != null) {
            // 找未读
            List<Answer> unLookAnswers = answerService.getUnLookAnswers(user.getId());

            for (Answer answer : answerList) {
                for(Answer child : answer.getChilds()) {
                    for (Answer unLookAnswer : unLookAnswers) {
                        if (answer.getId().equals(unLookAnswer.getId())) {
                            answerService.lookAnswer(answer.getId());
                        }
                        if(child.getId().equals(unLookAnswer.getId())) {
                            answerService.lookAnswer(child.getId());
                        }
                    }
                }
            }

            if(!question.getUserid().equals(user.getId())) {
                // 查找今日是否查看过
                View view = viewService.getTodayView(user.getId(), question.getId());
                if(view == null) {
                    // 添加一条查看记录
                    viewService.addTodayView(user.getId(), question.getId());
                    questionService.addViews(question.getId());
                    int views = questionService.getViews(question.getId());
                    question.setViews(views);
                }
            }
        }

        Notice notice = noticeService.getLatestNotice();

        model.addAttribute("question", question);
        model.addAttribute("answers", answerList);
        model.addAttribute("notice", notice);

        return "question";
    }


    @RequestMapping("ucenterquestionadd")
    @ResponseBody
    public AjaxResponse add(String title, String content, String tags, HttpSession session) {


        User user = (User) session.getAttribute("user");

        int re = questionService.insertQuestion(title, content, user.getId(), tags);

        AjaxResponse ajaxResponse = new AjaxResponse();
        if(re == 1) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("提交问题成功！");
        }else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("提交问题失败！");
        }
        return ajaxResponse;

    }

    @RequestMapping("ucenterquestionupd")
    @ResponseBody
    public AjaxResponse upd(String id, String title, String content, String tags, HttpSession session) {


        User user = (User) session.getAttribute("user");

        int re = questionService.updateQuestion(id, title, content, user.getId(), tags);

        AjaxResponse ajaxResponse = new AjaxResponse();
        if(re == 1) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("修改问题成功！");
        }else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("修改问题失败！");
        }
        return ajaxResponse;

    }


    @RequestMapping("ucenterquestiondel")
    @ResponseBody
    public AjaxResponse del(String qid) {

        int re = questionService.deleteQuestion(qid);
        if(re > 0) {
            // 删除成功时把对应的Tag关联删除
            questionTagService.deleteTagsByQuestionId(qid);
        }

        AjaxResponse ajaxResponse = new AjaxResponse();
        if(re == 1) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("删除问题成功！");
        }else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("删除问题失败！");
        }
        return ajaxResponse;

    }

    @RequestMapping("ucenterloaddynamics")
    @ResponseBody
    public AjaxResponse loadDy(HttpSession session, String pageNow) {

        User user = (User) session.getAttribute("user");

        Page page = new Page();

        List<Question> questionList = questionService.getDynamics(user.getId(), page, pageNow);

        AjaxResponse ajaxResponse = new AjaxResponse();
        ajaxResponse.setStatus("ok");
        ajaxResponse.setObj(page);
        ajaxResponse.setList(questionList);
        return ajaxResponse;
    }

    @RequestMapping("ucenterloadotherdynamics")
    @ResponseBody
    public AjaxResponse loadDy(HttpSession session, String pageNow, String id) {


        Page page = new Page();

        List<Question> questionList = questionService.getQuestionListByUserId(null, id, page, pageNow, null);

        AjaxResponse ajaxResponse = new AjaxResponse();
        ajaxResponse.setStatus("ok");
        ajaxResponse.setObj(page);
        ajaxResponse.setList(questionList);
        return ajaxResponse;
    }

    @RequestMapping("/ucenterover")
    @ResponseBody
    public AjaxResponse over(String id, Integer isover) {

        int r = questionService.overQuestion(id, isover);

        AjaxResponse ajaxResponse = new AjaxResponse();
        if(r > 0) {
            ajaxResponse.setStatus("ok");
        }
        else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("设置失败!");
        }
        return ajaxResponse;

    }

    @RequestMapping("/adminupdateindex")
    @ResponseBody
    public AjaxResponse updateIndex() {
        AjaxResponse ajaxResponse = new AjaxResponse();
        try {
            List<Question> questionList = questionService.getQuestions();
            SearchUtil.createIndexFile(questionList);
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("更新索引成功！");
        }catch (Exception e) {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("更新索引失败！");
        }
        return ajaxResponse;
    }


}
