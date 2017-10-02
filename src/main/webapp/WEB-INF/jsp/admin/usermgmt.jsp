<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>用户管理</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="<%=basePath%>images/logo.png" type="image/x-icon" >
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/custom-styles.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />

</head>
<body>
<div class="row" style="padding-bottom: 50px">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <div style="float:left;">
                    用户列表
                </div>
                <div style="float: right">
                    &nbsp;<button class="btn btn-primary" onclick="showAdd()">新增用户</button>
                </div>
                <div class="input-group" style="width: 220px;float:right;padding-bottom: 10px">
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="button" onclick="search()">
                            Search
                        </button>
                    </span>
                    <input type="text" class="form-control" id="q" name="q" value="${q}">
                </div>

            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-hover" id="dataTables-example">
                        <thead>
                        <tr>
                            <th width="10%" style="text-align:center;">帐号</th>
                            <th width="10%" style="text-align:center;">密码</th>
                            <th width="10%" style="text-align:center;">昵称</th>
                            <th width="5%" style="text-align:center;">性别</th>
                            <th width="10%" style="text-align:center;">地址</th>
                            <th width="20%" style="text-align:center;">描述</th>
                            <th width="10%" style="text-align:center;">注册时间</th>
                            <th width="10%" style="text-align:center;">最近登录</th>
                            <th width="50%" style="text-align:center;">操作</th>

                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty users}">
                            <tr><td colspan="9" align="center">暂无记录</td></tr>
                        </c:if>
                        <c:forEach items="${users}" var="u">
                            <tr>
                                <td style="text-align:center;">${u.usercode}</td>
                                <td style="text-align:center;">${u.password}</td>
                                <td style="text-align:center;">${u.username}</td>
                                <td style="text-align:center;">${u.sex}</td>
                                <td style="text-align:center;">${u.address}</td>
                                <td style="text-align:center;">${u.description}</td>
                                <td style="text-align:center;">${u.registertime}</td>
                                <td style="text-align:center;">${u.lastlogintime}</td>
                                <td style="text-align:center;"><a onclick="showEdit('${u.id}','${u.usercode}','${u.password}','${u.username}','${u.sex}','${u.address}','${u.description}')">编辑</a> | <a onclick="deluser('${u.id}')">删除</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <ul class="pagination">
                        <c:choose>
                            <c:when test="${page.totalCount!=0}">
                                <c:choose>
                                    <c:when test="${page.hasFirst}">
                                        <li><a href="adminuser?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=1" >首页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${page.hasPre}">
                                        <li><a href="adminuser?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow-1}">上一页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:forEach var="i" begin="${(page.pageNow-1)<=0?1:((page.pageNow+2)>page.totalPageCount?((page.pageNow-2)<=0?1:page.pageNow-2):(page.pageNow-2)<=0?1:page.pageNow-2)}" end="${(page.pageNow-1)<=0?((page.pageNow+2)>page.totalPageCount?page.totalPageCount:page.pageNow+2):((page.pageNow+2)>page.totalPageCount?page.totalPageCount:((page.pageNow+2)>page.totalPageCount)?page.totalPageCount:(page.pageNow+2))}" step="1">
                                    <c:choose>
                                        <c:when test="${page.pageNow==i}">
                                            <li class="active"><a >${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="adminuser?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${i}">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <c:choose>
                                    <c:when test="${page.hasNext}">
                                        <li><a href="adminuser?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow+1}">下一页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${page.hasLast}">
                                        <li><a href="adminuser?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.totalPageCount}">尾页</a></li>
                                    </c:when>
                                </c:choose>

                                </c:when>
                        </c:choose>
                    </ul>
                    <span style="position: relative;top: -30px">第<c:out value="${page.pageNow}"/>页/共<c:out value="${page.totalPageCount}"/>页（<c:out value="${page.totalCount}"/>条）</span>
                </div>

            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 50%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    修改用户
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-inline" id="userform">
                    <input type="hidden" id="id" name="id">
                    <div style="margin-top: 10px">
                        <label for="usercode">帐号:</label>
                        <input id="usercode" name="usercode" class="form-control" >
                    </div>
                    <div style="margin-top: 10px">
                        <label for="password">密码:</label>
                        <input id="password" name="password" class="form-control" >
                    </div>
                    <div style="margin-top: 10px">
                        <label for="username">昵称:</label>
                        <input id="username" name="username" class="form-control" >
                    </div>
                    <div style="margin-top: 10px">
                        <label for="sex">性别:</label>
                        <select id="sex" name="sex" class="form-control">
                            <option value="0" selected="selected">男</option>
                            <option value="1">女</option>
                        </select>
                    </div>
                    <div style="margin-top: 10px">
                        <label for="address">地址:</label>
                        <input id="address" name="address" class="form-control" >
                    </div>
                    <div style="margin-top: 10px">
                        <label for="description">描述:</label>
                        <input id="description" name="description" class="form-control" >
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="upd" onclick="upduser()">
                    提交修改
                </button>
                <button type="button" class="btn btn-primary" id="add" onclick="adduser()">
                    提交新增
                </button>
            </div>
        </div>
    </div>
</div>
<script>

    // 搜索
    function search() {
        window.location.href="adminuser?q="+$('#q').val();
    }

    function showAdd() {
        $('#usercode').val("");
        $('#password').val("");
        $('#username').val("");
        $('#sex').val("0");
        $('#address').val("");
        $('#descritpion').val("");
        $('#add').show();
        $('#upd').hide();
        $('#myModalLabel').html("新增用户");
        $('#myModal').modal("show");
    }

    function showEdit(id, usercode, password, username, sex, address, description) {
        $('#id').val(id);
        $('#usercode').val(usercode);
        $('#password').val(password);
        $('#username').val(username);
        $('#sex').val(sex);
        $('#address').val(address);
        $('#description').val(description);
        $('#add').hide();
        $('#upd').show();
        $('#myModalLabel').html("修改用户");
        $('#myModal').modal("show");
    }

    function adduser() {
        var usercode = $('#usercode').val();
        if(usercode == "") {
            alert("帐号不能为空！");
            return;
        }
        var password = $('#password').val();
        if(password == "") {
            alert("密码不能为空！");
            return;
        }
        var username = $('#username').val();
        if(username == "") {
            alert("昵称不能为空！");
            return;
        }
        $.ajax({
            url:"adminuseradd",
            type:"post",
            dataType:"json",
            data:$('#userform').serialize(),
            async:false,
            success: function(data) {
                if(data.status == "ok") {
                    alert(data.msg);
                    $('#userform')[0].reset();
                    $('#myModal').modal('hide');
                    window.location.href="adminuser?q=${q}&pageNow=${page.pageNow}";
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }

    function upduser() {
        var usercode = $('#usercode').val();
        if(usercode == "") {
            alert("帐号不能为空！");
            return;
        }
        var password = $('#password').val();
        if(password == "") {
            alert("密码不能为空！");
            return;
        }
        var username = $('#username').val();
        if(username == "") {
            alert("昵称不能为空！");
            return;
        }
        $.ajax({
            url:"adminuserupdate",
            type:"post",
            dataType:"json",
            data:$('#userform').serialize(),
            async:false,
            success: function(data) {
                if(data.status == "ok") {
                    alert(data.msg);
                    $('#userform')[0].reset();
                    $('#myModal').modal('hide');
                    window.location.href="adminuser?q=${q}&pageNow=${page.pageNow}";
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }

    function deluser(id) {
        if(!confirm("确认删除该用户吗？")){
            return;
        }
        $.ajax({
            url:"adminuserdelete",
            type:"post",
            dataType:"json",
            data:{id:id},
            async:false,
            success: function(data) {
                if(data.status == "ok") {
                    alert(data.msg);
                    $('#userform')[0].reset();
                    $('#myModal').modal('hide');
                    window.location.href="adminuser?q=${q}&pageNow=${page.pageNow}";
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }
</script>

<script src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.metisMenu.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/dataTables/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/dataTables/dataTables.bootstrap.js"></script>
<script>

</script>
</body>
</html>
