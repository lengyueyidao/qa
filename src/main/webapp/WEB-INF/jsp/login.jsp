<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>登录</title>
		<link rel="shortcut icon" href="<%=basePath%>images/logo.png" type="image/x-icon" >
		<link rel="stylesheet" href="./login/css/reset.css">
		<link rel="stylesheet" href="./login/css/common.css">
	</head>
	<body>
		<div class="wrap login_wrap">
			<div class="content">
				<div class="logo"></div>
				<div class="login_box">
					<div class="login_form">
						<div class="login_title">
							登录
						</div>
						<form id="loginform" action="" method="post">
							
							<div class="form_text_ipt" style="box-shadow: none;">
								<input name="usercode" type="text" placeholder="帐号">
							</div>
							<div class="form_text_ipt" style="box-shadow: none;">
								<input name="password" type="password" placeholder="密码">
							</div>
							<div class="form_btn">
								<button type="button" id="loginbtn">登录</button>

							</div>
							<div class="form_reg_btn">
								<span>还没有帐号？</span><a href="register">马上注册</a>
							</div>
						</form>
						<br />
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript" src="./login/js/jquery.min.js"></script>
		<script type="text/javascript" src="./login/js/common.js"></script>
	</body>
</html>