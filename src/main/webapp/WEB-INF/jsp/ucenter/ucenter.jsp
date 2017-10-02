<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>IT技术问答社区</title>
  <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link rel="shortcut icon" href="<%=basePath%>images/logo.png" type="image/x-icon" >
  <link rel="stylesheet" href="<%=basePath%>ucenter/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="<%=basePath%>ucenter/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="<%=basePath%>ucenter/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="<%=basePath%>ucenter/css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="<%=basePath%>ucenter/css/font.css" type="text/css" />
  <link rel="stylesheet" href="<%=basePath%>ucenter/css/app.css" type="text/css" />
  <link rel="stylesheet" href="<%=basePath%>ucenter/css/scroll.css" type="text/css" />
</head>
<body>
  <div class="app app-header-fixed" id="app">
    <div class="app-header navbar">
      <div class="navbar-header bg-dark">
        <button class="pull-right visible-xs dk" data-toggle="class:show" data-target=".navbar-collapse">
          <i class="glyphicon glyphicon-cog"></i>
        </button>
        <button class="pull-right visible-xs" data-toggle="class:off-screen" data-target=".app-aside" ui-scroll="app">
          <i class="glyphicon glyphicon-align-justify"></i>
        </button>
        <a href="index" class="navbar-brand text-lt">
        	<i class="fa fa-weixin" ></i>
          <img src="ucenter/img/logo.png" alt="." style="width: 20px;height:20px" class="hide">
          <span class="hidden-folded m-l-xs">IT技术问答</span>
        </a>
      </div>
      <div class="collapse pos-rlt navbar-collapse box-shadow bg-white-opacity">
        <div class="nav navbar-nav hidden-xs">
          <a href="#" class="btn no-shadow navbar-btn" data-toggle="class:app-aside-folded" data-target=".app">
            <i class="fa fa-dedent fa-fw text"></i>
            <i class="fa fa-indent fa-fw text-active"></i>
          </a>
          <a href class="btn no-shadow navbar-btn" data-toggle="class:show" data-target="#aside-user">
            <i class="icon-user fa-fw"></i>
          </a>
        </div>
        <ul class="nav navbar-nav navbar-right">
          <li class="dropdown">
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">
              <i class="icon-bell fa-fw"></i>
              <span class="visible-xs-inline">消息</span>
              <span class="badge badge-sm up bg-danger pull-right-xs">${fn:length(answers)}</span>
            </a>
            <div class="dropdown-menu w-xl animated fadeInUp">
              <div class="panel bg-white">
                <div class="panel-heading b-light bg-light">
                  <c:if test="${fn:length(answers) == 0}">
                    <strong>暂无消息</strong>
                  </c:if>
                  <c:if test="${fn:length(answers) > 0}">
                   <strong>你有<span>${fn:length(answers)}</span>条消息</strong>
                  </c:if>
                </div>
                <div class="list-group">
                  <c:forEach items="${answers}" var="answer">
                    <a href="question?id=${answer.questionid}" class="media list-group-item">
                    <span class="pull-left thumb-sm">
                      <img src="gethead?id=${answer.userid}" alt="..." class="img-circle">
                    </span>
                    <span class="media-body block m-b-none">
                      ${answer.username}回复了你。。。<br>
                      <small class="text-muted">${answer.date}</small>
                    </span>
                    </a>
                  </c:forEach>
                </div>
              </div>
            </div>
          </li>
          <li class="dropdown">
            <a href="#" data-toggle="dropdown" class="dropdown-toggle clear" data-toggle="dropdown">
              <span class="thumb-sm avatar pull-right m-t-n-sm m-b-n-sm m-l-sm">
                <img src="gethead?id=${user.id}" alt="...">
              </span>
              <span class="hidden-sm hidden-md">${user.username}</span> <b class="caret"></b>
            </a>
            <ul class="dropdown-menu animated fadeInRight w">
              <li>
                <a data-toggle="modal" data-target="#myModal">Change Password</a>
              </li>
              <li>
                <a onclick="toPage(6)">
                  <span>Settings</span>
                </a>
              </li>
              <li class="divider"></li>
              <li>
                <a href="#" id="logoutbtn">Logout</a>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
    <div class="app-aside hidden-xs bg-dark">
      <div class="aside-wrap">
        <div class="navi-wrap">
          <!-- user -->
          <div class="clearfix hidden-xs text-center hide" id="aside-user">
            <div class="dropdown wrapper">
              <a >
                <span class="thumb-lg w-auto-folded avatar m-t-sm">
                  <img src="gethead?id=${user.id}" class="img-full" alt="...">
                </span>
              </a>
              <a href="#" data-toggle="dropdown" class="dropdown-toggle hidden-folded">
                <span class="clear">
                  <span class="block m-t-sm">
                    <strong class="font-bold text-lt">${user.username}</strong>
                    <b class="caret"></b>
                  </span>
                  <span class="text-muted text-xs block">${user.address}</span>
                </span>
              </a>
              <ul class="dropdown-menu animated fadeInRight w hidden-folded">
                <li>
                  <a data-toggle="modal" data-target="#myModal">Change Password</a>
                </li>
                <li>
                  <a onclick="toPage(6)">Settings</a>
                </li>
                <li class="divider"></li>
                <li>
                  <a href="#" id="logoutbtn1">Logout</a>
                </li>
              </ul>
            </div>
            <div class="line dk hidden-folded"></div>
          </div>
          <nav ui-nav class="navi">
            <ul class="nav">
              <li>
                <a title="我的主页" onclick="toPage(0)">
                	<i class="glyphicon glyphicon-home icon text-primary-dker"></i>
                  <span class="font-bold" >我的主页</span>
                </a>
              </li>
              <li>
                <a title="我要提问" onclick="toPage(1)">
                	<i class="glyphicon glyphicon-pencil icon text-info-dker"></i>
                  <span class="font-bold" >我要提问</span>
                </a>
              </li>

              <li>
                <a href class="auto"  title="我的问题">
                  <span class="pull-right text-muted">
                    <i class="fa fa-fw fa-angle-right text"></i>
                    <i class="fa fa-fw fa-angle-down text-active"></i>
                  </span>
                  <i class="glyphicon glyphicon-bookmark icon text-info-lter"></i>
                  <span class="font-bold" >我的问题</span>
                </a>
                <ul class="nav nav-sub dk">
                  <li >
                    <a onclick="toPage(2)">
                    	<b class="label bg-info pull-right" id="all">${sov + wai}</b>
                      <span>所有问题</span>
                    </a>
                  </li>
                  <li >
                    <a onclick="toPage(3)">
                    	<b class="label bg-info pull-right" id="wai">${wai}</b>
                      <span>暂未解决</span>
                    </a>
                  </li>
                  <li >
                    <a onclick="toPage(4)">
                      <b class="label bg-info pull-right" id="sov">${sov}</b>
                      <span>已经解决</span>
                    </a>
                  </li>
                </ul>
              </li>
              <li>
              	<a title="我的回答" onclick="toPage(5)">
              		<i class="glyphicon glyphicon-comment icon text-success"></i>
                  <span class="font-bold" >我的回答</span>
                </a>
              </li>
              <c:if test="${user.usercode == 'admin'}">
                <li class="line dk"></li>
                <li>
                  <a href class="auto"  title="我是管理员">
                  <span class="pull-right text-muted">
                    <i class="fa fa-fw fa-angle-right text"></i>
                    <i class="fa fa-fw fa-angle-down text-active"></i>
                  </span>
                    <i class="glyphicon glyphicon-user icon text-info-lter"></i>
                    <span class="font-bold" >我是管理员</span>
                  </a>
                  <ul class="nav nav-sub dk">
                    <li >
                      <a onclick="toPage(7)">
                        <span>用户管理</span>
                      </a>
                    </li>
                    <li >
                      <a onclick="toPage(8)">
                        <span>问题管理</span>
                      </a>
                    </li>
                    <li >
                      <a onclick="toPage(9)">
                        <span>回答管理</span>
                      </a>
                    </li>
                    <li >
                      <a onclick="toPage(10)">
                        <span>标签管理</span>
                      </a>
                    </li>
                    <li >
                      <a onclick="toPage(11)">
                        <span>公告管理</span>
                      </a>
                    </li>
                    <li >
                      <a onclick="toPage(12)">
                        <span>关注管理</span>
                      </a>
                    </li>
                    <li >
                      <a onclick="updateIndex()">
                        <span>更新索引</span>
                      </a>
                    </li>
                  </ul>
                </li>
              </c:if>

            </ul>
          </nav>
        </div>
      </div>
    </div>
    <div class="app-content">
      <iframe src="ucenterhome" name="iframepage" id="iframepage" frameborder="0" scrolling="no" width="100%" ></iframe>
    </div>
    <a href="#top" id="scroll-top"></a>
  </div>

  <!-- 模态框（Modal） -->
  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 25%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
            &times;
          </button>
          <h4 class="modal-title" id="myModalLabel">
            修改密码
          </h4>
        </div>
        <div class="modal-body">
          <form class="form-inline" id="pwdform">
            <div style="margin-top: 0px">
              <label for="oldpassword">旧的密码:</label>
              <input type="password" class="form-control" id="oldpassword" name="oldpassword"/><br>
            </div>
            <div style="margin-top: 10px">
              <label for="password">新的密码:</label>
              <input type="password" class="form-control" id="password" name="password"/><br>
            </div>
            <div style="margin-top: 10px">
              <label for="repassword">确认密码:</label>
              <input type="password" class="form-control" id="repassword" name="repassword"/>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">关闭
          </button>
          <button type="button" class="btn btn-primary" onclick="updpwd()">
            提交修改
          </button>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" style="width:25%;height:30px">
        <div class="progress progress-striped active">
          <div class="progress-bar progress-bar-success" role="progressbar" style="width: 100%;">
            <span>正在更新索引文件，请稍候。。。</span>
          </div>
        </div>
    </div>
  </div>

  <script src="<%=basePath%>ucenter/js/jquery/jquery.min.js"></script>
  <script src="<%=basePath%>ucenter/js/jquery/bootstrap.js"></script>
  <script src="<%=basePath%>ucenter/js/scroll.js"></script>
  <script src="<%=basePath%>js/my.js"></script>

  <script type="text/javascript">

    // 修改密码
    function updpwd() {
      var oldpwd = $('#oldpassword').val();
      var pwd = $('#password').val();
      var repwd = $('#repassword').val();

      if(oldpwd == "") {
        alert("旧的密码不能为空!");
        return;
      }
      if(pwd == "") {
        alert("新的密码不能为空!");
        return;
      }
      if(pwd != repwd) {
        alert("两次密码输入不一致!");
        return;
      }

      $.ajax({
        url:"ucenterupdpwd",
        type:"post",
        dataType:"json",
        data:$('#pwdform').serialize(),
        async:false,
        success: function(data) {
          if(data.status == "ok") {
            alert(data.msg);
            $('#pwdform')[0].reset();
            $('#myModal').modal('hide')
          }
          else {
            alert(data.msg);
          }
        }
      });

    }

    function updateIndex() {
      $('#myModal1').modal("show");
      $.ajax({
        url:"adminupdateindex",
        type:"post",
        dataType:"json",
        success: function(data) {
          $('#myModal1').modal("hide");
          if(data.status == "ok") {
            alert(data.msg);
          }
          else {
            alert(data.msg);
          }
        }
      });
    }

    // 页面跳转
    function toPage(id) {
      var ifm= document.getElementById("iframepage");
      if(id == "0") {
        ifm.src = "ucenterhome";
      }
      if(id == "1") {
        ifm.src = "ucenterask";
      }
      if(id == "2") {
        ifm.src = "ucentermyquestion";
      }
      if(id == "3") {
        ifm.src = "ucentermyquestion?isover=0";
      }
      if(id == "4") {
        ifm.src = "ucentermyquestion?isover=1";
      }
      if(id == "5") {
        ifm.src = "ucentermyanswer";
      }
      if(id == "6") {
        ifm.src = "ucenterconfig";
      }
      if(id == "7") {
        ifm.src = "adminuser";
      }
      if(id == "8") {
        ifm.src = "adminquestion";
      }
      if(id == "9") {
        ifm.src = "adminanswer";
      }
      if(id == "10") {
        ifm.src = "admintag";
      }
      if(id == "11") {
        ifm.src = "adminnotice";
      }
      if(id == "12") {
        ifm.src = "adminfollow";
      }
    }

    function iFrameHeight() {
      var ifm= document.getElementById("iframepage");
      var subWeb = document.frames ? document.frames["iframepage"].document : ifm.contentDocument;
      if(ifm != null && subWeb != null) {
        ifm.height = subWeb.body.scrollHeight;

      }
    }

    (function(){
      var frame = document.getElementById("iframepage");
      var _reSetIframe = function(){
        try {
          var frameContent = frame.contentWindow.document,
                  bodyHeight = Math.max(frameContent.body.scrollHeight,frameContent.documentElement.scrollHeight)-50;
          if(bodyHeight < 600) {
            bodyHeight = 600;
          }
          if (bodyHeight != frame.height){
            frame.height = bodyHeight;
          }

        }
        catch(ex) {
          frame.height = 100;
        }
      }
      if(frame.addEventListener){
        frame.addEventListener("load",function(){setInterval(_reSetIframe,0);},false);
      }else{
        frame.attachEvent("onload",function(){setInterval(_reSetIframe,0);});
      }
    })();

  </script>

  <script type="text/javascript">
    +function ($) {
      $(function(){
        // class
        $(document).on('click', '[data-toggle^="class"]', function(e){
          e && e.preventDefault();
          console.log('abc');
          var $this = $(e.target), $class , $target, $tmp, $classes, $targets;
          !$this.data('toggle') && ($this = $this.closest('[data-toggle^="class"]'));
          $class = $this.data()['toggle'];
          $target = $this.data('target') || $this.attr('href');
          $class && ($tmp = $class.split(':')[1]) && ($classes = $tmp.split(','));
          $target && ($targets = $target.split(','));
          $classes && $classes.length && $.each($targets, function( index, value ) {
            if ( $classes[index].indexOf( '*' ) !== -1 ) {
              var patt = new RegExp( '\\s' + 
                  $classes[index].
                    replace( /\*/g, '[A-Za-z0-9-_]+' ).
                    split( ' ' ).
                    join( '\\s|\\s' ) + 
                  '\\s', 'g' );
              $($this).each( function ( i, it ) {
                var cn = ' ' + it.className + ' ';
                while ( patt.test( cn ) ) {
                  cn = cn.replace( patt, ' ' );
                }
                it.className = $.trim( cn );
              });
            }
            ($targets[index] !='#') && $($targets[index]).toggleClass($classes[index]) || $this.toggleClass($classes[index]);
          });
          $this.toggleClass('active');
        });

        // collapse nav
        $(document).on('click', 'nav a', function (e) {
          var $this = $(e.target), $active;
          $this.is('a') || ($this = $this.closest('a'));
          
          $active = $this.parent().siblings( ".active" );
          $active && $active.toggleClass('active').find('> ul:visible').slideUp(200);
          
          ($this.parent().hasClass('active') && $this.next().slideUp(200)) || $this.next().slideDown(200);
          $this.parent().toggleClass('active');
          
          $this.next().is('ul') && e.preventDefault();

          setTimeout(function(){ $(document).trigger('updateNav'); }, 300);      
        });
      });
    }(jQuery);
  </script>
</body>
</html>