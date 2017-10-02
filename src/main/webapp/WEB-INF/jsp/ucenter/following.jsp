<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>我的关注</title>
    <meta charset="utf-8" />
    <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="shortcut icon" href="<%=basePath%>images/logo.png" type="image/x-icon" >
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/bootstrap.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/animate.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/simple-line-icons.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/font.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/app.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/scroll.css" type="text/css" />
</head>
<body>
<div class="bg-light lter b-b wrapper-md">
    <h1 class="m-n font-thin h3">我的关注</h1>
</div>
<div class="wrapper-md">
    <div class="row">
        <c:forEach items="${follows}" var="follow">
            <div class="col-lg-4">
                <div class="panel panel-default">
                    <li class="list-group-item">
                        <a herf class="pull-left thumb-sm avatar m-r">
                            <img src="gethead?id=${follow.followuserid}" alt="..." class="img-circle">
                        </a>
                        <div class="clear">
                            <div><a onclick="window.parent.location.href='ucenterotherhome?id=${follow.followuserid}'">${follow.followusername}</a></div>
                            <small class="text-muted"><c:if test="${empty follow.followdescription}">暂无描述</c:if><c:if test="${!empty follow.followdescription}">${follow.followdescription}</c:if></small>
                        </div>
                        <div class="pull-right thumb-btn avatar m-r" style="top: -30px;">
                            <a class="btn btn-sm btn-warning btn-rounded" onclick="unfollowTA('${follow.followuserid}')">取消关注</a>
                        </div>
                    </li>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<a href="#top" id="scroll-top"></a>

<script src="<%=basePath%>ucenter/js/jquery/jquery.min.js"></script>
<script src="<%=basePath%>ucenter/js/jquery/bootstrap.js"></script>
<script src="<%=basePath%>ucenter/js/scroll.js"></script>
<script src="<%=basePath%>js/my.js"></script>
<script>
    // 取消关注
    function unfollowTA(id) {
        if(!confirm("确认取消关注吗？")){
            return;
        }
        $.ajax({
            url:"ucenterfollowdel",
            data:"id="+id,
            dataType:"json",
            type:"post",
            success:function(data) {
                if(data.status == "ok") {
                    window.location.href='ucenterfollowing?id=${user.id}';
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }
</script>
</body>
</html>
