<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>我的主页</title>
    <meta charset="utf-8" />
    <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="shortcut icon" href="<%=basePath%>images/logo.png" type="image/x-icon" >
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/bootstrap.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/animate.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/simple-line-icons.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/font.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/app.css" type="text/css" />
    <link rel="stylesheet" href="<%=basePath%>ucenter/css/jquery.Jcrop.css" type="text/css" />
</head>
<style>
    .jcrop-holder #preview-pane{
        display:block;
        position:absolute;
        z-index:2000;
        top:0;
        left:400px;
        padding:6px;
        border:1px rgba(0,0,0,.4) solid;
        border-radius:6px;
        background-color:white;
        box-shadow:1px 1px 5px 2px rgba(0, 0, 0, 0.2);
    }

    #preview-pane .preview-container{
        width:120px;
        height:120px;
        overflow:hidden;
    }

</style>
<body style="z-index: -1; height: 100%" >
<div id="my" style="height: 100%">
    <a href class="off-screen-toggle hide" data-toggle="class:off-screen" data-target=".app-aside" ></a>
    <div class="app-content-body fade-in-up">
        <div class="hbox hbox-auto-xs hbox-auto-sm">
            <div class="col">
                <div style="background:url(ucenter/img/c4.jpg) center center; background-size:cover">
                    <div class="wrapper-lg bg-white-opacity">
                        <div class="row m-t">
                            <div class="col-sm-7">
                                <a data-toggle="modal" data-target="#myModal" class="thumb-lg pull-left m-r">
                                    <img src="gethead?id=${user.id}" class="img-circle">
                                </a>
                                <div class="clear m-b">
                                    <div class="m-b m-t-sm">
                                        <span class="h3 text-black">${user.username}</span>

                                    </div>
                                    <small class="m-l">${user.description}</small>
                                    <%--<a href class="btn btn-sm btn-success btn-rounded">关注TA</a>--%>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <div class="pull-right pull-none-xs text-center">
                                    <a href="ucenterfollowed?id=${user.id}" class="m-b-md inline m">
                                        <span class="h3 block font-bold">${followedCount}</span>
                                        <small>被关注</small>
                                    </a>
                                    <a href="ucenterfollowing?id=${user.id}" class="m-b-md inline m">
                                        <span class="h3 block font-bold">${followingCount}</span>
                                        <small>我的关注</small>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="wrapper bg-white b-b">
                    <ul class="nav nav-pills nav-sm">
                        <li class="active"><a href="ucenterhome">动态</a></li>
                        <%--<li><a href>说说</a></li>--%>
                        <%--<li><a href>日志</a></li>--%>
                    </ul>
                </div>
                <div class="padder">
                    <div class="streamline b-l b-info m-l-lg m-b padder-v" id="dycon">
                        <c:forEach items="${dynamics}" var="dy">
                            <div>
                                <a class="pull-left thumb-sm avatar m-l-n-md">
                                    <img src="gethead?id=${dy.userid}" alt="...">
                                </a>
                                <div class="m-l-lg m-b-lg panel b-a bg-light lt">
                                    <div class="panel-heading pos-rlt b-light">
                                        <span class="arrow arrow-light left"></span>
                                        <c:if test="${dy.userid != user.id}">
                                            <a onclick="window.parent.location.href='ucenterotherhome?id=${dy.userid}'" class="h4">${dy.username}</a>
                                        </c:if>
                                        <c:if test="${dy.userid == user.id}">
                                            By me
                                        </c:if>
                                        <span class="text-muted m-l-sm pull-right">
                                            ${dy.date}
                                        </span>
                                    </div>
                                    <div class="panel-body">
                                        <div>提问：<a onclick="window.parent.location.href='question?id=${dy.id}'"> ${dy.title}</a></div>
                                        <div><small>${dy.content}</small></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div align="center" id="chakan">
                        <c:if test="${page.totalCount == 0}">
                            暂无动态
                        </c:if>
                        <c:if test="${page.totalCount <= page.pageSize and page.totalCount > 0}">
                            已加载所有动态
                        </c:if>
                        <c:if test="${page.totalCount > page.pageSize}">
                            <a onclick="loadData()">加载更多</a>
                        </c:if>
                    </div>
                    <br>
                </div>
            </div>
            <div class="col w-lg bg-light lter b-l bg-auto">
                <div class="wrapper">
                    <div class="">
                        <h4 class="m-t-xs m-b- xs">谁关注了你？</h4>
                        <ul class="list-group no-bg no-borders pull-in">
                            <c:if test="${fn:length(follows) == 0}">
                                <li class="list-group-item">
                                    <div class="clear">
                                        <span class="text-muted">&nbsp;当前没有任何人关注你</span>
                                    </div>
                                </li>
                            </c:if>
                            <c:if test="${fn:length(follows) > 0}">
                                <c:forEach items="${follows}" var="follow" begin="0" end="4">
                                    <li class="list-group-item">
                                        <a herf class="pull-left thumb-sm avatar m-r">
                                            <img src="gethead?id=${follow.userid}" alt="..." class="img-circle">
                                        </a>
                                        <div class="clear">
                                            <div><a onclick="window.parent.location.href='ucenterotherhome?id=${follow.userid}'">${follow.username}</a></div>
                                            <small class="text-muted"><c:if test="${empty follow.description}">暂无描述</c:if><c:if test="${!empty follow.description}">${follow.description}</c:if></small>
                                        </div>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                    <div class="panel b-a">
                        <h4 class="font-thin padder">最新问题</h4>
                        <ul class="list-group">
                            <c:forEach items="${questions}" var="question">
                                <li class="list-group-item">
                                    <p><a onclick="window.parent.location.href='ucenterotherhome?id=${question.userid}'" class="text-info">${question.username}</a>发布了<a onclick="window.parent.location.href='question?id=${question.id}'" class="text-info">${question.title}</a></p>
                                    <small class="block text-muted"><i class="fa fa-fw fa-clock-o"></i> ${question.date}</small>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    修改头像
                </h4>
            </div>
            <div class="modal-body">
                <form name="form" id="myuploadform" action="#" class="form-horizontal"
                      method="post" enctype="multipart/form-data">
                    <div class="modal-body text-center">
                        <div class="zxx_main_con">
                            <div class="zxx_test_list">
                                <input class="photo-file" type="file" name="imgFile" id="imgFile" onchange="selectFile()"/><br>
                                <div style="width: 400px;height:320px; background-image: url('ucenter/img/file_bg.png')">
                                    <img src="" id="target" >
                                </div>

                                <div id="preview-pane">
                                    <div class="preview-container">
                                        <img src="" id="targetview" class="jcrop-preview" alt="Preview">
                                    </div>
                                </div>
                                <input type="hidden" id="path" name="path">
                                <input type="hidden" id="x" name="x"/>
                                <input type="hidden" id="y" name="y"/>
                                <input type="hidden" id="w" name="w"/>
                                <input type="hidden" id="h" name="h"/>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="uploadFile()">
                    提交修改
                </button>
            </div>
        </div>
    </div>
