<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<link href="<%=request.getContextPath() %>/static/css/bootstrap.css" rel="stylesheet">
 	<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery.js"></script> 
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap-scrollspy.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery-1.4.2.min.js"></script>
    <style type="text/css">
		 body {
            padding-top: 20px;
            padding-bottom: 40px;
			padding-right: 20px;
          }
    </style>
    <title>确认订单</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/head.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2 text-info text-center" 
				style="height: 80px;background-color: #f5f5f5;padding:10px; border-radius:20px;">
				<h2><strong>订单确认</strong></h2>
			</div>
			<div class="span10">
				<div class="span2" style="height: 80px;text-align: center;margin-top: 25px;margin-left: 100px;">
					<button class="btn btn-large btn-danger" style="width:150px;" disabled="disabled">查看购物车 <i class="icon-hand-right icon-white"></i></button>
				</div>
				<div class="span2" style="height: 80px;text-align: center;margin-top: 25px;margin-left: 10px;">
					<button class="btn btn-large btn-danger" style="width:150px;">确认订单 <i class="icon-hand-right icon-white"></i></button>
				</div>
				<div class="span2" style="height: 80px;text-align: center;margin-top: 25px;margin-left: 10px;">
					<button class="btn btn-large btn-danger" style="width:150px;" disabled="disabled">付款 <i class="icon-hand-right icon-white"></i></button>
				</div>
				<div class="span2" style="height: 80px;text-align: center;margin-top: 25px;margin-left: 10px;">
					<button class="btn btn-large btn-danger" style="width:150px;" disabled="disabled">确认收货 <i class="icon-hand-right icon-white"></i></button>
				</div>
				<div class="span2" style="height: 80px;text-align: center;margin-top: 25px;margin-left: 10px;">
					<button class="btn btn-large btn-danger" style="width:150px;" disabled="disabled">评价</button>
				</div>
			</div>
		</div><!-- row 1 -->
		<div class="row-fluid">
			<div><h4>确认收货地址</h4></div>
		</div><!-- row 2 -->
		<form action="<%=request.getContextPath()%>/BuyerController/submitOrder" method="post">
		<div class="row-fluid" style="margin-top: 10px;">
			<table class="table table-hover">
	              <tbody>
	              	<c:if test="${empty sessionScope.current_user.addrs}">
	              		<input type="text" id="addr" placeholder="请输入寄送地址" name="addr">
	              	</c:if>
	              	<c:if test="${!empty sessionScope.current_user.addrs}">
	              		<c:forEach var="addr" items="${sessionScope.current_user.addrs}">
	              			<tr>
			                  <td width="150px;">
			                  	<label class="radio">
		     							<input type="radio" name="addr_select" value="${addr.id}" checked="checked">
		   						</label>
		   					  </td>
			                  <td colspan="5">
			                  	寄送地址:${addr.receiveName}&nbsp;${addr.area }&nbsp;${addr.street}&nbsp;${addr.blanket}&nbsp;${addr.postcode}&nbsp;${addr.telNumber}
			                  </td>
			                </tr>
	              		</c:forEach>
	              	</c:if>
	                
	              </tbody>
	            </table>
		</div><!-- row 3 -->
		<div class="row-fluid">
			<div><h4>确认订单信息</h4></div>
		</div><!-- row 4 -->
		<c:if test="${empty sessionScope.orders}">
			<div class="row-fluid">
				<div class="hero-unit well" style="text-align: center;">
					<h4>您未选中任何订单！</h4>
				</div>
				<div style="text-align: center; margin-bottom: 20px;">
					<a class="btn btn-danger btn-large" onclick="window.history.back();">返回修改</a>
				</div>
			</div>
		</c:if>
		<c:if test="${!empty sessionScope.orders}">
		<div class="row-fluid">
			<table class="table table-hover">
              <thead>
                <tr>
                  <th>商品</th>
                  <th>商品信息</th>
                  <th>单价</th>
                  <th>数量</th>
                  <th>小计</th>
                </tr>
              </thead>
              <tbody>
              	
				<c:forEach var="order" items="${sessionScope.orders}">
					<tr>
	                  <td>${order.product.productName}</td>
	                  <td>
	                  	${order.productIllustration}
	                  </td>
	                  <td>${order.product.price}</td>
	                  <td>${order.count}</td>
	                  <td>
	                  <fmt:formatNumber value="${order.product.price * order.count}" type="currency" pattern="￥.00"/>
	                  </td>
	                </tr>
				</c:forEach>              	
                
              </tbody>
            </table>
            
		</div><!-- row 5 -->
		<div class="text-right">
			<a href="<%=request.getContextPath()%>/toMyCart" class="btn btn-info">返回购物车</a>
			<input class="btn btn-danger" type="submit" value="提交订单">
		</div><!-- row 6 -->
		</c:if>
		</form>
	</div><!-- container -->
	<footer>
    	<p class="text-center">&copy; J2ee.ustcsz.edu 2013, All Rights Reserved</p>
  	</footer>
</body>
</html>