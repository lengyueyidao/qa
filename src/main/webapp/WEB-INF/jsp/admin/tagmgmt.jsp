<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>标签管理</title>
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
                    标签列表
                </div>
                <div style="float: right">
                    &nbsp;<button class="btn btn-primary" onclick="showAdd()">新增标签</button>
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
                            <th width="40%" style="text-align:center;">标签名</th>
                            <th width="40%" style="text-align:center;">对应问题数</th>
                            <th width="20%" style="text-align:center;">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty tags}">
                            <tr><td colspan="3" align="center">暂无记录</td></tr>
                        </c:if>
                        <c:forEach items="${tags}" var="tag">
                            <tr>
                                <td style="text-align:center;">${tag.name}</td>
                                <td style="text-align:center;">${tag.questionCount}</td>
                                <td style="text-align:center;"><a onclick="showEdit('${tag.id}', '${tag.name}')">编辑</a> | <a onclick="deltag('${tag.id}')">删除</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <ul class="pagination">
                        <c:choose>
                            <c:when test="${page.totalCount!=0}">
                                <c:choose>
                                    <c:when test="${page.hasFirst}">
                                        <li><a href="admintag?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=1" >首页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${page.hasPre}">
                                        <li><a href="admintag?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow-1}">上一页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:forEach var="i" begin="${(page.pageNow-1)<=0?1:((page.pageNow+2)>page.totalPageCount?((page.pageNow-2)<=0?1:page.pageNow-2):(page.pageNow-2)<=0?1:page.pageNow-2)}" end="${(page.pageNow-1)<=0?((page.pageNow+2)>page.totalPageCount?page.totalPageCount:page.pageNow+2):((page.pageNow+2)>page.totalPageCount?page.totalPageCount:((page.pageNow+2)>page.totalPageCount)?page.totalPageCount:(page.pageNow+2))}" step="1">
                                    <c:choose>
                                        <c:when test="${page.pageNow==i}">
                                            <li class="active"><a >${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="admintag?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${i}">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <c:choose>
                                    <c:when test="${page.hasNext}">
                                        <li><a href="admintag?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow+1}">下一页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${page.hasLast}">
                                        <li><a href="admintag?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.totalPageCount}">尾页</a></li>
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
                    修改标签
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-inline" id="tagform">
                    <input type="hidden" id="id" name="id">
                    <div style="margin-top: 0px">
                        <label for="name">标签内容:</label>
                        <input id="name" name="name" class="form-control" >
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="upd" onclick="updtag()">
                    提交修改
                </button>
                <button type="button" class="btn btn-primary" id="add" onclick="addtag()">
                    提交新增
                </button>
            </div>
        </div>
    </div>
</div>
<script>

    // 搜索
    function search() {
        window.location.href="admintag?q="+$('#q').val();
    }

    function showAdd() {
        $('#name').val("");
        $('#add').show();
        $('#upd').hide();
        $('#myModalLabel').html("新增标签");
        $('#myModal').modal("show");
    }

    function showEdit(id, name) {
        $('#id').val(id);
        $('#name').val(name);
        $('#add').hide();
        $('#upd').show();
        $('#myModalLabel').html("修改标签");
        $('#myModal').modal("show");
    }

    function addtag() {
        var name = $('#name').val();
        if( name == "") {
            alert("标签不能为空！");
            return;
        }
        $.ajax({
            url:"admintagadd",
            type:"post",
            dataType:"json",
            data:$('#tagform').serialize(),
            async:false,
            success: function(data) {
                if(data.status == "ok") {
                    alert(data.msg);
                    $('#tagform')[0].reset();
                    $('#myModal').modal('hide');
                    window.location.href="admintag?q=${q}&pageNow=${page.pageNow}";
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }

    function updtag() {
        var name = $('#name').val();
        if(name == "") {
            alert("标签内容不能为空！");
            return;
        }
        $.ajax({
            url:"admintagupdate",
            type:"post",
            dataType:"json",
            data:$('#tagform').serialize(),
            async:false,
            success: function(data) {
                if(data.status == "ok") {
                    alert(data.msg);
                    $('#tagform')[0].reset();
                    $('#myModal').modal('hide');
                    window.location.href="admintag?q=${q}&pageNow=${page.pageNow}";
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }

    function deltag(id) {
        if(!confirm("确认删除该标签吗？")){
            return;
        }
        $.ajax({
            url:"admintagdelete",
            type:"post",
            dataType:"json",
            data:{id:id},
            async:false,
            success: function(data) {
                if(data.status == "ok") {
                    alert(data.msg);
                    $('#tagform')[0].reset();
                    $('#myModal').modal('hide');
                    window.location.href="admintag?q=${q}&pageNow=${page.pageNow}";
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
