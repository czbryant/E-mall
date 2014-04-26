<%@page import="ustc.sse.water.pojo.Image"%>
<%@page import="ustc.sse.water.constants.CommonConstant"%>
<%@page import="ustc.sse.water.pojo.Buyer"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/static/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
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
    <link href="<%=request.getContextPath()%>/static/css/bootstrap-responsive.css" rel="stylesheet">
</head>
<body>
	<form action="<%=request.getContextPath()%>/search" method="post" target="_top">
	<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#">酱油网</a>
          <div class="nav-collapse collapse">
            <p class="navbar-text pull-right">
	            <%
	            	String path = request.getContextPath();
	            	            Image img = (Image) request.getAttribute("img");
	            	            request.getSession().setAttribute("img", img);
	            %>
	            <c:set var="path" value="<%=path%>" scope="page"/>
	            <c:choose>
	            	<c:when test="${empty sessionScope.current_user}">
	            		<a href="${path}/tologin" class="navbar-link">登录</a>
	            		<a href="${path}/toregister" class="navbar-link">注册</a>
	            	</c:when>
	            	<c:otherwise>
	            		Hi! <a <%-- href="${path}/BuyerController/toBuyerMgr" --%> class="navbar-link">${sessionScope.current_user.username}</a>|
	            		<a href="${path}/BuyerController/logout" class="navbar-link" target="_top">注销</a>
	            	</c:otherwise>
	            </c:choose>
            </p>
            <ul class="nav">
              <li class="active"><a href="<%=request.getContextPath()%>" target="_top">主页</a></li>
              <li><a href="<%=request.getContextPath()%>/toMyCart" target="_top">购物车</a></li>
               <li><a href="#">收藏夹</a></li>
              <li><a href="#">关于我们</a></li>
              <li>
              	<input type="text" class="input-medium search-query input-small" style="margin-top: 5px;" name="productname">
				<button type="submit" class="btn btn-small">Search</button>
              </li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
    </form>
</body>
</html>