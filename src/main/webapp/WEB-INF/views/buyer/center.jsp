<%--
	author:ytwang
	date:2014/1/26
	version:1.0 
 --%>
<%@page import="ustc.sse.water.pojo.BasketItem"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath() %>/static/css/bootstrap.css" rel="stylesheet">
        <link href="<%=request.getContextPath() %>/static/css/bootstrap-responsive.css" rel="stylesheet">
        <style type="text/css">
          body {
            padding-top: 5px;
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
</head>
<body>
	<div class="container-fluid">
        	<div class="row-fluid text-center text-info" >
            	<h3>最近购买</h3>
            </div><!--/row-->
            <div class="row-fluid" style="border:1px solid #9FF">
            <c:if test="${empty requestScope.recentBuyList}">
            	<div>你还未在商城购买物品！</div>
            </c:if>
            <c:if test="${!empty requestScope.recentBuyList}">
            	<c:forEach var="recentBuy" items="${requestScope.recentBuyList}">
            		<div class="span3">
                	<a href="#" class="thumbnail">
                		<img src="<%=request.getContextPath() %>/imgout?imgurl=${recentBuy.product.mainImgUrl}" style="width:150px; height:150px;">
                    </a>
                </div><!--/span-->
            	</c:forEach>
            </c:if>
        	</div><!--/row-->
            <div class="row-fluid" style="margin-top:30px;">
            	<div class="span6" style="border:1px solid #9FF; height: 230px;">
                	<div class="text-center text-info">
                    	<p class=""><h3>我的收藏</h3></p>
                    </div>
                    <c:if test="${empty collections}">
                    	<div style="text-align: center;">
                			<h2>您还没有任何收藏！</h2>
                		</div>
                    </c:if>
                    <c:if test="${!empty collections}">
                    	<c:forEach var="pro" items="${collections}">
                    		<div class="span4" style="margin-bottom:5px; margin-left:5px; margin-top:5px;">
                			<a href="#" class="thumbnail">
                				<img src="<%=request.getContextPath()%>/imgout?imgurl=${pro.mainImgUrl}" style="width:150px; height:150px;">
                    		</a>
                		</div><!--/span-->
                    	</c:forEach>
                    </c:if>
                </div><!--/span-->
                <div class="span6" style="border:1px solid #9FF;height: 230px;">
                	<div class="text-center text-info"><h3>我的购物车</h3></div>
                	<c:if test="${empty buyerSmallCart}">
                		<div style="text-align: center;">
                			<h2>你的购物车里面没有商品，赶快去购买吧！</h2>
                		</div>
                	</c:if>
                	<c:if test="${!empty buyerSmallCart}">
	                   	<c:forEach var="item" items="${buyerSmallCart}">
	                   		<div class="span3">
		                   		<a href="<%=request.getContextPath()%>/toDetail?id=${item.product.productId}" class="thumbnail" target="_top">
		              				<img src="<%=request.getContextPath()%>/imgout?imgurl=${item.product.mainImgUrl}" style="width:150px; height:150px;">
		                  		</a>
	                  		</div><!--/span-->
	                   	</c:forEach>
                   	</c:if>
                </div><!--/span-->
            </div><!--/row-->
            <div class="row-fluid">
            	<div class="text-center text-info span12" style="margin-top:30px; margin-bottom:15px; border:#9FF solid 1px; height: 250px;"><h3>我的浏览记录</h3>
                    <c:if test="${empty requestScope.recentView}">
                    	<p>暂无记录！</p>
                    </c:if>
                    <c:if test="${!empty requestScope.recentView}">
                    	<c:forEach var="recentViewPro" items="${requestScope.recentView}">
                    		<div class="span2">
                    			<a href="<%=request.getContextPath()%>/toDetail?id=${recentViewPro.productId}" class="thumbnail">
                    				<img src="<%=request.getContextPath()%>/imgout?imgurl=${recentViewPro.mainImgUrl}" style="width:150px; height:150px;">
                    			</a>
                    		</div>
                    	</c:forEach>
                    </c:if>
                </div>                                               
            </div><!--/row-->
       </div><!--container-->
</body>
</html>