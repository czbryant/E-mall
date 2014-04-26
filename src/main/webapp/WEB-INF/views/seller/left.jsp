<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>我的主页</title>
    <script type="text/javascript">
		function showcontent(content){  
   				$('#content').load(content + '.html');
			} 
    </script>
    <style type="text/css">
		div#box {
			height: 150px;
			width: 150px;
			float: left;
			}
    </style>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery.js"></script>
        <!-- Le styles -->
        <link href="<%=request.getContextPath() %>/static/css/bootstrap3.min.css" rel="stylesheet">
        <style type="text/css">
          body {
            padding-top:1px;
            padding-bottom: 40px;
          }
          .sidebar-nav {
            padding: 0px 0;
          }
		  .list-group-item {
			  font-size:12px;
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
	<div class="container">
      <div class="row">
		<div class="col-md-3" id="sidebar" role="navigation">
              <div class="list-group">
                <a class="list-group-item active" data-collapsed="">店铺管理</a>
                <a href="<%=request.getContextPath() %>/SMgrLoader/loadCenter" target="right" class="list-group-item">我的动态</a>
                <c:choose>
                	<c:when test="${ empty shop}">
                		<a href="<%=request.getContextPath() %>/SMgrLoader/editSellerInfo" target="right" class="list-group-item">资料修改</a>
                	</c:when>
                	<c:otherwise>
                		<a href="<%=request.getContextPath() %>/SMgrLoader/loadMyShop" target="right" class="list-group-item">店铺预览</a>
		                <a href="<%=request.getContextPath() %>/SMgrLoader/loadProductMgr" target="right" class="list-group-item">商品管理</a>
		                <a href="<%=request.getContextPath() %>/SMgrLoader/loadTradeMgr" target="right" class="list-group-item">交易管理</a>
		                <a href="<%=request.getContextPath() %>/SMgrLoader/editSellerInfo" target="right" class="list-group-item">资料修改</a>
		                <!-- <a href="<%=request.getContextPath() %>/SMgrLoader/loadImgSpace" target="right" class="list-group-item">图片空间</a>-->
		                	                                
		                <a class="list-group-item active">客户服务</a>
		                <!-- <a href="<%=request.getContextPath() %>/SMgrLoader/loadCourier" target="right" class="list-group-item">快递管理</a> -->
		                <a href="<%=request.getContextPath() %>/SMgrLoader/loadCancelMgr" target="right" class="list-group-item">退款处理</a>
		                <a href="<%=request.getContextPath() %>/SMgrLoader/loadService" target="right" class="list-group-item">售后管理</a>
                	</c:otherwise>
                </c:choose>                
                
              </div>
            </div><!--/span-->
      </div><!--/row-->
     </div>
</body>
</html>