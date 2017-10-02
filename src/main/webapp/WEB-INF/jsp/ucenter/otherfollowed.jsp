<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>TA被关注</title>
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
<div class="app-header navbar">
    <div class="navbar-header bg-white-opacity">
        <a href="index" class="navbar-brand text-lt">
            <i class="fa fa-weixin"></i>
            <img src="ucenter/img/logo.png" alt="." class="hide">
            <span class="hidden-folded m-l-xs">IT技术问答</span>
        </a>
    </div>
    <div class="collapse pos-rlt navbar-collapse bg-white-opacity">
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" data-toggle="dropdown" class="dropdown-toggle">
                    <i class="icon-bell fa-fw"></i>
                    <span class="visible-xs-inline">消息</span>
                    <span class="badge badge-sm up bg-danger pull-right-xs">${fn:length(answers)}</span>
                </a>
                <div class="dropdown-menu w-xl animated fadeInUp">
                    <div class="panel bg-white">
                        <div class="panel-heading b-light bg-light">
                            <c:if test="${fn:length(answers) == 0}">
                                <strong>暂无消息</strong>
                            </c:if>
                            <c:if test="${fn:length(answers) > 0}">
                                <strong>你有<span>${fn:length(answers)}</span>条消息</strong>
                            </c:if>
                        </div>
                        <div class="list-group">
                            <c:forEach items="${answers}" var="answer">
                                <a href="question?id=${answer.questionid}" class="media list-group-item">
                                <span class="pull-left thumb-sm">
                                    <img src="gethead?id=${answer.userid}" alt="..." class="img-circle">
                                </span>
                                <span class="media-body block m-b-none">
                                    ${answer.username}回复了你。。。<br>
                                    <small class="text-muted">${answer.date}</small>
                                </span>
                                </a>
                            </c:forEach>

                        </div>

                    </div>
                </div>
            </li>
            <li class="dropdown">
                <a href="#" data-toggle="dropdown" class="dropdown-toggle clear" data-toggle="dropdown">
                        <span class="thumb-sm avatar pull-right m-t-n-sm m-b-n-sm m-l-sm">
                            <img src="gethead?id=${user.id}" alt="...">
                            <i class="on md b-white bottom"></i>
                        </span>
                    <span class="hidden-sm hidden-md">${user.username}</span> <b class="caret"></b>
                </a>
                <ul class="dropdown-menu animated fadeInRight w">

                    <li>
                        <a href="ucenter">
                            <span>My Home</span>
                        </a>
                    </li>

                    <li class="divider"></li>
                    <li>
                        <a href="#" id="logoutbtn">Logout</a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</div>
<div class="bg-light lter b-b wrapper-md">
    <h1 class="m-n font-thin h3">TA被关注</h1>
</div>
<div class="wrapper-md">
    <div class="row">
        <c:forEach items="${follows}" var="follow">
            <div class="col-lg-4">
                <div class="panel panel-default">
                    <li class="list-group-item">
                        <a herf class="pull-left thumb-sm avatar m-r">
                            <img src="gethead?id=${follow.userid}" alt="..." class="img-circle">
                        </a>
                        <div class="clear">
                            <div><a onclick="window.parent.location.href='ucenterotherhome?id=${follow.userid}'">${follow.username}</a></div>
                            <small class="text-muted"><c:if test="${empty follow.description}">暂无描述</c:if><c:if test="${!empty follow.description}">${follow.description}</c:if></small>
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
</body>
</html>