</div>
<script src="<%=basePath%>ucenter/js/jquery/jquery.min.js"></script>
<script src="<%=basePath%>ucenter/js/jquery/jquery.Jcrop.min.js"></script>
<script src="<%=basePath%>ucenter/js/jquery/bootstrap.js"></script>
<script type="text/javascript">
    var jcrop_api = null;
    var boundx;
    var boundy;
    // 初始化
    loadJcrop();
    $('#myModal').on('shown.bs.modal', function () {
        $('#preview-pane .preview-container img').css({
            width: 120,
            height: 120,
            marginLeft: 0,
            marginTop: 0
        });
    })
    // 选择图片
    function selectFile() {
        var formData = new FormData($('#myuploadform')[0]);
        $.ajax({
            url:"ucenteruploadtemp",
            data:formData,
            type:"post",
            dataType:"json",
            async:false,
            contentType:false,
            cache:false,
            processData:false,
            success:function(data) {
                if(data.status == "ok") {
                    $('#target').removeAttr("src");
                    $('#target').attr("src", "ucentergetheadtemp?filepath="+data.data).load(function(){
                        boundx = this.width;
                        boundy = this.height;
                    });
                    $('#targetview').removeAttr("src");
                    $('#targetview').attr("src", "ucentergetheadtemp?filepath="+data.data);
                    loadJcrop();
                    if(jcrop_api != null) {
                        jcrop_api.setImage("ucentergetheadtemp?filepath="+data.data, function(c){
                            //console.log("读取图片成功");
                        });
                    }
                    $('#preview-pane .preview-container img').css({
                        width: 120,
                        height: 120,
                        marginLeft: 0,
                        marginTop: 0
                    });
                    // 每次重新选择图片时，清空
                    $("#x").val("");
                    $("#y").val("");
                    $("#w").val("");
                    $("#h").val("");
                    $('#path').val(data.data);
                }
                else if(data.status == "error"){
                    alert(data.msg);
                    var file = document.getElementById('imgFile') ;
                    // for IE, Opera, Safari, Chrome
                    if (file.outerHTML) {
                        file.outerHTML = file.outerHTML;
                    } else { // FF(包括3.5)
                        file.value = "";
                    }
                    $('#path').val("");
                }
            }
        });
    }

    // 上传头像
    function uploadFile() {
        console.log("path:"+$('#path').val());
        if($('#path').val() == "") {
            alert("请选择头像进行上传！");
            return;
        }
        var path = $('#path').val();
        var x = $('#x').val();
        var y = $('#y').val();
        var w = $('#w').val();
        var h = $('#h').val();

        $.ajax({
            url:"ucenterupload",
            data:"path="+path+"&x="+x+"&y="+y+"&w="+w+"&h="+h,
            type:"post",
            dataType:"json",
            success:function(data) {
                if(data.status == "ok") {
                    alert(data.msg);
                    $('#myModal').modal("hide");
                    window.parent.location.href='ucenter';
                }
                else {
                    alert(data.msg);
                }
            }
        });
    }

    // 关闭模态框之后清空file
    $('#myModal').on('hidden.bs.modal', function () {
        var path = $('#path').val();
        if(path != null && path != "") {
            $.ajax({
                url:"ucenterdeleteheadtemp",
                data:"path="+path,
                type:"post",
                dataType:"json",
                success:function(data) {
                    if(data.status == "ok") {
                        $("#x").val("");
                        $("#y").val("");
                        $("#w").val("");
                        $("#h").val("");
                        var file = document.getElementById('imgFile') ;
                        // for IE, Opera, Safari, Chrome
                        if (file.outerHTML) {
                            file.outerHTML = file.outerHTML;
                        } else { // FF(包括3.5)
                            file.value = "";
                        }
                        $('#path').val("");
                        //jcrop_api.setImage("ucenter/img/file_bg.png");
                        //$('#target').removeAttr("src");
                        //$('#target').attr("src", "ucenter/img/file_bg.png");
                        //$('#targetview').removeAttr("src");
                        //jcrop_api.destroy();

                    }
                }
            });
        }
        jcrop_api.release();
        $('#target').removeAttr("src");
        $('#target').attr("src", "ucenter/img/file_bg.png").load(function(){
            boundx = this.width;
            boundy = this.height;
        });
        $('#targetview').removeAttr("src");
        //$('#targetview').attr("src", "ucenter/img/preview.png");
        loadJcrop();
        if(jcrop_api != null) {
            jcrop_api.setImage("ucenter/img/file_bg.png", function(c){
                //console.log("读取图片成功");
                jcrop_api.disable();
            });
        }

    });

    function loadJcrop(){

        var
            $preview = $('#preview-pane'),
            $pcnt = $('#preview-pane .preview-container'),
            $pimg = $('#preview-pane .preview-container img'),

            xsize = $pcnt.width(),
            ysize = $pcnt.height();

        $('#target').Jcrop({
            onChange: updatePreview,
            onSelect: updatePreview,
            boxWidth: 400,
            boxHeight: 320,
            aspectRatio: 1,
            keySupport: false
        },function(){
            jcrop_api = this;
            $preview.appendTo(jcrop_api.ui.holder);
        });

        function updatePreview(c){
            if (parseInt(c.w) > 0) {
                var rx = xsize / c.w;
                var ry = ysize / c.h;
                $pimg.css({
                    width: Math.round(rx * boundx) + 'px',
                    height: Math.round(ry * boundy) + 'px',
                    marginLeft: '-' + Math.round(rx * c.x) + 'px',
                    marginTop: '-' + Math.round(ry * c.y) + 'px'
                });
                $("#x").val(c.x);
                $("#y").val(c.y);
                $("#w").val(c.w);
                $("#h").val(c.h);

            }
        };

    }

