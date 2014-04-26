<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh">
<head>
 <meta>
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="<%=request.getContextPath()%>/static/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }

      .form-signin {
        max-width: 300px;
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }

    </style>
    <link href="<%=request.getContextPath()%>/static/css/bootstrap-responsive.css" rel="stylesheet">

	<script type="text/javascript">
		function buyerLogin(){
			document.loginform.action = "<%=request.getContextPath()%>/BuyerController/login";
			document.loginform.submit();
		}
		
		function sellerLogin(){
			document.loginform.action="<%=request.getContextPath()%>/SellerController/login";
			document.loginform.submit();
		}
		
		function register(){
			document.loginform.action="<%=request.getContextPath()%>/toregister";
			document.loginform.submit();
		}
		
	</script>

    <!-- Fav and touch icons 
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/static/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/static/ico/apple-touch-icon-114-precomposed.png">
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/static/ico/apple-touch-icon-72-precomposed.png">
                    <link rel="apple-touch-icon-precomposed" href="/static/ico/apple-touch-icon-57-precomposed.png">
                                   <link rel="shortcut icon" href="/static/ico/favicon.png">-->
</head>
<script language="javascript">
	var XMLHttpReq = false;
	function createXMLHttpRequest(){
		if(window.XMLHttpRequest){
			XMLHttpReq = new XMLHttpRequest();
		}
		else if(window.ActiveXObject){
			try{
				XMLHttpReq = new ActiveXObject("Msxm12.XMLHTTP");
			}catch(e){
				try{
					XMLHttpReq = new ActiveObject("Microsoft.XMLHTTP");
				}catch(e){}
			}
		}
	}
	function sendRequest(url){
		createXMLHttpRequest();
		XMLHttpReq.open("GET",url,true);
		XMLHttpReq.onreadystatechange = processResponse;
		XMLHttpReq.send(null);
	}
	function processResponse(){
		if(XMLHttpReq.readyState == 4){
			if(XMLHttpReq.status == 200){
				var res = XMLHttpReq.responseXML.getElementsByTagName("res")[0].firstChild.data;
				window.alert(res);
			}else{
				window.alert("您所请求页面不存在");
			}
		}
	}
	function userCheck(){
		var uname = document.myform.uname.value;
		var psw = document.myform.psw.value;
		if(uname==""){
			window.alert("");
			document.myform.uname.focus();
			return false;
		}
		else{
			sendRequest('login');
		}
	}
</script>
<body>
	 <div class="container">

      <form class="form-signin" name="loginform" method="post">
        <h2 class="form-signin-heading">请登录</h2>
        <p class="text-danger">
        	${msg}
        </p>
        <input type="text" id="nameInput" class="input-block-level" placeholder="UserName" name="username">
        <div id="d" style="display:none; background:#999900;"></div>
        <input type="password" class="input-block-level" placeholder="Password" name="password">
        <label class="checkbox">
          <input type="checkbox" value="remember-me"> Remember me
        </label>
        <button class="btn btn-primary" onclick="buyerLogin();">Buyer</button>
        <button class="btn btn-primary" onclick="sellerLogin();">Seller</button>
        <button class="btn btn-info" onclick="register()">Register</button>
      </form>

    </div> <!-- /container -->

	<script type="text/javascript">
		var name = document.getElementById("nameInput");
		function nameCheck(){
			d.style.dispay = 'block';
			if(name.value.match(/^\w+/)){
				d.innerHTML = "dui";
			} else {
				d.innerHTML = "cuo";
			}
		}
	</script>
    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/static/js/jquery.js"></script>
    <script src="/static/js/bootstrap-transition.js"></script>
    <script src="/static/js/bootstrap-alert.js"></script>
    <script src="/static/js/bootstrap-modal.js"></script>
    <script src="/static/js/bootstrap-dropdown.js"></script>
    <script src="/static/js/bootstrap-scrollspy.js"></script>
    <script src="/static/js/bootstrap-tab.js"></script>
    <script src="/static/js/bootstrap-popover.js"></script>
    <script src="/static/js/bootstrap-tooltip.js"></script>
    <script src="/static/js/bootstrap-button.js"></script>
    <script src="/static/js/bootstrap-collapse.js"></script>
    <script src="/static/js/bootstrap-carousel.js"></script>
    <script src="/static/js/bootstrap-typeahead.js"></script>
</body>
</html>