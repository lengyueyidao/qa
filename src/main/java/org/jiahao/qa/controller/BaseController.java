package org.jiahao.qa.controller;

import org.jiahao.qa.pojo.*;
import org.jiahao.qa.service.*;
import org.jiahao.qa.util.AnalyzerUtil;
import org.jiahao.qa.util.Page;
import org.jiahao.qa.util.SpringContextUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * 基础控制器
 * toIndex 访问首页
 * toWait 访问未解决问题页
 * toSolve 访问已解决问题页
 * toQuestionTag 访问标签对应的问题页
 * toTags 访问标签页
 * toPersonalcenter 访问个人中心页
 * toHome 访问主页
 * toAsk 访问我要提问页
 * toEdit 访问问题编辑页
 * toMyQuestion 访问我的问题页
 * toMyAnswer 访问我的回答页
 * toConfig 访问设置页
 * toOtherhome 访问他人主页
 * setQuestionTagsAndAnswers 设置问题的标签和回答数
 * getAnalyzer 获取分词列表
 * Created by Alvin on 2016/10/15.
 */
@Controller
public class BaseController {

    @Resource
    private QuestionService questionService;

    @Resource
    private TagService tagService;

    @Resource
    private AnswerService answerService;

    @Resource
    private UserService userService;

    @Resource
    private FollowService followService;

    @Resource
    private NoticeService noticeService;

