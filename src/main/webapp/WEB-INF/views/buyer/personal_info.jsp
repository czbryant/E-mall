<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath() %>/static/css/bootstrap.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/static/js/jquery.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/static/js/bootstrap-tab.js"  type="text/javascript"></script>
 <style type="text/css">
          body {
            padding-top: 20px;
            padding-bottom: 40px;
			padding-right: 20px;
          }
          .sidebar-nav {
            padding: 9px 0;
          }
    
          @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
              float: none;
              padding-left: 5px;
              padding-right: 5px;
            }
          }
        </style>
</head>
<body>
	<div class="container-fluid hero-unit">
  	<div class="row-fluid">
    	<div class="span2">
    		<p class="text-right">用户昵称:</p>
        </div>
        <div class="span10">
        	${buyer.buyerName }
        </div>
    </div>
    <div class="row-fluid">
    	<div class="span2">
    		<p class="text-right">当前头像:</p>
        </div>
        <div class="span10">
            	<img src="<%=request.getContextPath() %>/static/images/123.jpg" style="width:150px; height:150px;">
        </div>
    </div>

    <div class="row-fluid">
    	<div class="span2">
    		<p class="text-right">邮箱:</p>
        </div>
        <div class="span10">
            ${buyer.email}
        </div>
    </div>
    <div class="row-fluid">
    	<div class="span2">
    		<p class="text-right">真实姓名:</p>
        </div>
        <div class="span10">
			${buyer.trueName }
        </div>
    </div>
    <div class="row-fluid">
    	<div class="span2">
    		<p class="text-right">性别:</p>
        </div>
        <div class="span10">
        	<c:choose>
        		<c:when test="${buyer.sex == m }">男</c:when>
        		<c:otherwise>女</c:otherwise>
        	</c:choose>
        </div>
    </div>
     <div class="row-fluid">
    	<div class="span2">
    		<p class="text-right">生日:</p>
        </div>
        <div class="span10">
			${buyer.birthday }
        </div>
    </div>
    <div class="row-fluid" style="text-align: left">
    <a href="<%=request.getContextPath() %>/BMgrLoader/loadInfoChange" target="right" class="btn btn-link btn-large" type="info_change">编辑个人资料</a>
    </div>
  </div>
</body>
</html>