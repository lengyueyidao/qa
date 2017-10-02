/**
 * Created by Alvin on 2016/10/15.
 */
$(function() {

    //执行登出操作
    $("#logoutbtn").click(function(){
        if(confirm("你确定退出登录吗？")) {
            $.ajax({
                type: "GET",
                dataType: "json",
                url:"logout",
                async: false,
                success: function(data) {
                    if(data.status == "ok") {
                        window.location.href="index";
                    }
                    else {
                        alert(data.msg);
                    }
                }
            });
        }

    });

    //执行登出操作
    $("#logoutbtn1").click(function(){
        if(confirm("你确定退出登录吗？")) {
            $.ajax({
                type: "GET",
                dataType: "json",
                url:"logout",
                async: false,
                success: function(data) {
                    if(data.status == "ok") {
                        window.location.href="index";
                    }
                    else {
                        alert(data.msg);
                    }
                }
            });
        }

    });

    $("#ucenter").click(function() {
        window.location.href = "ucenter";
    });

});

$.ajax({
    url:"query",
    type:"get",
    dataType:"json",
    success:function(data){
        if(data.status == "ok") {
            var answers = data.list;
            for(var i = 0; i < answers.length; i++) {
                var item = answers[i];
                $("#recentcomments").append("<li class=\"recentcomments\"><a href=\"ucenterotherhome?id="+item.userid+"\" rel=\"external nofollow\" class=\"url\">"+item.username+"</a> 回答了 <a href=\"question?id="+item.questionid+"\">"+item.title+"</a></li>");
            }
        }
    }
});

$.ajax({
    url:"querytags",
    type:"get",
    dataType:"json",
    success:function(data){
        if(data.status == "ok") {
            var tags = data.list;
            for(var i = 0; i < tags.length; i++) {
                var item = tags[i];

                $("#tagcloud").append("<a href=\"questiontag?tagid="+item.id+"\" class=\"btn btn-mini\">"+item.name+" - "+item.questionCount+"</a>");
            }
            $("#tagcloud").append("<a href=\"tags\" class=\"btn btn-mini\">. . .</a>");
        }
    }
});