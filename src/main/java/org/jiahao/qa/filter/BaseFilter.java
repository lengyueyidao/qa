package org.jiahao.qa.filter;

import org.jiahao.qa.pojo.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 过滤器
 * Created by Alvin on 2016/10/29.
 */
@WebFilter(filterName = "BaseFilter")
public class BaseFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        request.setCharacterEncoding("UTF-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String name = request.getRequestURI().substring(request.getContextPath().length()+1);
        if(name.startsWith("ucenter")) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if(user == null) {
                System.out.println("发生拦截：" + name);
                response.sendRedirect("login");
            }
            else {
                chain.doFilter(req, resp);
            }
        }
        else if(name.startsWith("admin")) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if(user == null) {
                System.out.println("发生拦截：" + name);
                response.sendRedirect("login");
            }
            else {
                if(!user.getUsercode().equals("admin")) {
                    System.out.println("发生拦截：" + name);
                    response.sendRedirect("login");
                }
                else {
                    chain.doFilter(req, resp);
                }
            }
        }
        else {
            chain.doFilter(req, resp);
        }

    }

    public void init(FilterConfig config) throws ServletException {

    }

}
