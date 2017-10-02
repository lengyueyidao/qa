package org.jiahao.qa.controller;

import org.jiahao.qa.pojo.User;
import org.jiahao.qa.service.UserService;
import org.jiahao.qa.util.AjaxResponse;
import org.jiahao.qa.util.ImageCutUtil;
import org.jiahao.qa.util.SpringContextUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;


/**
 * 用户控制器
 * toLogin 访问登录页
 * login 处理登录请求
 * toRegister 访问注册页
 * register 处理注册请求
 * logout 处理登出请求
 * configUpd 修改设置
 * updPwd 修改密码
 * uploadtemp 上传临时图片
 * upload 上传头像
 * getHead 获取头像流
 * getHeadTemp 获取临时头像流
 * deleteHeadTemp 删除临时头像
 * Created by Alvin on 2016/10/15.
 */
@Controller
public class UserController {

    @Resource
    private UserService userService;

    @RequestMapping("/login" )
    public String toLogin(HttpSession session) {
        // 判断是否已经登陆，若登陆，进入登录页面时直接跳转到主页
        if(session.getAttribute("user")!=null) {
            return "redirect:index";
        }
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResponse login(String usercode, String password, HttpSession session) {
        AjaxResponse ajaxResponse = new AjaxResponse();

        User user = userService.login(usercode, password);

        if(user != null) {
            ajaxResponse.setStatus("ok");
            session.setAttribute("user", user);
        }
        else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("登录失败！用户名或密码不正确！");
        }

        return ajaxResponse;
    }

    @RequestMapping("/register")
    public String toRegister() {
        return "register";
    }

    @RequestMapping(value = "register", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResponse register(User user) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        if(!userService.isExist(user.getUsercode(), null)) {
            int result = userService.register(user);
            if(1 == result) {
                ajaxResponse.setStatus("ok");
                ajaxResponse.setMsg("注册成功！");
            }
            else {
                ajaxResponse.setStatus("error");
                ajaxResponse.setMsg("注册失败！");
            }
        }else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("注册失败！该用户已存在！");
        }