</script>

<script>
    // 加载数据
    var totalheight = 0;
    var pageNow = 1;
    var totalPage = ${page.totalPageCount};
    function loadData(){
        //totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop());
        if (pageNow < totalPage) {
            /*这里使用Ajax加载更多内容*/
            var container = $("#dycon"); // 加载容器
            $.ajax({
                type: "POST",
                url: "ucenterloaddynamics",
                data: {pageNow:pageNow+1},
                dataType: "json",
                beforeSend: function () {
                    $('#chakan').html("正在加载中...");
                },
                success : function(data) {
                    pageNow = data.obj.pageNow;
                    var html = "";
                    for(var i = 0; i < data.list.length; i++) {
                        var d = data.list[i];
                        html += "<div>"+
                                "   <a class=\"pull-left thumb-sm avatar m-l-n-md\">"+
                                "      <img src='gethead?id="+ d.userid +"' class=\"img-circle\" alt=\"...\">"+
                                "   </a>"+
                                "   <div class=\"m-l-lg m-b-lg panel b-a bg-light lt\">"+
                                "       <div class=\"panel-heading pos-rlt b-light\">"+
                                "           <span class=\"arrow arrow-light left\"></span>";
                        if(d.userid != ${user.id}) {
                            html += "<a onclick=\"window.parent.location.href='ucenterotherhome?id="+ d.userid+"'\" class=\"h4\">"+ d.username+"</a>";
                        }
                        else {
                            html += "By me";
                        }
                        html += "           <span class=\"text-muted m-l-sm pull-right\">"+
                                "           "+ d.date +
                                "           </span>"+
                                "       </div>"+
                                "       <div class=\"panel-body\">"+
                                "           <div>提问：<a onclick='window.parent.location.href=\"question?id="+ d.id+"\"'>"+ d.title+"</a></div>"+
                                "           <div><small>"+ d.content+"</small></div>"+
                                "       </div>"+
                                "   </div>"+
                                "</div>";

                    }
                    container.append(html);
                    $('#chakan').html("<a onclick=\"loadData()\">加载更多</a>");
                    if(pageNow == totalPage) {
                        $('#chakan').html("已加载所有动态");
                    }
                }
            });
        }
    }

</script>

</body>
</html>
