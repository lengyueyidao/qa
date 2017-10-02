<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>回答管理</title>
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
                    回答列表
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
                            <th width="35%">内容</th>
                            <th width="30%" style="text-align:center;">RE:问题</th>
                            <th width="10%" style="text-align:center;">用户</th>
                            <th width="15%" style="text-align:center;">日期</th>
                            <th width="10%" style="text-align:center;">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty answers}">
                            <tr><td colspan="5" align="center">暂无记录</td></tr>
                        </c:if>
                        <c:forEach items="${answers}" var="answer">
                            <tr>
                                <td>${answer.content}</td>
                                <td>RE:<a onclick="javascript:window.parent.location.href='question?id=${answer.questionid}'">${answer.title}</a></td>
                                <td style="text-align:center;">${answer.username}</td>
                                <td style="text-align:center;">${answer.date}</td>
                                <td style="text-align:center;"><a onclick="del('${answer.id}')">删除</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <ul class="pagination">
                        <c:choose>
                            <c:when test="${page.totalCount!=0}">
                                <c:choose>
                                    <c:when test="${page.hasFirst}">
                                        <li><a href="adminanswer?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=1" >首页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${page.hasPre}">
                                        <li><a href="adminanswer?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow-1}">上一页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:forEach var="i" begin="${(page.pageNow-1)<=0?1:((page.pageNow+2)>page.totalPageCount?((page.pageNow-2)<=0?1:page.pageNow-2):(page.pageNow-2)<=0?1:page.pageNow-2)}" end="${(page.pageNow-1)<=0?((page.pageNow+2)>page.totalPageCount?page.totalPageCount:page.pageNow+2):((page.pageNow+2)>page.totalPageCount?page.totalPageCount:((page.pageNow+2)>page.totalPageCount)?page.totalPageCount:(page.pageNow+2))}" step="1">
                                    <c:choose>
                                        <c:when test="${page.pageNow==i}">
                                            <li class="active"><a >${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="adminanswer?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${i}">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <c:choose>
                                    <c:when test="${page.hasNext}">
                                        <li><a href="adminanswer?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow+1}">下一页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${page.hasLast}">
                                        <li><a href="adminanswer?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.totalPageCount}">尾页</a></li>
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

<script>
    // 删除问题
    function del(id) {
        if(!confirm("确认删除该问题吗？")) {
            return;
        }
        $.post("adminanswerdelete", {id:id}, function(data) {
            if(data.status == "ok") {
                alert(data.msg);
                window.location.href="adminanswer?q=${q}&pageNow=${page.pageNow}";
            }
            else {
                alert(data.msg);
            }
        },"json");
    }
    // 搜索
    function search() {
        window.location.href="adminanswer?q="+$('#q').val();
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
