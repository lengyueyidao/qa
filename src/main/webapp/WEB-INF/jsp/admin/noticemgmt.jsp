<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>公告管理</title>
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
                    公告列表
                </div>
                <div style="float: right">
                    &nbsp;<button class="btn btn-primary" onclick="showAdd()">新增公告</button>
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
                            <th width="50%">公告内容</th>
                            <th width="15%" style="text-align:center;">创建日期</th>
                            <th width="15%" style="text-align:center;">修改日期</th>
                            <th width="20%" style="text-align:center;">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty notices}">
                            <tr><td colspan="4" align="center">暂无记录</td></tr>
                        </c:if>
                        <c:forEach items="${notices}" var="notice">
                            <tr>
                                <td>${notice.content}</td>
                                <td style="text-align:center;">${notice.createtime}</td>
                                <td style="text-align:center;">${notice.updatetime}</td>
                                <td style="text-align:center;"><a onclick="showEdit('${notice.id}', '${notice.content}')">编辑</a> | <a onclick="delgg('${notice.id}')">删除</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <ul class="pagination">
                        <c:choose>
                            <c:when test="${page.totalCount!=0}">
                                <c:choose>
                                    <c:when test="${page.hasFirst}">
                                        <li><a href="adminnotice?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=1" >首页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${page.hasPre}">
                                        <li><a href="adminnotice?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow-1}">上一页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:forEach var="i" begin="${(page.pageNow-1)<=0?1:((page.pageNow+2)>page.totalPageCount?((page.pageNow-2)<=0?1:page.pageNow-2):(page.pageNow-2)<=0?1:page.pageNow-2)}" end="${(page.pageNow-1)<=0?((page.pageNow+2)>page.totalPageCount?page.totalPageCount:page.pageNow+2):((page.pageNow+2)>page.totalPageCount?page.totalPageCount:((page.pageNow+2)>page.totalPageCount)?page.totalPageCount:(page.pageNow+2))}" step="1">
                                    <c:choose>
                                        <c:when test="${page.pageNow==i}">
                                            <li class="active"><a >${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="adminnotice?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${i}">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <c:choose>
                                    <c:when test="${page.hasNext}">
                                        <li><a href="adminnotice?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow+1}">下一页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${page.hasLast}">
                                        <li><a href="adminnotice?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.totalPageCount}">尾页</a></li>
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
                    修改公告
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-inline" id="ggform">
                    <input type="hidden" id="id" name="id">
                    <div style="margin-top: 0px">
                        <label for="content">公告内容:</label>
                        <textarea id="content" name="content" class="form-control" style="width: 80%" rows="4">
                        </textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="upd" onclick="updgg()">
                    提交修改
                </button>
                <button type="button" class="btn btn-primary" id="add" onclick="addgg()">
                    提交新增
                </button>
            </div>
        </div>
    </div>
</div>
<script>

    // 搜索
    function search() {
        window.location.href="adminnotice?q="+$('#q').val();
    }

    function showAdd() {
        $('#content').val("");
        $('#add').show();
        $('#upd').hide();
        $('#myModalLabel').html("新增公告");
        $('#myModal').modal("show");
    }

    function showEdit(id, content) {
        $('#id').val(id);
        $('#content').val(content);
        $('#add').hide();
        $('#upd').show();
        $('#myModalLabel').html("修改公告");
        $('#myModal').modal("show");
    }

    function addgg() {
        var content = $('#content').val();
        if(content == "") {
            alert("公告内容不能为空！");
            return;
        }
        $.ajax({
            url:"adminnoticeadd",
            type:"post",
            dataType:"json",
            data:$('#ggform').serialize(),
            async:false,
            success: function(data) {
                if(data.status == "ok") {
                    alert(data.msg);
                    $('#ggform')[0].reset();
                    $('#myModal').modal('hide');
                    window.location.href="adminnotice?q=${q}&pageNow=${page.pageNow}";
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }

    function updgg() {
        var content = $('#content').val();
        if(content == "") {
            alert("公告内容不能为空！");
            return;
        }
        $.ajax({
            url:"adminnoticeupdate",
            type:"post",
            dataType:"json",
            data:$('#ggform').serialize(),
            async:false,
            success: function(data) {
                if(data.status == "ok") {
                    alert(data.msg);
                    $('#ggform')[0].reset();
                    $('#myModal').modal('hide');
                    window.location.href="adminnotice?q=${q}&pageNow=${page.pageNow}";
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }

    function delgg(id) {
        if(!confirm("确认删除该公告吗？")){
            return;
        }
        $.ajax({
            url:"adminnoticedelete",
            type:"post",
            dataType:"json",
            data:{id:id},
            async:false,
            success: function(data) {
                if(data.status == "ok") {
                    alert(data.msg);
                    $('#ggform')[0].reset();
                    $('#myModal').modal('hide');
                    window.location.href="adminnotice?q=${q}&pageNow=${page.pageNow}";
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
