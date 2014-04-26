<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Register</title>
	<link href="<%=request.getContextPath()%>/static/css/bootstrap.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/static/css/bootstrap-responsive.css" rel="stylesheet">
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery.js"></script>
	<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/validator/jquery.validator.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/validator/jquery.validator.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/validator/zh_CN.js"></script> --%>
	<style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
    </style>
    <script type="text/javascript">
    
    $(document).ready(function(){
    	$("#buyer_btn").click(function() {
		});
    	
    	$("#seller_btn").click(function() {
    		
		});
    	
		$("#register").click(function() {
			var obj;
    		var select;
    		obj = document.getElementsByName("userType");
    		if(obj!=null) {
    			var i;
    			for(i=0; i<obj.length; i++) {
    				if(obj[i].checked)
    					select = obj[i].value;
    			}
    		}
    		if(select == "0") {
    			addNewBuyer();
    		}
    		else {
    			addNewSeller()
    		}
		});
    });
    
    	function addNewBuyer() {

    		username = $("input[name='username']").val();
    		password = $("input[name='password']").val();
    		confirmpwd = $("input[name='confirmPassword']").val();
    		email = $("input[name='email']").val();
    		bool_un = username.match(/^\w{3,12}$/);
    		bool_pwd = password.match(/^[0-9a-zA-Z]{6,16}$/);
    		bool_email = email.match(/^(?:[a-z0-9]+[_\-+.]?)*[a-z0-9]+@(?:([a-z0-9]+-?)*[a-z0-9]+\.)+([a-z]{2,})+$/i);
    	    if(bool_un == null){
    	    	$("#nameDiv").html("请输入3-12位数字、字母、下划线");
    	    } else {
    	    	$("#nameDiv").html("");
    	    }
    	    if(bool_pwd == null){
    	    	$("#pwdOut").html("密码由6-16位数字、字母组成");
    	    } else {
    	    	$("#pwdOut").html("");
    	    }
    	    if(password != confirmpwd) {
    	    	$("#confirmPwd").html("密码不一致！");
    	    } else {
    	    	$("#confirmPwd").html("");
    	    }
    	    if(bool_email == null) {
    	    	$("#emailErr").html("邮箱格式不正确！");
    	    } else {
    	    	$("#emailErr").html("");
    	    }
    	    b =$("input[name='agreeCheck']").is(':checked');
    	    if(!b){
    	    	$("#checkErr").html("请同意规定！");
    	    } else {
    	    	$("#checkErr").html("");
    	    }
    	    if(bool_un != null && bool_pwd != null && password == confirmpwd && bool_email != null && b){
    	    	document.registerForm.action = '<%=request.getContextPath()%>/BuyerController/register';
    	    	document.registerForm.submit();
    	    
    		}
    	}
    	
    	function addNewSeller() {
    		username = $("input[name='username']").val();
    		password = $("input[name='password']").val();
    		confirmpwd = $("input[name='confirmPassword']").val();
    		email = $("input[name='email']").val();
    		bool_un = username.match(/^\w{3,12}$/);
    		bool_pwd = password.match(/^[0-9a-zA-Z]{6,16}$/);
    		bool_email = email.match(/^(?:[a-z0-9]+[_\-+.]?)*[a-z0-9]+@(?:([a-z0-9]+-?)*[a-z0-9]+\.)+([a-z]{2,})+$/i);
    	    if(bool_un == null){
    	    	$("#nameDiv").html("请输入3-12位数字、字母、下划线");
    	    } else {
    	    	$("#nameDiv").html("");
    	    }
    	    if(bool_pwd == null){
    	    	$("#pwdOut").html("密码由6-16位数字、字母组成");
    	    } else {
    	    	$("#pwdOut").html("");
    	    }
    	    if(password != confirmpwd) {
    	    	$("#confirmPwd").html("密码不一致！");
    	    } else {
    	    	$("#confirmPwd").html("");
    	    }
    	    if(bool_email == null) {
    	    	$("#emailErr").html("邮箱格式不正确！");
    	    } else {
    	    	$("#emailErr").html("");
    	    }
    	    b =$("input[name='agreeCheck']").is(':checked');
    	    if(!b){
    	    	$("#checkErr").html("请同意规定！");
    	    } else {
    	    	$("#checkErr").html("");
    	    }
    	    if(bool_un != null && bool_pwd != null && password == confirmpwd && bool_email != null && b){
    	    	document.registerForm.action = "<%=request.getContextPath()%>/SellerController/register";
    	    	document.registerForm.submit();
    	    }
    	}
    	    
    	    
    
    	
    	function changeImg() {
    		var imgSrc = $("#imgStamp");
    		var src = imgSrc.attr("src");
    		imgSrc.attr("src", chgUrl(src));
    	}
    	//时间戳   
    	//为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳   
    	function chgUrl(url) {
    		var timestamp = (new Date()).valueOf();
    		url = url.substring(0, 17);
    		if ((url.indexOf("&") >= 0)) {
    			url = url + "×tamp=" + timestamp;
    		} else {
    			url = url + "?timestamp=" + timestamp;
    		}
    		return url;
    	}
    	
    	function validate() {
    		var obj;
    		var select;
    		obj = document.getElementsByName("userType");
    		if(obj!=null) {
    			var i;
    			for(i=0; i<obj.length; i++) {
    				if(obj[i].checked)
    					select = obj[i].value;
    			}
    		}
    		var url_ = "<%=request.getContextPath()%>/validateUsername";
			$.ajax({
				url : url_,
				type : "post",
				data : {
					username : $("input[name='username']").val(),
					userType : select
				},
				success : function(data) {
					if(data == "failed") {
						alert("用户名已存在，不可以注册");
					}
					if(data == "success")
						alert("可以注册");
				}
			});
		
    	}
    </script>
    
    <script type="text/javascript">
	
