$(function(){
	
	//登录输入框效果
	$('.form_text_ipt input').focus(function(){
		$(this).parent().css({
			'box-shadow':'0 0 3px #bbb',
		});
	});
	$('.form_text_ipt input').blur(function(){
		$(this).parent().css({
			'box-shadow':'none',
		});
		//$(this).parent().next().hide();
	});

	//执行登录操作
	$("#loginbtn").click(function(){
		$.ajax({
			type: "POST",
			dataType: "json",
			url:"login",
			data:$('#loginform').serialize(),
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
	});

	//执行注册操作
	$("#registerbtn").click(function(){

		if($("input[name=usercode]").val() == "") {
			alert("帐号不能为空！");
			return;
		}

		if($("input[name=username]").val() == "") {
			alert("昵称不能为空！");
			return;
		}

		if($("input[name=password]").val() == "") {
			alert("密码不能为空！");
			return;
		}

		if($("input[name=password]").val() != $("input[name=repassword]").val()) {
			alert("密码输入不一致！");
			return;
		}

		$.ajax({
			type: "POST",
			dataType: "json",
			url:"register",
			data:$('#registerform').serialize(),
			async: false,
			success: function(data) {
				if(data.status == "ok") {
					alert(data.msg);
					window.location.href="login";
				}
				else {
					alert(data.msg);
				}
			}
		});
	});
});


