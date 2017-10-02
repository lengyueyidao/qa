<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>${u.username}的主页</title>
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
<body style="z-index: -1; height: 100%" >

<div class="app app-header-fixed" id="app">
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

    <a href class="off-screen-toggle hide" data-toggle="class:off-screen" data-target=".app-aside" ></a>
    <div class="app-content-body fade-in-up">
        <div class="hbox hbox-auto-xs hbox-auto-sm">
            <div class="col">
                <div style="background:url(ucenter/img/c4.jpg) center center; background-size:cover">
                    <div class="wrapper-lg bg-white-opacity">
                        <div class="row m-t">
                            <div class="col-sm-7">
                                <a href class="thumb-lg pull-left m-r">
                                    <img src="gethead?id=${u.id}" class="img-circle">
                                </a>
                                <div class="clear m-b">
                                    <div class="m-b m-t-sm">
                                        <span class="h3 text-black">${u.username}</span>
                                        <small class="m-l">${u.description}</small><br>
                                    </div>
                                    <c:if test="${isFollowed == 0}">
                                        <a onclick="followTA('${u.id}')" class="btn btn-sm btn-success btn-rounded">关注TA</a>
                                    </c:if>
                                    <c:if test="${isFollowed == 1}">
                                        <a onclick="unfollowTA('${u.id}')" class="btn btn-sm btn-warning btn-rounded">取消关注</a>
                                    </c:if>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <div class="pull-right pull-none-xs text-center">
                                    <a href="ucenterfollowed?id=${u.id}" class="m-b-md inline m">
                                        <span class="h3 block font-bold">${followedCount}</span>
                                        <small>被关注</small>
                                    </a>
                                    <a href="ucenterfollowing?id=${u.id}" class="m-b-md inline m">
                                        <span class="h3 block font-bold">${followingCount}</span>
                                        <small>TA的关注</small>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="wrapper bg-white b-b">
                    <ul class="nav nav-pills nav-sm">
                        <li class="active"><a href="ucenterotherhome?id=${u.id}">动态</a></li>
                        <%--<li><a href>说说</a></li>--%>
                        <%--<li><a href>日志</a></li>--%>
                    </ul>
                </div>
                <div class="padder">
                    <div class="streamline b-l b-info m-l-lg m-b padder-v" id="dycon">
                        <c:forEach items="${dynamics}" var="dy">
                            <div>
                                <a class="pull-left thumb-sm avatar m-l-n-md">
                                    <img src="gethead?id=${u.id}" alt="...">
                                </a>
                                <div class="m-l-lg m-b-lg panel b-a bg-light lt">
                                    <div class="panel-heading pos-rlt b-light">
                                        <span class="arrow arrow-light left"></span>
                                            By TA
                                        <span class="text-muted m-l-sm pull-right">
                                            ${dy.date}
                                        </span>
                                    </div>
                                    <div class="panel-body">
                                        <div>提问：<a onclick="window.parent.location.href='question?id=${dy.id}'"> ${dy.title}</a></div>
                                        <div><small>${dy.content}</small></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div align="center" id="chakan">
                        <c:if test="${page.totalCount == 0}">
                            暂无动态
                        </c:if>
                        <c:if test="${page.totalCount <= page.pageSize and page.totalCount > 0}">
                            已加载所有动态
                        </c:if>
                        <c:if test="${page.totalCount > page.pageSize}">
                            <a onclick="loadData()">加载更多</a>
                        </c:if>

                    </div>
                </div>
            </div>
            <div class="col w-lg bg-light lter b-l bg-auto">
                <div class="wrapper">
                    <div class="">
                        <h4 class="m-t-xs m-b-xs">谁关注了TA？</h4>
                        <ul class="list-group no-bg no-borders pull-in">
                            <c:if test="${fn:length(follows) == 0}">
                                <li class="list-group-item">
                                    <div class="clear">
                                        <span class="text-muted">&nbsp;当前没有任何人关注TA</span>
                                    </div>
                                </li>
                            </c:if>
                            <c:if test="${fn:length(follows) > 0}">
                                <c:forEach items="${follows}" var="follow" begin="0" end="4">
                                    <li class="list-group-item">
                                        <a herf class="pull-left thumb-sm avatar m-r">
                                            <img src="gethead?id=${follow.userid}" alt="..." class="img-circle">
                                        </a>
                                        <div class="clear">
                                            <div><a onclick="window.parent.location.href='ucenterotherhome?id=${follow.userid}'">${follow.username}</a></div>
                                            <small class="text-muted"><c:if test="${empty follow.description}">暂无描述</c:if><c:if test="${!empty follow.description}">${follow.description}</c:if></small>
                                        </div>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                    <div class="panel b-a">
                        <h4 class="font-thin padder">最新问题</h4>
                        <ul class="list-group">
                            <c:forEach items="${questions}" var="question">
                                <li class="list-group-item">
                                    <p><a href="ucenterotherhome?id=${question.userid}" class="text-info">${question.username}</a>发布了<a onclick="window.parent.location.href='question?id=${question.id}'" class="text-info">${question.title}</a></p>
                                    <small class="block text-muted"><i class="fa fa-fw fa-clock-o"></i> ${question.date}</small>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<a href="#top" id="scroll-top"></a>

