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
    <style type="text/css">
		 body {
            padding-top: 20px;
            padding-bottom: 40px;
			padding-right: 20px;
          }
    </style>
    <title>评价</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/head.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2 text-info text-center" 
				style="height: 80px;background-color: #f5f5f5;padding:10px; border-radius:20px;">
				<h2><strong>付款</strong></h2>
			</div>
			<div class="span10">
				<div class="span2" style="height: 80px;text-align: center;margin-top: 25px;margin-left: 10px;">
					<button class="btn btn-large btn-danger" style="width:150px;" disabled="disabled">查看购物车 <i class="icon-hand-right icon-white"></i></button>
				</div>
				<div class="span2" style="height: 80px;text-align: center;margin-top: 25px;margin-left: 10px;">
					<button class="btn btn-large btn-danger" style="width:150px;" disabled="disabled">确认订单 <i class="icon-hand-right icon-white"></i></button>
				</div>
				<div class="span2" style="height: 80px;text-align: center;margin-top: 25px;margin-left: 10px;">
					<button class="btn btn-large btn-danger" style="width:150px;" disabled="disabled">付款 <i class="icon-hand-right icon-white"></i></button>
				</div>
				<div class="span2" style="height: 80px;text-align: center;margin-top: 25px;margin-left: 10px;">
					<button class="btn btn-large btn-danger" style="width:150px;" disabled="disabled">确认收货 <i class="icon-hand-right icon-white"></i></button>
				</div>
				<div class="span2" style="height: 80px;text-align: center;margin-top: 25px;margin-left: 10px;">
					<button class="btn btn-large btn-danger" style="width:150px;">评价</button>
				</div>
			</div>
		</div><!-- row 1 -->
		<div class="row-fluid">
			<c:if test="${empty orders}">
				<div style="text-align: center;">
					<h2>没有需要付款的订单！</h2>
				</div>
			</c:if>
			<c:if test="${!empty orders}">
				<table class="table table-hover">
	              <thead>
	                <tr>
	                  <th>商品</th>
	                  <th>商品信息</th>
	                  <th>单价</th>
	                  <th>数量</th>
	                  <th>小计</th>
	                  <th>操作</th>
	                </tr>
	              </thead>
	              <tbody>
	              	
					<c:forEach var="order" items="${orders}" varStatus="idx">
						<script>
							$(function(){
								$("#${idx.index}_sub").click(function(){
									var score   = $("#${idx.index}_score").find('option:selected').text();
									var content = $("#${idx.index}_assessText").val();
									$.ajax(
											{
												url:"<%=request.getContextPath()%>/BuyerController/assessManager?id=${order.id}",
												type:"post",
												data:{myScore:score, aContent:content},
												success:function (data){
													
													$("#${idx.index}_tr").remove();
													alert("评价成功！");
												}
											}
										);
								});
								var options={
							              backdrop:true,
							              keyboard:true,
							              show:true
							          
							          }
								$("#${idx.index}_assBtn").click(function () {
									$('#${idx.index}_myModal').modal('toggle');
								});
							
							});
						</script>
						<tr id="${idx.index}_tr">
		                  <td>${order.product.productName}</td>
		                  <td>
		                  	${order.productIllustration}
		                  </td>
		                  <td>${order.product.price}</td>
		                  <td>${order.count}</td>
		                  <td>
		                  <fmt:formatNumber value="${order.product.price * order.count}" type="currency" pattern="￥.00"/>
		                  </td>
		                  <td>
		                  	<button id="${idx.index}_assBtn" class="btn btn-danger">评价</button>
				                  	<div id="${idx.index}_myModal" class="modal hide fade">
		           						<div class="modal-header">
			          	  					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			      	   	  					<h3 id="${idx.index}_myModalLabel">评价</h3>
		    							</div>
			    						<div class="modal-body">
			    							<div class="span6">
			    								<div class="control-group">
									              <label class="control-label">评分</label>
									                  <div class="controls">
									                      <select id="${idx.index}_score" style="width:200px;">
																<option value="5">5</option>
																<option value="4">4</option>
																<option value="3">3</option>
																<option value="2">2</option>
																<option value="1">1</option>
															</select>
									                  </div>
									          	</div>
									          	<div class="control-group">
									              <label class="control-label">评价</label>
									                  <div class="controls">
									                  	<textarea rows="5" cols="20" id="${idx.index}_assessText"></textarea>
									                  </div>
									          	</div>
			    							</div>
			    							<div class="span6">
			    								<div style="width: 200px;height: 150px;">
			    									<img src="<%=request.getContextPath()%>/imgout?imgurl=${order.product.mainImgUrl}" width="180px" height="145px">
			    								</div>
			    								<div style="margin-top: 40px;">
			    									<button id="${idx.index}_sub">提交</button>
			    								</div>
			    							</div>
			    							
			    						</div>
		    						</div>
		                  </td>
		                </tr>
		                
					</c:forEach>              	
	                
	              </tbody>
	            </table>
			</c:if>
		</div><!-- row 2 -->
		<div class="row-fluid" style="margin-top: 10px;">
		</div><!-- row 3 -->
		<div class="row-fluid">
		</div><!-- row 4 -->
	</div><!-- container -->
	<footer>
    	<p class="text-center">&copy; J2ee.ustcsz.edu 2013, All Rights Reserved</p>
  	</footer>
</body>
</html>