package org.jiahao.qa.controller.admin;

import org.jiahao.qa.pojo.Follow;
import org.jiahao.qa.pojo.Notice;
import org.jiahao.qa.service.FollowService;
import org.jiahao.qa.util.AjaxResponse;
import org.jiahao.qa.util.DateUtil;
import org.jiahao.qa.util.IdUtil;
import org.jiahao.qa.util.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * toFollowMgmt 访问管理员中关注管理界面
 * del 删除关注
 * Created by Alvin on 2016/12/9.
 */
@Controller
public class FollowMgmtController {

    @Resource
    private FollowService followService;

    @RequestMapping("/adminfollow")
    public String toFollowMgmt(String q, String pageNow, Model model) {

        Page page = new Page();
        List<Follow> followList = followService.getFollows(page, pageNow, "".equals(q)?null:q);
        model.addAttribute("follows", followList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        return "admin/followmgmt";
    }

    @RequestMapping("/adminfollowdelete")
    @ResponseBody
    public AjaxResponse del(String userid, String followuserid) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        int r = followService.deleteFollow(userid, followuserid);
        if(r > 0) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("删除成功！");
        }
        else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("删除失败！");
        }
        return ajaxResponse;
    }

}
