<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>注册</title>
		<link rel="shortcut icon" href="<%=basePath%>images/logo.png" type="image/x-icon" >
		<link rel="stylesheet" href="login/css/reset.css" />
		<link rel="stylesheet" href="login/css/common.css" />
	</head>
	<body>
		<div class="wrap login_wrap">
			<div class="content">
				<div class="logo"></div>
				<div class="login_box">
					<div class="login_form">
						<div class="login_title">
							注册
						</div>
						<form id="registerform" action="login" method="post">
							<div class="form_text_ipt">
								<input name="usercode" type="text" placeholder="帐号">
							</div>
							<div class="form_text_ipt">
								<input name="username" type="text" placeholder="昵称">
							</div>
							<div class="form_text_ipt">
								<input id="password" name="password" type="password" placeholder="密码">
							</div>
							<div class="form_text_ipt">
								<input id="repassword" name="repassword" type="password" placeholder="重复密码">
							</div>
							<div class="form_btn">
								<button type="button" id="registerbtn">注册</button>
							</div>
							<div class="form_reg_btn">
								<span>已有帐号？</span><a href="login">马上登录</a>
							</div>
							<br>
						</form>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript" src="login/js/jquery.min.js" ></script>
		<script type="text/javascript" src="login/js/common.js" ></script>
	</body>
</html>