        return ajaxResponse;
    }

    @RequestMapping("/logout")
    @ResponseBody
    public AjaxResponse logout(HttpSession session) {

        AjaxResponse ajaxResponse = new AjaxResponse();

        try {
            session.removeAttribute("user");
            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("登出成功！");
        } catch (Exception e) {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg(e.getMessage());
        }

        return ajaxResponse;
    }

    @RequestMapping("/ucenterconfigupd")
    @ResponseBody
    public AjaxResponse configUpd(String username, String sex, String address, String description, HttpSession session) {
        AjaxResponse ajaxResponse = new AjaxResponse();
        User user = (User) session.getAttribute("user");
        user.setUsername(username);
        user.setSex(sex);
        user.setAddress(address);
        user.setDescription(description);
        int r = userService.updatePersonalInfo(user);
        if(r > 0) {

            session.removeAttribute("user");
            session.setAttribute("user", user);

            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("保存成功!");
        }else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("保存失败!");
        }
        return ajaxResponse;
    }

    @RequestMapping("/ucenterupdpwd")
    @ResponseBody
    public AjaxResponse updPwd(String oldpassword, String password, HttpSession session) {
        AjaxResponse ajaxResponse = new AjaxResponse();

        User user = (User) session.getAttribute("user");

        if(!user.getPassword().equals(oldpassword)) {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("旧的密码输入不正确！");
            return ajaxResponse;
        }

        int r = userService.updatePassword(password, user.getId());
        if(r > 0) {

            session.removeAttribute("user");
            user.setPassword(password);
            session.setAttribute("user", user);

            ajaxResponse.setStatus("ok");
            ajaxResponse.setMsg("修改成功!");
        }else {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("修改失败!");
        }
        return ajaxResponse;
    }

    @RequestMapping("/ucenteruploadtemp")
    @ResponseBody
    public AjaxResponse uploadtemp(MultipartFile imgFile, String path, HttpSession session) {
        AjaxResponse ajaxResponse = new AjaxResponse();
        String name = imgFile.getOriginalFilename();

        if(!name.endsWith(".png")&&!name.endsWith(".jpg")) {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("请选择.png或者.jpg格式的图片！");
            return ajaxResponse;
        }

        if(path != null && !"".equals(path)) {
            File oldfile = new File(path);
            oldfile.delete();
        }

        User user = (User) session.getAttribute("user");

        String fpath = SpringContextUtil.getSysParamsByName("UPLOAD_PATH");
        File file = new File(fpath);
        if(!file.exists()) {
            file.mkdirs();
        }
        String imgFileName = imgFile.getOriginalFilename();
        String filename = "temp_" + user.getId() + imgFileName.substring(imgFileName.lastIndexOf('.'));
        File targetFile = new File(fpath+filename);
        try {
            imgFile.transferTo(targetFile);
        } catch (IOException e) {
            e.printStackTrace();
        }

        ajaxResponse.setStatus("ok");
        ajaxResponse.setData(fpath+filename);
        return ajaxResponse;
    }

    @RequestMapping("/ucenterupload")
    @ResponseBody
    public AjaxResponse upload(String path, String x, String y, String w, String h, HttpSession session) {
        AjaxResponse ajaxResponse = new AjaxResponse();
        if(path == null || "".equals(path)) {
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("请选择图片！");
            return ajaxResponse;
        }
        User user = (User) session.getAttribute("user");
        user = userService.getUserById(user.getId());
        String oldheadpath = user.getHeadpath();
        boolean flag = false;
        try {
            String srcImagePath = path;
            if("".equals(x)) {
                ajaxResponse.setStatus("error");
                ajaxResponse.setMsg("请截取头像！");
                return ajaxResponse;
            }
            x = x.split("\\.")[0];
            y = y.split("\\.")[0];
            w = w.split("\\.")[0];
            h = h.split("\\.")[0];
            int imageX = Integer.parseInt(x);
            int imageY = Integer.parseInt(y);
            int imageW = Integer.parseInt(w);
            int imageH = Integer.parseInt(h);
            //这里开始截取操作
            System.out.println("==========imageCutStart=============");
            String filepath = ImageCutUtil.imgCut(srcImagePath, imageX, imageY, imageW, imageH);
            System.out.println("==========imageCutEnd=============");

            if (filepath != null) {

                int r = userService.updateHeadpath(filepath, user.getId());
                if (r > 0) {
                    if(user.getHeadpath()!=null) {
                        flag = true;
                    }
                    ajaxResponse.setStatus("ok");
                    ajaxResponse.setMsg("修改头像成功!");
                    return ajaxResponse;
                } else {
                    ajaxResponse.setStatus("error");
                    ajaxResponse.setMsg("修改头像失败!");
                    return ajaxResponse;
                }
            } else {
                ajaxResponse.setStatus("error");
                ajaxResponse.setMsg("修改头像失败!");
                return ajaxResponse;
            }
        }catch (Exception e) {
            e.printStackTrace();
            ajaxResponse.setStatus("error");
            ajaxResponse.setMsg("修改头像失败!");
            return ajaxResponse;
        } finally {
            File file = new File(path);
            file.delete();
            if(flag) {
                System.out.println(oldheadpath);
                File oldfile = new File(oldheadpath);
                if(oldfile.exists()) {
                    boolean re = oldfile.delete();
                    System.out.println(re);
                }
            }
        }
    }

    @RequestMapping("/gethead")
    public void getHead(String id, HttpServletRequest request, HttpServletResponse response) throws Exception {

        User user = userService.getUserById(id);

        File file = null;

        if(user.getHeadpath() != null) {
            file = new File(user.getHeadpath());
            if(!file.exists()) {
                file = new File(request.getSession().getServletContext().getRealPath("/")+"ucenter/img/touxiang.png");
            }
        }
        else {
            file = new File(request.getSession().getServletContext().getRealPath("/")+"ucenter/img/touxiang.png");
        }
        FileInputStream inputStream = new FileInputStream(file);
        byte[] data = new byte[(int)file.length()];
        int length = inputStream.read(data);
        inputStream.close();

        response.setContentType("image/jpeg");

        OutputStream stream = response.getOutputStream();
        stream.write(data);
        stream.flush();
        stream.close();
    }

    @RequestMapping("/ucentergetheadtemp")
    public void getHeadTemp(String filepath, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {

        File file = new File(filepath);

        FileInputStream inputStream = new FileInputStream(file);
        byte[] data = new byte[(int)file.length()];
        int length = inputStream.read(data);
        inputStream.close();

        response.setContentType("image/jpeg");

        OutputStream stream = response.getOutputStream();
        stream.write(data);
        stream.flush();
        stream.close();
    }

    @RequestMapping("/ucenterdeleteheadtemp")
    @ResponseBody
    public AjaxResponse deleteHeadTemp(String path) {

        File file = new File(path);
        if(file.exists()) {
            file.delete();
        }
        AjaxResponse ajaxResponse = new AjaxResponse();
        ajaxResponse.setStatus("ok");
        return ajaxResponse;
    }
}