    @RequestMapping({"/", "/index"})
    public String toIndex(Model model, String pageNow, String q) {

        Page page = new Page();

        //分词
        List<String> qList = getAnalyzer(q);

        List<Question> questionList = questionService.getQuestionList(null, page, pageNow, qList, q);

        setQuestionTagsAndAnswers(questionList);

        // 获取最新公告
        Notice notice = noticeService.getLatestNotice();
        model.addAttribute("notice", notice);

        model.addAttribute("questions", questionList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        model.addAttribute("qList", qList);

        return "index";
    }

    @RequestMapping("/wait")
    public String toWait(Model model, String pageNow, String q) {

        Page page = new Page();
        //分词
        List<String> qList = getAnalyzer(q);
        List<Question> questionList = questionService.getQuestionList(0, page, pageNow, qList, q);

        setQuestionTagsAndAnswers(questionList);

        Notice notice = noticeService.getLatestNotice();
        model.addAttribute("notice", notice);

        model.addAttribute("questions", questionList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        model.addAttribute("qList", qList);
        return "waitanswer";
    }

    @RequestMapping("/solve")
    public String toSolve(Model model, String pageNow, String q) {

        Page page = new Page();
        //分词
        List<String> qList = getAnalyzer(q);
        List<Question> questionList = questionService.getQuestionList(1, page, pageNow, qList, q);

        setQuestionTagsAndAnswers(questionList);

        Notice notice = noticeService.getLatestNotice();
        model.addAttribute("notice", notice);

        model.addAttribute("questions", questionList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        model.addAttribute("qList", qList);
        return "solve";
    }

    @RequestMapping("/questiontag")
    public String toQuestionTag(String tagid, Model model, String pageNow, String q) {

        Page page = new Page();
        //分词
        List<String> qList = getAnalyzer(q);
        List<Question> questionList = questionService.getQuestionListByTag(tagid, page, pageNow, qList, q);
        setQuestionTagsAndAnswers(questionList);
        model.addAttribute("questions", questionList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        model.addAttribute("qList", qList);
        model.addAttribute("tagid", tagid);
        Notice notice = noticeService.getLatestNotice();
        model.addAttribute("notice", notice);

        return "questiontag";
    }

    @RequestMapping("/tags")
    public String toTags(Model model, String pageNow, String q) {

        Page page = null;

        int totalCount = tagService.getTagCount(q);

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
            page = new Page(totalCount, pn);
        } else {
            page = new Page(totalCount, 1);
        }
        try {
            String ps = SpringContextUtil.getSysParamsByName("TAG_PAGE_SIZE");
            page.setPageSize(Integer.parseInt(ps));
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<Tag> tagList = tagService.getTags(page.getStartPos(), page.getPageSize(), q);
        model.addAttribute("tags", tagList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);

        Notice notice = noticeService.getLatestNotice();
        model.addAttribute("notice", notice);

        return "tags";
    }

    @RequestMapping("/ucenter")
    public String toPersonalcenter(Model model, HttpSession session) {
        User user = (User)session.getAttribute("user");
        int wai = questionService.getQuestionCountByUserId(0, user.getId(), null);
        int sov = questionService.getQuestionCountByUserId(1, user.getId(), null);
        model.addAttribute("wai", wai);
        model.addAttribute("sov", sov);
        // 找未读消息
        List<Answer> answerList = answerService.getUnLookAnswers(user.getId());
        model.addAttribute("answers", answerList);
        return "ucenter/ucenter";
    }

    @RequestMapping("/ucenterhome")
    public String toHome(Model model, HttpSession session) {

        User user = (User) session.getAttribute("user");

        List<Question> top5QuestionList = questionService.getTop5Questions();
        model.addAttribute("questions", top5QuestionList);
        List<Follow> followList = followService.getFollowed(user.getId());
        model.addAttribute("follows", followList);
        int followingCount = followService.getFollowingCount(user.getId());
        int followedCount = followService.getFollowedCount(user.getId());

        model.addAttribute("followingCount", followingCount);
        model.addAttribute("followedCount", followedCount);

        Page page = new Page();

        // 获取动态信息
        List<Question> questionList = questionService.getDynamics(user.getId(), page, "1");
        model.addAttribute("dynamics", questionList);
        model.addAttribute("page", page);

        return "ucenter/home";
    }

    @RequestMapping("/ucenterask")
    public String toAsk() {
        return "ucenter/ask";
    }

    @RequestMapping("/ucenteredit")
    public String toEdit(String id, Model model){

        // 找问题
        Question question = questionService.getQuestion(id);

        // 找标签
        List<Tag> tagList = tagService.getTagsByQuestionId(id);
        StringBuffer sb = new StringBuffer();
        for(int i = 0; i < tagList.size(); i++) {
            if(i == 0) {
                sb.append(tagList.get(i).getName());
            }
            else {
                sb.append(";").append(tagList.get(i).getName());
            }
        }
        model.addAttribute("question", question);
        model.addAttribute("tags", sb.toString());
        return "ucenter/edit";
    }

    @RequestMapping("/ucentermyquestion")
    public String toMyQuestion(Integer isover, String pageNow, String q, HttpSession session, Model model) {
        Page page = new Page();
        User user = (User)session.getAttribute("user");
        List<Question> questionList = questionService.getQuestionListByUserId(isover, user.getId(), page, pageNow, "".equals(q)?null:q);
        //setQuestionTagsAndAnswers(questionList);
        model.addAttribute("questions", questionList);
        model.addAttribute("isoverstatus", isover);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        return "ucenter/myquestion";
    }

    @RequestMapping("/ucentermyanswer")
    public String toMyAnswer(String pageNow, String q, HttpSession session, Model model) {
        Page page = new Page();
        User user = (User)session.getAttribute("user");
        List<Answer> answerList = answerService.getAnswerListByUserId(user.getId(), page, pageNow, "".equals(q)?null:q);
        model.addAttribute("answers", answerList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        return "ucenter/myanswer";
    }

    @RequestMapping("/ucenterconfig")
    public String toConfig(Model model) {
        return "ucenter/config";
    }

    @RequestMapping("/ucenterotherhome")
    public String toOtherhome(Model model, String id, HttpSession session) {

        User ownuser = (User) session.getAttribute("user");
        if(ownuser.getId().equals(id)) {
            return "redirect:ucenter";
        }

        User user = userService.getUserById(id);
        model.addAttribute("u", user);
        List<Question> top5QuestionList = questionService.getTop5Questions();
        model.addAttribute("questions", top5QuestionList);
        List<Follow> followList = followService.getFollowed(user.getId());
        model.addAttribute("follows", followList);
        int followingCount = followService.getFollowingCount(user.getId());
        int followedCount = followService.getFollowedCount(user.getId());

        model.addAttribute("followingCount", followingCount);
        model.addAttribute("followedCount", followedCount);

        Follow f = followService.isFollowed(ownuser.getId(), user.getId());
        int isFollowed = 0;
        if(f != null) {
            isFollowed = 1;
        }
        model.addAttribute("isFollowed", isFollowed);
        // 找未读消息
        List<Answer> answerList = answerService.getUnLookAnswers(ownuser.getId());
        model.addAttribute("answers", answerList);

        // 读取动态
        Page page = new Page();

        List<Question> questionList = questionService.getQuestionListByUserId(null, user.getId(), page, "1", null);
        model.addAttribute("dynamics", questionList);
        model.addAttribute("page", page);
        return "ucenter/otherhome";
    }

    public void setQuestionTagsAndAnswers(List<Question> questionList) {
        for(Question q : questionList) {
            List<Tag> tags = tagService.getTagsByQuestionId(q.getId());
            q.setTags(tags);
            int cnt = answerService.getAnswerCntByQid(q.getId());
            q.setAnswers(cnt);
        }

    }

    public List<String> getAnalyzer(String q) {
        // 对q进行分词
        List<String> qList = null;
        if(q != null && !"".equals(q)) {
            try {
                qList = AnalyzerUtil.analyze(q);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return qList;
    }

}
