<%@page import="java.net.URLDecoder"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<title>上传头像</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/css.css" />
<script src="<%=basePath%>/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath%>/js/userhead.js"></script>
</head>
<body>
<div class="xgtx">
	<table cellspacing="0" class="xgtx_tb">
		<tr>
			<td colspan="2" valign="middle" class="td2" style="padding-top: 10px;">仅支持jpg、gif、png格式的图片，且图片小于5MB</td>
		</tr>
		<form action="<%=path%>/photo/upload.do" name="imgForm1" id="imgForm1" enctype="multipart/form-data" method="POST">
		<input type="hidden" name="id" id="id" value="${user.id}"/>
		<tr>
			<td width="508" height="49" valign="middle">
				<input name="filepath" id="filepath" type="text" class="input3" readonly="readonly" style="float: left"/>
				<div style="float: right" align="left" class="btn3" onmouseover="style.backgroundImage= 'url(js/images/btn3_2.gif)';" onmouseout= "style.backgroundImage='url(js/images/btn3_1.gif)';" onmousedown= "style.backgroundImage='url(js/images/btn3_3.gif)';"></div>
				<input type="file" name="file" class="file" id="file" onchange="submitPhoto(this);"  style="width: 500px;height: 49px"/>
			</td>
			
		</tr>
		</form>
		<tr>
			<td colspan="2" valign="middle" class="td2">已经选择图片：<lable id="fliepaths"></lable></td>
		</tr>
		<tr>
			<td colspan="2" valign="middle">
				<table cellspacing="0" style="width: 100%; height: 100%;font-size:12px;">
					<tr>
						<td width="65%" rowspan="2">
							<div class="xgtx_img">
								<br />
								<br />
								<br />
								<br />
								<br />
								<br />
								<br />
								<br /> <span style="margin: 0 auto auto 70px; color: #999999;font-size:12px;">点击浏览从电脑选择一张图片</span>
							</div>
						</td>
						<td width="35%" height="114">
						<form action="grzx/photo.do?method=saveImg" name="imgForm" id="saveform" method="POST">
						<input type="hidden" name="userid" id="userid" value="${user.id}>"/>
						<input type="hidden" name="imgName" id="imgName" /> 
						<label><input type="hidden" size="4" id="x" name="x" /></label>
						<label><input type="hidden" size="4" id="y" name="y" /></label>
						<label><input type="hidden" size="4" id="x2" name="x2" /></label>
						<label><input type="hidden" size="4" id="y2" name="y2" /></label>
						<label><input type="hidden" size="4" id="w" name="w" /></label>
						<label><input type="hidden" size="4" id="h" name="h" /></label>
							<div class="photo" style="margin-left: 50px;">
								<br />
								<br /> <span
									style="margin: 0px auto auto 10px; color: #999999;font-size:12px;">没有预览</span>
							</div>
						</form>
						</td>
					</tr>
					<tr>
						<td align="center" valign="top">头像预览</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="height: 10px; background: url(images/line.gif) repeat-x center center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" style="height: 50px;"><table width="224" align="center">
		<tr>
						<td><div class="btn" onclick="save();" onmouseover="style.backgroundImage= 'url(js/images/btn2.gif)';"onmouseout= "style.backgroundImage='url(js/images/btn1.gif)';"onmousedown= "style.backgroundImage='url(js/images/btn3.gif)';"></div></td>
						<td><div class="btn2" onclick="exitSave();" onmouseover="style.backgroundImage= 'url(js/images/btn2_2.gif)';"onmouseout= "style.backgroundImage='url(js/images/btn2_1.gif)';"onmousedown= "style.backgroundImage='url(js/images/btn2_3.gif)';"></div></td>
					</tr>
				</table></td>
		</tr>
	</table>
</div>
</body>
</html>