package org.jiahao.qa.controller.admin;

import org.jiahao.qa.pojo.User;
import org.jiahao.qa.service.UserService;
import org.jiahao.qa.service.UserService;
import org.jiahao.qa.util.AjaxResponse;
import org.jiahao.qa.util.IdUtil;
import org.jiahao.qa.util.Page;
import org.jiahao.qa.util.PageUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.File;
import java.util.List;

/**
 * toUserMgmt 访问管理员中用户管理界面
 * add 新增用户
 * upd 修改用户
 * del 删除用户
 * Created by Alvin on 2016/12/8.
 */
@Controller
public class UserMgmtController {

    @Resource
    private UserService userService;


    @RequestMapping("/adminuser")
    public String toUserMgmt(String q, String pageNow, Model model) {

        Page page = new Page();
        List<User> userList = userService.getUserList(page, pageNow, "".equals(q)?null:q);
        model.addAttribute("users", userList);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        return "admin/usermgmt";
    }

    @RequestMapping("/adminuseradd")
    @ResponseBody
    public AjaxResponse add(String usercode, String password, String username, String sex, String address, String description) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        // 判断用户是否存在
        boolean isExist = userService.isExist(usercode, null);
        if(isExist) {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("新增失败，该用户已存在！");
            return ajaxResponse;
        }

        User user = new User();
        user.setUsercode(usercode);
        user.setPassword(password);
        user.setUsername(username);
        user.setSex(sex);
        user.setAddress(address);
        user.setDescription(description);

        int r = userService.register(user);
        if(r > 0) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("新增成功！");
        }
        else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("新增失败！");
        }
        return ajaxResponse;
    }

    @RequestMapping("/adminuserupdate")
    @ResponseBody
    public AjaxResponse upd(String id, String usercode, String password, String username, String sex, String address, String description) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        // 判断该用户是否存在
        boolean isExist = userService.isExist(usercode, "".equals(id)?null:id);
        if(isExist) {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("修改失败，该用户已存在！");
            return ajaxResponse;
        }

        User user = new User();
        user.setId(id);
        user.setUsercode(usercode);
        user.setPassword(password);
        user.setUsername(username);
        user.setSex(sex);
        user.setAddress(address);
        user.setDescription(description);

        int r = userService.updatePersonalInfo(user);
        if(r > 0) {
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("修改成功！");
        }
        else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("修改失败！");
        }
        return ajaxResponse;
    }

    @RequestMapping("/adminuserdelete")
    @ResponseBody
    public AjaxResponse del(String id) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        User user = userService.getUserById(id);
        String headpath = user.getHeadpath();
        int r = userService.deleteUser(id);
        // 删除用户的时候如果他有头像，则删除头像文件
        if(r > 0 && headpath != null && !"".equals(headpath)) {
            File file = new File(headpath);
            file.delete();
        }

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