</script>
</head>
<body>

<div class="container-fluid">
	<div class="span3"></div>
	<div class="span4">
	    <form name="registerForm" method="post" onsubmit="return false;">
	    	<div class="row-fluid text-right">
	    		<div class="span4">
	    			<label for="inputUserName">用户名</label>
	    		</div>
				<div class="span8">
				    <input type="text" id="inputUserName" placeholder="用户名" name="username" onblur="validate()">
				    <p id="nameDiv" class="text-warning">
				    <span id="usernameMsg"></span>
			    </div>
		    </div>
		    <div class="row-fluid text-right">
	    		<div class="span4">
	    			<label for="inputPassword">密码</label>
	    		</div>
				<div class="span8">
				    <input type="password" id="inputPassword" placeholder="密码" name="password">
				    <p id="pwdOut" class="text-warning">
			    </div>
		    </div>
		    <div class="row-fluid text-right">
	    		<div class="span4">
	    			<label>重复密码</label>
	    		</div>
				<div class="span8">
				    <input type="password" placeholder="重复密码" name="confirmPassword">
				    <p id="confirmPwd" class="text-warning">
			    </div>
		    </div>
		    <div class="row-fluid text-right">
	    		<div class="span4">
	    			<label for="inputEmail">邮箱</label>
	    		</div>
				<div class="span8">
				    <input type="text" id="inputEmail"placeholder="邮箱" name="email">
				    <p id="emailErr" class="text-warning">
			    </div>
		    </div>
		    <div class="row-fluid text-right">
		    	<div class="span4">
			    	<label>验证码</label>
			    </div>
				<div class="span8">
				    <input type="text" id="inputCode" name="code">
				    <p class="text-warning">${msg}
			    </div>
		    </div>
		    
		    <div class="row-fluid">
		    	<div class="span4">&nbsp;</div>
		    	<div class="span8">
		    		<img id="imgStamp" alt="验证码" src="code" style="margin-left: 22px">
				    <a href="#" onclick="changeImg()">换一张</a>
		    	</div>
		    </div>
		    
		    <div class="row-fluid" style="margin-top: 10px">
		    	<div class="span4"></div>
		    	<div class="span8">
		    		<div class="row-fluid  text-right">
			    		<textarea disabled="disabled">商城规则  第一章 概述  第一条  为促进开放、透明、分享、责任的新商业文明，保障酱油用户合法权益，维护酱油正常经营秩序.
			    		</textarea>
		    		</div>
		    		<div class="row-fluid">
			    		<label class="checkbox">
			    			<input type="checkbox" name="agreeCheck"> 我同意商城规定
			    		</label>
			    		<p id="checkErr" class="text-warning">
		    		</div>
		    		<div class="row-fluid">		    			
		    			<div style="display:block; float:left">
		    				<input type="radio" name="userType" value="0" checked>成为买家
			    			<!--<button id="buyer_btn" class="btn">成为买家</button> --><!-- 买家注册直接跳转登录或者发邮件验证 -->
			    		</div>
			    		<div style="display:block; float:right">
			    			<input type="radio" name="userType" value="1">成为卖家
			    		<!-- 	<button id="seller_btn" class="btn">成为卖家</button> -->
			    		</div>
		    		</div>
		    		<div class="row-fluid">			    		
			    		<br>			
			    		<button id="register" class="btn btn-large btn-primary">注册</button>
			    	</div>
		    	</div>
		    </div>
	    </form>
    </div>
</div>
</body>
</html>