<script src="<%=basePath%>ucenter/js/jquery/jquery.min.js"></script>
<script src="<%=basePath%>ucenter/js/jquery/bootstrap.js"></script>
<script src="<%=basePath%>ucenter/js/scroll.js"></script>
<script src="<%=basePath%>js/my.js"></script>
<script>
    // 关注
    function followTA(id) {
        $.ajax({
            url:"ucenterfollowadd",
            data:"id="+id,
            dataType:"json",
            type:"post",
            success:function(data) {
                if(data.status == "ok") {
                    window.location.href='ucenterotherhome?id=${u.id}';
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }
    // 取消关注
    function unfollowTA(id) {
        $.ajax({
            url:"ucenterfollowdel",
            data:"id="+id,
            dataType:"json",
            type:"post",
            success:function(data) {
                if(data.status == "ok") {
                    window.location.href='ucenterotherhome?id=${u.id}';
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }
</script>
<script>
    // 加载数据
    var totalheight = 0;
    var pageNow = 1;
    var totalPage = ${page.totalPageCount};
    function loadData(){
        totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop());
        if (pageNow < totalPage) {
            /*这里使用Ajax加载更多内容*/
            var container = $("#dycon"); // 加载容器
            $.ajax({
                type: "POST",
                url: "ucenterloadotherdynamics",
                data: {pageNow:pageNow+1, id:${u.id}},
                dataType: "json",
                beforeSend: function () {
                    $('#chakan').html("正在加载中...");
                },
                success : function(data) {
                    pageNow = data.obj.pageNow;
                    var html = "";
                    for(var i = 0; i < data.list.length; i++) {
                        var d = data.list[i];
                        html += "<div>"+
                                "   <a class=\"pull-left thumb-sm avatar m-l-n-md\">"+
                                "      <img src=\"ucenter/img/a9.jpg\" class=\"img-circle\" alt=\"...\">"+
                                "   </a>"+
                                "   <div class=\"m-l-lg m-b-lg panel b-a bg-light lt\">"+
                                "       <div class=\"panel-heading pos-rlt b-light\">"+
                                "           <span class=\"arrow arrow-light left\"></span>"+
                                "               By TA"+
                                "           <span class=\"text-muted m-l-sm pull-right\">"+
                                "           "+ d.date +
                                "           </span>"+
                                "       </div>"+
                                "       <div class=\"panel-body\">"+
                                "           <div>提问：<a onclick='window.parent.location.href=\"question?id="+ d.id+"\"'>"+ d.title+"</a></div>"+
                                "           <div><small>"+ d.content+"</small></div>"+
                                "       </div>"+
                                "   </div>"+
                                "</div>";
                    }
                    container.append(html);
                    $('#chakan').html("<a onclick=\"loadData()\">加载更多</a>");
                    if(pageNow == totalPage) {
                        $('#chakan').html("已加载所有动态");
                    }
                }
            });
        }
    }

</script>
</body>
</html>
