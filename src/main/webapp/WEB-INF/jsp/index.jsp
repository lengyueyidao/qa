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
								<li class="current-menu-item">
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
                    <input class="search-term" type="text" id="q" name="q" value="${q}" placeholder="在这儿输入你要查找的问题" title="* 请输入你要查找的内容！" />
                    <input class="search-btn" type="submit" value="Search" />
                </form>
            </div>
        </div>
       	
		<div class="page-container">
			<div class="container">
				<div class="row">
					<div class="span8 main-listing">
						<c:if test="${fn:length(questions) == 0}">
							<h1>未搜索到任何结果！</h1>
						</c:if>
						<c:forEach items="${questions}" var="question">

							<article class="format-standard type-post hentry clearfix">
								<header class="clearfix">
									<h3 class="post-title">
										<c:set var="string1" value="${fn:escapeXml(question.title)}"/>
										<c:forEach items="${qList}" var="ql">
											<c:if test="${fn:containsIgnoreCase(string1, ql)}">
												<c:set var="lowstring" value="${fn:toLowerCase(string1)}"/>
												<c:set var="st" value="${fn:indexOf(lowstring, ql)}"/>
												<c:set var="len" value="${fn:length(ql)}"/>
												<c:set var="nql" value="${fn:substring(string1, st, st+len)}"/>
												<c:set var="string2" value="<font color='red'>${nql}</font>"/>
												<c:set var="string1" value="${fn:replace(string1, nql, string2)}"/>
											</c:if>
										</c:forEach>
										<a href="question?id=${question.id}">${string1}</a>
									</h3>
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
										<span class="comments"><a href="#">${question.answers} Answers</a></span>
										<span class="author"><a href="ucenterotherhome?id=${question.userid}">${question.username}</a></span>
										<span class="eye">${question.views}</span>
									</div>
								</header>
								<p>

									<c:set var="string1" value="${fn:escapeXml(question.content)}"/>
									<c:if test="${fn:length(string1) > 100}">
										<c:set var="string1" value="${fn:substring(string1, 0, 100)} ..."/>
									</c:if>
									<c:forEach items="${qList}" var="ql">
										<c:if test="${fn:containsIgnoreCase(string1, ql)}">
											<c:set var="lowstring" value="${fn:toLowerCase(string1)}"/>
											<c:set var="st" value="${fn:indexOf(lowstring, ql)}"/>
											<c:set var="len" value="${fn:length(ql)}"/>
											<c:set var="nql" value="${fn:substring(string1, st, st+len)}"/>
											<c:set var="string2" value="<font color='red'>${nql}</font>"/>
											<c:set var="string1" value="${fn:replace(string1, nql, string2)}"/>
										</c:if>
									</c:forEach>
									${string1}
								</p>
								<a class="more" href="question?id=${question.id}">查看更多</a>
							</article>
						</c:forEach>
						
						<%--<div id="pagination">
							<a href="#"class="btn active">1</a>
							<a href="#"class="btn">2</a>
							<a href="#"class="btn">3</a>
							<a href="#"class="btn">Next »</a>
							<a href="#"class="btn">Last »</a>
						</div>--%>

						<div id="pagination">
							<c:choose>
								<c:when test="${page.totalCount!=0}">
									<c:choose>
										<c:when test="${page.hasFirst}">
											<a class="btn" href="index?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=1" >首页</a>
										</c:when>
									</c:choose>

									<c:choose>
										<c:when test="${page.hasPre}">
											<a class="btn" href="index?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow-1}">上一页</a>
										</c:when>
									</c:choose>

									<c:forEach var="i" begin="${(page.pageNow-1)<=0?1:((page.pageNow+2)>page.totalPageCount?((page.pageNow-2)<=0?1:page.pageNow-2):(page.pageNow-2)<=0?1:page.pageNow-2)}" end="${(page.pageNow-1)<=0?((page.pageNow+2)>page.totalPageCount?page.totalPageCount:page.pageNow+2):((page.pageNow+2)>page.totalPageCount?page.totalPageCount:((page.pageNow+2)>page.totalPageCount)?page.totalPageCount:(page.pageNow+2))}" step="1">
										<c:choose>
											<c:when test="${page.pageNow==i}">
												<a class="btn active">${i}</a>
											</c:when>
											<c:otherwise>
												<a class="btn" href="index?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${i}">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>

									<c:choose>
										<c:when test="${page.hasNext}">
											<a class="btn" href="index?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow+1}">下一页</a>
										</c:when>
									</c:choose>

									<c:choose>
										<c:when test="${page.hasLast}">
											<a class="btn" href="index?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.totalPageCount}">尾页</a>
										</c:when>
									</c:choose>

									第<c:out value="${page.pageNow}"/>页/共<c:out value="${page.totalPageCount}"/>页（<c:out value="${page.totalCount}"/>条）
								</c:when>
							</c:choose>
						</div>
						
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
									<!--由ajax从后台读取数据-->
								</ul>
                            </div>
                        </section>
                        <section class="widget" style="padding: 0px 0px 50px 0px">
                            <h3 class="title">Tags</h3>
                            <div class="tagcloud" id="tagcloud">
								<!--由ajax从后台读取数据-->
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

</html>
