<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>我的问题</title>
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
                    问题列表
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
                            <th width="34%">标题</th>
                            <th width="15%" style="text-align:center;">日期</th>
                            <th width="8%" style="text-align:center;">阅读</th>
                            <th width="8%" style="text-align:center;">回答</th>
                            <th width="20%" style="text-align:center;">标签</th>
                            <th width="20%" style="text-align:center;">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty questions}">
                            <tr><td colspan="6" align="center">暂无记录</td></tr>
                        </c:if>
                        <c:forEach items="${questions}" var="question">
                            <tr>
                                <td><a onclick="javascript:window.parent.location.href='question?id=${question.id}'">${question.title}</a></td>
                                <td style="text-align:center;">${question.date}</td>
                                <td style="text-align:center;">${question.views}</td>
                                <td style="text-align:center;">${question.answers}</td>
                                <td style="text-align:center;">
                                    <c:forEach items="${question.tags}" var="tag" varStatus="i">
                                        <c:if test="${i.index == 0}">
                                            <a onclick="javascript:window.parent.location.href='questiontag?tagid=${tag.id}'">${tag.name}</a>
                                        </c:if>
                                        <c:if test="${i.index != 0}">
                                            ，<a onclick="javascript:window.parent.location.href='questiontag?tagid=${tag.id}'">${tag.name}</a>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td style="text-align:center;"><c:if test="${question.isover == 0}"><a onclick="overQuestion('${question.id}',1)">解决</a></c:if><c:if test="${question.isover == 1}"><a onclick="overQuestion('${question.id}',0)">未解决</a></c:if> | <a onclick="javascript:window.location.href='ucenteredit?id=${question.id}'">编辑</a> | <c:if test="${question.isover == 0}"><a onclick="del('${question.id}', 1)">删除</a></c:if><c:if test="${question.isover == 1}"><a onclick="del('${question.id}', 0)">删除</a></c:if></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <ul class="pagination">
                        <c:choose>
                            <c:when test="${page.totalCount!=0}">
                                <c:choose>
                                    <c:when test="${page.hasFirst}">
                                        <li><a href="ucentermyquestion?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=1" >首页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${page.hasPre}">
                                        <li><a href="ucentermyquestion?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow-1}">上一页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:forEach var="i" begin="${(page.pageNow-1)<=0?1:((page.pageNow+2)>page.totalPageCount?((page.pageNow-2)<=0?1:page.pageNow-2):(page.pageNow-2)<=0?1:page.pageNow-2)}" end="${(page.pageNow-1)<=0?((page.pageNow+2)>page.totalPageCount?page.totalPageCount:page.pageNow+2):((page.pageNow+2)>page.totalPageCount?page.totalPageCount:((page.pageNow+2)>page.totalPageCount)?page.totalPageCount:(page.pageNow+2))}" step="1">
                                    <c:choose>
                                        <c:when test="${page.pageNow==i}">
                                            <li class="active"><a >${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="ucentermyquestion?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${i}">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <c:choose>
                                    <c:when test="${page.hasNext}">
                                        <li><a href="ucentermyquestion?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.pageNow+1}">下一页</a></li>
                                    </c:when>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${page.hasLast}">
                                        <li><a href="ucentermyquestion?<c:if test="${not empty q}">q=${q}&</c:if>pageNow=${page.totalPageCount}">尾页</a></li>
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
    function del(qid, isover) {
        if(!confirm("确认删除该问题吗？")) {
            return;
        }
        $.post("ucenterquestiondel", {qid:qid}, function(data) {
            if(data.status == "ok") {
                alert(data.msg);
                var wai = window.parent.document.getElementById("wai");
                var sov = window.parent.document.getElementById("sov");
                var all = window.parent.document.getElementById("all");

                if(isover == 1) {
                    wai.innerHTML = wai.innerHTML - 1;
                    all.innerHTML = all.innerHTML - 1;
                }
                else {
                    sov.innerHTML = sov.innerHTML - 1;
                    all.innerHTML = all.innerHTML - 1;
                }
                window.location.href="ucentermyquestion?isover=${isoverstatus}";
            }
            else {
                alert(data.msg);
            }
        },"json");
    }
    // 设置为是否解决
    function overQuestion(id, isover) {
        $.ajax({
            url:"ucenterover",
            data:{id:id, isover:isover},
            dataType:"json",
            type:"post",
            success:function(data) {
                if(data.status == "ok") {

                    var wai = window.parent.document.getElementById("wai");
                    var sov = window.parent.document.getElementById("sov");

                    if(isover == 1) {
                        wai.innerHTML = wai.innerHTML - 1;
                        sov.innerHTML = sov.innerHTML - (-1);
                    }
                    else {
                        wai.innerHTML = wai.innerHTML - (-1);
                        sov.innerHTML = sov.innerHTML - 1;
                    }


                    window.location.href='ucentermyquestion?isover=${isoverstatus}';
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }

    // 搜索
    function search() {
        window.location.href="ucentermyquestion?isover=${isoverstatus}&q="+$('#q').val();
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
