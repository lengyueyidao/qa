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
						<a href="index"  title="欢迎来到IT技术问答社区">
							<img src="images/logo_title.png" alt="Knowledge Base Theme">
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
												<li><a href="#">个人信息</a></li>
												<li><a href="#" id="logoutbtn"><span>退出登录</span></a></li>
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
