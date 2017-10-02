package org.jiahao.qa.controller;

import org.jiahao.qa.pojo.Answer;
import org.jiahao.qa.pojo.Follow;
import org.jiahao.qa.pojo.User;
import org.jiahao.qa.service.AnswerService;
import org.jiahao.qa.service.FollowService;
import org.jiahao.qa.util.AjaxResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 关注控制器
 * following 关注他人
 * unfollowing 取消关注他人
 * tofollowing 访问关注他人页
 * tofollowed 访问被关注页
 * Created by Alvin on 2016/11/3.
 */
@Controller
public class  FollowController {

    @Resource
    private FollowService followService;

    @Resource
    private AnswerService answerService;

    @RequestMapping("/ucenterfollowadd")
    @ResponseBody
    public AjaxResponse following(String id, HttpSession session) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        User user = (User) session.getAttribute("user");
        int r = followService.insertFollow(user.getId(), id);
        if(r > 0) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("关注成功！");
        }else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("关注失败！");
        }
        return ajaxResponse;
    }

    @RequestMapping("/ucenterfollowdel")
    @ResponseBody
    public AjaxResponse unfollowing(String id, HttpSession session) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        User user = (User) session.getAttribute("user");
        int r = followService.deleteFollow(user.getId(), id);
        if(r > 0) {
            ajaxResponse.setStatus("ok");
        }else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("取消关注失败！");
        }
        return ajaxResponse;
    }

    @RequestMapping("/ucenterfollowed")
    public String tofollowed(Model model, String id, HttpSession session) {

        List<Follow> followList = followService.getFollowed(id);
        model.addAttribute("follows", followList);

        User user = (User) session.getAttribute("user");
        if(user.getId().equals(id)) {
            return "ucenter/followed";
        }
        else {
            // 找未读消息
            List<Answer> answerList = answerService.getUnLookAnswers(user.getId());
            model.addAttribute("answers", answerList);
            return "ucenter/otherfollowed";
        }


    }

    @RequestMapping("/ucenterfollowing")
    public String tofollowing(Model model, String id, HttpSession session) {

        List<Follow> followList = followService.getFollowing(id);
        model.addAttribute("follows", followList);

        User user = (User) session.getAttribute("user");
        if(user.getId().equals(id)) {
            return "ucenter/following";
        }
        else {
            // 找未读消息
            List<Answer> answerList = answerService.getUnLookAnswers(user.getId());
            model.addAttribute("answers", answerList);
            return "ucenter/otherfollowing";
        }
    }
}
