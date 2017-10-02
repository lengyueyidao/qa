<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>IT技术问答社区</title>
        <link rel="shortcut icon" href="<%=basePath%>images/logo.png" type="image/x-icon" >
		<link rel="stylesheet" href="<%=basePath%>css/style.css"/>
        <link rel='stylesheet' id='bootstrap-css-css'  href='<%=basePath%>css/bootstrap5152.css?ver=1.0' type='text/css' media='all' />
        <link rel='stylesheet' id='responsive-css-css'  href='<%=basePath%>css/responsive5152.css?ver=1.0' type='text/css' media='all' />
        <link rel='stylesheet' id='pretty-photo-css-css'  href='<%=basePath%>js/prettyphoto/prettyPhotoaeb9.css?ver=3.1.4' type='text/css' media='all' />
        <link rel='stylesheet' id='main-css-css'  href='<%=basePath%>css/main5152.css?ver=1.0' type='text/css' media='all' />
        <link rel='stylesheet' id='custom-css-css'  href='<%=basePath%>css/custom5152.html?ver=1.0' type='text/css' media='all' />
		<link rel="stylesheet" href="css/my.css"/>
		<link rel="stylesheet" href="markdown/css/editormd.min.css"/>
    </head>
	<body style="background-color: #F5F5D5;">

		<div class="header-wrapper">
			<header>

				<div class="container">
					<div class="logo-container">
                        <img src="images/logo.png" style="width: 25px; height:25px">
                        <a href="index"  title="欢迎来到IT技术问答社区">
                            <img src="images/logo-title.png">
                        </a>
                        <span class="tag-line">你我互相问答，这是最美好的交流方式！</span>
					</div>

					<nav class="main-nav">
						<div class="menu-top-menu-container">
							<ul id="menu-top-menu" class="clearfix">
								<li>
									<a href="index" style="font-size: 14px;font-weight: bold;">全部问答</a>
								</li>
								<li>
									<a href="wait" style="font-size: 14px;font-weight: bold;">待回答</a>
								</li>
								<li>
									<a href="solve" style="font-size: 14px;font-weight: bold;">已解决</a>
								</li>
								<li>
									<a href="tags" style="font-size: 14px;font-weight: bold;">标签</a>
								</li>
								<c:choose>
									<c:when test="${user != null}">
										<li>
											<a href="#" style="font-size: 14px;font-weight: bold;">${user.username}</a>
											<ul class="sub-menu">
                                                <li id="ucenter"><a><span>我的主页</span></a></li>
                                                <li id="logoutbtn"><a><span>退出登录</span></a></li>
											</ul>
										</li>
									</c:when>
									<c:otherwise>
										<li style="padding: 0px 0px 0px 14px;">
											<a href="register" style="font-size: 14px;font-weight: bold;">注册</a>
										</li>
										/
										<li style="padding: 0px;">
											<a href="login" style="font-size: 14px;font-weight: bold;">登录</a>
										</li>
									</c:otherwise>
								</c:choose>

							</ul>
						</div>
					</nav>
				</div>
			</header>
		</div>


		<div class="search-area-wrapper">
            <div class="search-area container">
                <h3 class="search-header">遇到了问题？</h3>
                <p class="search-tag-line">如果你有任何问题，都可以在下方进行查找哦！</p>
                <form id="search-form" class="search-form clearfix" method="get" action="index" autocomplete="off">
                    <input class="search-term" type="text" id="q" name="q" placeholder="在这儿输入你要查找的问题" title="* 请输入你要查找的内容！" />
                    <input class="search-btn" type="submit" value="Search" />
                </form>
            </div>
        </div>

		<div class="page-container">
			<div class="container">
				<div class="row">
                    <div class="span8 page-content">
                        <article class=" type-post format-standard hentry clearfix">
                            <h1 class="post-title"><a href="#">${fn:escapeXml(question.title)}</a></h1>
                            <div class="post-meta clearfix">
                                <span class="date">${question.date}</span>
                                <span class="category">
                                    <c:forEach items="${question.tags}" var="tag" varStatus="i">
                                        <c:if test="${i.index == 0}">
                                            <a href="questiontag?tagid=${tag.id}">${tag.name}</a>
                                        </c:if>
                                        <c:if test="${i.index != 0}">
                                            ，<a href="questiontag?tagid=${tag.id}">${tag.name}</a>
                                        </c:if>
                                    </c:forEach>
                                </span>
                                <span class="comments">${question.answers} Answers</span>
                                <span class="author"><a href="ucenterotherhome?id=${question.userid}">${question.username}</a></span>
                                <span class="eye">${question.views}</span>
                            </div>


                            <p>
                                ${question.content}
                            </p>


                        </article>
                        <section id="comments">
                        <c:if test="${!empty answers}">
                            <h3 id="comments-title">${question.answers}个回答</h3>
                            <ol class="commentlist">
                                <c:forEach items="${answers}" var="answer">
                                    <li class="comment even thread-even depth-1">

                                        <article>
                                            <a href="#">
                                                <img alt="" src="gethead?id=${answer.userid}" class="avatar avatar-60 photo" height="60" width="60">
                                            </a>
                                            <div class="comment-meta">
                                                <h5 class="author">
                                                    <cite class="fn">
                                                        <a href="#" rel="external nofollow" class="url">${answer.username}</a>
                                                    </cite>

                                                    <c:if test="${answer.userid != user.id}">
                                                        - <a class="comment-reply-link" onclick="reply('${answer.id}', '${question.id}', '${answer.username}')">回复</a>
                                                    </c:if>
                                                    <c:if test="${answer.userid == user.id}">
                                                        - <a class="comment-reply-link" onclick="del('${answer.id}')">删除</a>
                                                    </c:if>
                                                </h5>
                                                <p class="date">
                                                    <a href="#">
                                                        <time datetime="2013-02-26T13:18:47+00:00">${answer.date}</time>
                                                    </a>
                                                </p>
                                            </div>
                                            <div class="comment-body">
                                                ${answer.content}
                                            </div>
                                            <div id="reply${answer.id}"></div>
                                        </article>
                                        <c:forEach items="${answer.childs}" var="child">
                                            <ul class="children">
                                                <li class="comment byuser comment-author-saqib-sarwar bypostauthor odd alt depth-2" >
                                                    <article>
                                                        <a href="#">
                                                            <img alt="" src="gethead?id=${child.userid}" class="avatar avatar-60 photo" height="60" width="60">
                                                        </a>
                                                        <div class="comment-meta">
                                                            <h5 class="author">
                                                                <cite class="fn">${child.username}</cite>
                                                                <c:if test="${child.userid != user.id}">
                                                                    - <a class="comment-reply-link" onclick="reply('${child.id}', '${question.id}', '${child.username}')">回复</a>
                                                                </c:if>
                                                                <c:if test="${child.userid == user.id}">
                                                                    - <a class="comment-reply-link" onclick="del('${child.id}')">删除</a>
                                                                </c:if>
                                                            </h5>
                                                            <p class="date">
                                                                <a href="#">
                                                                    <time datetime="2013-02-26T13:20:14+00:00">${child.date}</time>
                                                                </a>

                                                                <c:if test="${child.parentname != null}">
                                                                    &nbsp;RE:${child.parentname}
                                                                </c:if>

                                                            </p>
                                                        </div>
                                                        <div class="comment-body">
                                                            ${child.content}
                                                        </div>
                                                        <div id="reply${child.id}"></div>
                                                    </article>
                                                </li>
                                            </ul>
                                        </c:forEach>
                                    </li>
                                </c:forEach>
                            </ol>
                        </c:if>
                            <div method="post" id="commentform" style="padding-top: 15px">


                                <div id="test-editormd" style="z-index: 2;">
                                    <textarea name="comment" id="comment"  ></textarea>
                                </div>


                                <div>
                                    <%--<input class="btn" name="submit" type="submit" id="submit" value="我来回答">--%>
                                    <button class="btn" id="sb" onclick="answer(null, '${question.id}', 0)">我来回答</button>
                                </div>

                            </div>
                        </section><!-- end of comments -->

                    </div>

					<aside class="span4 page-sidebar">
						<section class="widget">
							<div class="quick-links-widget">
								<h3 class="title">最新公告</h3>
                                <p>
                                    ${notice.content}
                                </p>
                                <p align="right">${notice.updatetime}</p>
                            </div>
                        </section>
						<section class="widget" style="padding: 10px 0 0 0">
							<div class="quick-links-widget">
	                            <h3 class="title">最新回答</h3>
	                            <ul id="recentcomments">
                                    <!-- 由ajax从后台读取数据 -->
	                            </ul>
                            </div>
                        </section>
                        <section class="widget" style="padding: 0px 0px 50px 0px">
                            <h3 class="title">Tags</h3>
                            <div class="tagcloud" id="tagcloud">
                                <!-- 由ajax从后台读取数据 -->
                            </div>
                        </section>
					</aside>

				</div>

			</div>

		</div>



		<a href="#top" id="scroll-top"></a>
	</body>


	<!-- script -->
    <script type='text/javascript' src='<%=basePath%>js/jquery-1.8.3.min.js'></script>
    <script type='text/javascript' src='<%=basePath%>js/jquery.easing.1.34e44.js?ver=1.3'></script>
    <script type='text/javascript' src='<%=basePath%>js/prettyphoto/jquery.prettyPhotoaeb9.js?ver=3.1.4'></script>
    <!--<script type='text/javascript' src='js/jquery.liveSearchd5f7.js?ver=2.0'></script>-->
	<script type='text/javascript' src='<%=basePath%>js/jflickrfeed.js'></script>
    <script type='text/javascript' src='<%=basePath%>js/jquery.formd471.js?ver=3.18'></script>
    <script type='text/javascript' src='<%=basePath%>js/jquery.validate.minfc6b.js?ver=1.10.0'></script>
    <script type='text/javascript' src='<%=basePath%>js/custom5152.js?ver=1.0'></script>
	<script type='text/javascript' src='<%=basePath%>js/my.js'></script>
	<script type='text/javascript' src='<%=basePath%>markdown/editormd.js'></script>
    <script type="text/javascript" src="<%=basePath%>js/markdown.min.js"></script>
    <script type="text/javascript">
        var testEditor;

        $(function() {
            testEditor = editormd("test-editormd", {
                width   : "100%",
                height  : 250,
                syncScrolling : "single",
                path    : "markdown/lib/",
                watch   : false
            });
        });

        function reply(id, qid, name) {
            if($('#reply'+id).html().length > 3) {
                $('#reply'+id).html("");
                return;
            }
            $('#reply'+id).html("<input style='width: 75%' type='text' name='content' id='content"+id+"' placeholder='回复"+name+":'/><input class='btn' style='margin:0px 5px 14px;' type='button' name='reply' onclick='answer(\""+id+"\", \""+qid+"\", 1)' value='回复'/><input class='btn' style='margin:0px 5px 14px;' type='button' value='取消' onclick='cancelReply(\""+id+"\")'/> ");
        }

        function cancelReply(id) {
            $('#reply'+id).html("");
        }

        function del(id) {
            if(!confirm("你确认要删除该条回答嘛？")) {
                return;
            }
            $.ajax({
                url:"deleteanswer",
                data:"id="+id,
                dataType:"json",
                success: function(data) {
                    if(data.status == "ok") {
                        alert(data.msg);
                        window.location.href="question?id=${question.id}";
                    }
                    else {
                        alert(data.msg);
                    }
                }
            });
        }


        function answer(id, qid, flag) {
            var content;
            if(flag == 0) {
                content = $('#comment').val();
            }
            if(flag == 1) {
                content = $('#content'+id).val();
            }

            if(content == "") {
                alert("回复内容不能为空！");
                return;
            }
            $.ajax({
                url:"replyanswer",
                data:"pid="+id+"&qid="+qid+"&content="+content,
                type:"post",
                dataType:"json",
                success: function(data) {
                    if(data.status == "ok") {
                        alert(data.msg);
                        window.location.href="question?id=${question.id}";
                    }
                    else {
                        alert(data.msg);
                    }
                }
            });
        }
    </script>

</html>
