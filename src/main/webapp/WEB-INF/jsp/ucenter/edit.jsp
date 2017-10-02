<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>我要提问</title>
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
        <input id="id" name="id" type="hidden" value="${question.id}"/>
        <label for="title">标题</label>
        <input type="text" id="title" name="title" style="width: 50%;height: 30px" value="${question.title}"/>
        <label for="content">内容</label>
        <div id="test-editormd" style="z-index: 2;">
            <textarea name="content" id="content">${question.content}</textarea>
        </div>
        <label for="tags">标签</label>
        <input type="text" id="tags" name="tags" value="${tags}" style="width: 50%;height: 30px" placeholder="每个标签之间用;隔开"/>
        <div>
            <button class="btn" onclick="sub()">提交问题</button>
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

    // 加载markdown编辑器
    $(function() {
        testEditor = editormd("test-editormd", {
            width   : "100%",
            height  : 250,
            syncScrolling : "single",
            path    : "markdown/lib/",
            watch   : false
        });
    });

    // 提交修改后的问题
    function sub() {
        $.ajax({
            url:"ucenterquestionupd",
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
