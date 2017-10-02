<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>个人信息设置</title>
    <link rel="shortcut icon" href="<%=basePath%>images/logo.png" type="image/x-icon" >
    <link rel="stylesheet" href="<%=basePath%>css/style.css"/>
    <link rel='stylesheet' id='bootstrap-css-css'  href='css/bootstrap5152.css?ver=1.0' type='text/css' media='all' />
    <link rel='stylesheet' id='responsive-css-css'  href='css/responsive5152.css?ver=1.0' type='text/css' media='all' />
    <link rel='stylesheet' id='pretty-photo-css-css'  href='js/prettyphoto/prettyPhotoaeb9.css?ver=3.1.4' type='text/css' media='all' />
    <link rel='stylesheet' id='main-css-css'  href='css/main5152.css?ver=1.0' type='text/css' media='all' />
    <link rel='stylesheet' id='custom-css-css'  href='css/custom5152.html?ver=1.0' type='text/css' media='all' />
    <link rel="stylesheet" href="markdown/css/editormd.min.css"/>
</head>
<body style="padding: 25px;zoom: 0;" >
    <form id="myform">
        <label for="username">昵称</label>
        <input type="text" id="username" name="username" style="width: 50%;height: 30px"/>
        <label for="sex">性别</label>
        <select id="sex" name="sex">
            <option value="0">男</option>
            <option value="1">女</option>
        </select>
        <label for="address">地址</label>
        <input type="text" id="address" name="address" style="width: 50%;height: 30px"/>
        <label for="description">描述</label>
        <textarea style="width: 50%; height: 150px" id="description" name="description"></textarea>
        <div>
            <button class="btn" onclick="sub()">保存设置</button>
        </div>
    </form>
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
<script type="text/javascript">
    var testEditor;

    $('#username').val("${user.username}");
    $('#sex').val("${user.sex}");
    $('#address').val("${user.address}");
    $('#description').val("${user.description}");

    // 提交设置
    function sub() {

        if($('#username').val().length > 5) {
            alert("昵称长度不能大于5");
            return;
        }

        $.ajax({
            url:"ucenterconfigupd",
            type:"post",
            dataType:"json",
            data:$('#myform').serialize(),
            async:false,
            success: function(data) {
                if(data.status == "ok") {
                    alert(data.msg);
                    $('#myform').resetForm();
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }
</script>
</html>
