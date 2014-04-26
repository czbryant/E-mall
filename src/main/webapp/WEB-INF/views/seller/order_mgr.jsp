<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Fonts -->
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,300italic,400italic,500,700,900,700italic,500italic' rel='stylesheet' type='text/css'>

<!-- Stylesheets -->

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/perfect-scrollbar.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/flexslider.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/fontello.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/css/settings.css" media="screen" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/animation.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/jquery.fancybox.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/owl.carousel.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/owl.theme.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/chosen.css">

<link href="<%=request.getContextPath() %>/static/css/bootstrap.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/static/js/jquery.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/static/js/bootstrap.js"  type="text/javascript"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap-scrollspy.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery-1.4.2.min.js"></script>
    <style type="text/css">
          body {
            padding-top: 20px;
            padding-bottom: 40px;
			padding-right: 20px;
          }
          .sidebar-nav {
            padding: 9px 0;
          }
		  .fade {
			opacity: 0;
			-webkit-transition: opacity 0.15s linear;
			-moz-transition: opacity 0.15s linear;
			-o-transition: opacity 0.15s linear;
			transition: opacity 0.15s linear;
		}
		.fade.in {
			opacity: 1;
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
   
<title>Insert title here</title>
</head>
<body>
<div class="container">
								
			<div class="col-lg-12 col-md-12 col-sm-12">
								
				<div class="tabs">
								
					<div class="tab-heading">
						<a href="#tab1" class="button small">待发货订单</a>
						<a href="#tab2" class="button small">待付款订单</a>
						<a href="#tab3" class="button small">待确认订单</a>
						<a href="#tab4" class="button small">成功订单</a>
						<a href="#tab5" class="button small">失败订单</a>
						<!-- <a href="#tab6" class="button small">所有订单</a> -->
					</div>
									
				<div class="page-content tab-content">
										
					<div id="tab1">
					
                    <div class="row">
                    	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	
                            <table class="order-table">
                            	
                                <tr>
                                	<td><p>订单</p></td>
                                	<td><p>订单编号</p></td>
                                	<td><p>下单时间</p></td>
                                    <td><p>买家用户</p></td>
                                    <td><p>订单状态</p></td>
                                    <td><p>操作</p></td>
                                </tr>
                                <c:forEach var="order" items="${orders }" varStatus="idx">
                                                                
                                <c:if test="${order.orderStatus==1 }">
                                <script>
								$(function(){
									
									$("#${idx.index}_postBtn").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/SellerController/postGoods?id=${order.orderID}",
													type:"post",
													data:{orderId:"${order.orderID}", logistics:$("#${idx.index}_tr_logistics").val()},
													success:function (data){
														alert("发货成功");
														$("#${idx.index}_tr").remove();
													}
												}
											);
									});
									
									$('#${idx.index}_postGoods').click(function(){
							              $('#${idx.index}_myModal').modal('toggle');
							          });
									
									$('#${idx.index}_order_post').click(function(){
							              $('#${idx.index}_postModal').modal('toggle');
							          });
									
								});
								
								 var options={
							              backdrop:true,
							              keyboard:true,
							              show:true
							          
							          }
								</script>
								
						        <tr id="${idx.index}_tr">
                                	<td>
                                    	<p>${idx.count}</p>                                       
                                    </td>
                                	<td class="order-number">
                                    	<p><a id="${idx.index}_order_post" href="#">${order.orderID}</a></p> 
                                    	
                                    	<div id="${idx.index}_postModal" class="modal hide fade">
								           <div class="modal-header">
								          	  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
								      	   	  <h3 id="myModalLabel">订单详情</h3>
								    	</div>
								    	<div class="modal-body">
									      <table class="order-table">
									      	<tr>
									      		<td>订单号</td>
									      		<td>${order.orderID }</td>
									      	</tr>
									      	<tr>
									      		<td>订单状态</td>
									      		<td>已付款，等待发货</td>
									      	</tr>
									      	<tr>
									      		<td>买家用户名</td>
									      		<td>${order.buyer.username }</td>
									      	</tr>
									      	<tr>
									      		<td>买家联系电话</td>
									      		<td>${order.buyer.telNum }</td>
									      	</tr>
									      	<tr>
									      		<td>送货地址</td>
									      		<td>${order.receiveInfo }</td>
									      	</tr>
									      	<tr>
									      		<td>商品名称</td>
									      		<td>${order.product.productName }</td>
									      	</tr>
									      	<tr>
									      		<td>商品编号</td>
									      		<td>${order.product.productId }</td>
									      	</tr>
									      	<tr>
									      		<td>购买数量</td>
									      		<td>${order.count }</td>
									      	</tr>
									      	<tr>
									      		<td>价格总计</td>
									      		<td>
									      		<fmt:formatNumber value="${order.product.price * order.count}" type="currency" pattern="￥.00"/>
									      		</td>
									      	</tr>
									      	<tr>
									      		<td>订单提交时间</td>
									      		<td>${order.postTime }</td>
									      	</tr>
									      	<tr>
									      		<td>订单更新时间</td>
									      		<td>${order.updateTime}</td>
									      	</tr>
									      										      	
									      </table>	
									      </div>
								</div>                                     
                                    </td>
                                    <td>
                                    	<p>${order.postTime}</p>                                      
                                    </td>
                                    <td>
                                    	<p>${order.buyer.username }</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.orderStatus}</p>                                       
                                    </td>                                    
                                    <td>
                                    	                                   	                        
                                        <a href="#">									              
                                            <span id="${idx.index}_postGoods" class="add-to-cart">
                                                <span class="action-wrapper">
                                                    <span class="action-name">发货</span>
                                                </span>
                                            </span>
                                            
                                        </a>
                                        <div id="${idx.index}_myModal" class="modal hide fade">
								           <div class="modal-header">
								          	  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
								      	   	  <h3 id="myModalLabel">立即发货</h3>
								    	</div>
								    	<div class="modal-body">
									      <form class="form-horizontal">
									          <div class="control-group">
									              <label class="control-label">收件人</label>
									                  <div class="controls">
									                      <input type="text" id="buyerName" placeholder="${order.buyer.username }" name="buyerName" disabled="disabled">
									                  </div>
									          </div>
									          <div class="control-group">
									              <label class="control-label">收件人信息</label>
									                  <div class="controls">
									                      <input type="text" id="buyerInfo" placeholder="${order.receiveInfo }" name="buyerInfo">
									                  </div>
									          </div>
									          
									          <div class="control-group">
									              <label class="control-label">选择物流</label>
									                  <div class="controls">
									                      <select id="${idx.index}_tr_logistics" name="logistics">
																				 <option value="1" selected>申通物流</option>													
																				<option value="2">韵达物流</option>
																				<option value="3">EMS物流</option>
																				<option value="4">顺丰物流</option>
																				</select>
									                  </div>
									          </div>
									          <div class="control-group">
									              <label class="control-label">发货人</label>
									                  <div class="controls">
									                      <input type="text" id="sellerName" placeholder="${seller.username }" name="sellerName">
									                  </div>
									          </div>
									          <div class="control-group">
									              <label class="control-label">发货人电话</label>
									                  <div class="controls">
									                      <input type="text" id="sellerTel" placeholder="${seller.telNum }" name="sellerTel">
									                  </div>
									          </div>
									          <div class="control-group">
									              <label class="control-label">发货人地址</label>
									                  <div class="controls">
									                      <input type="text" id="sellerAddr" placeholder="${seller.localAddr }" name="sellerAddr">
									                  </div>
									          </div>
									          <div class="control-group">
									                  <div class="controls">
									                      <a href="#">
														              	<span class="add-to-cart">
							                                                <span class="action-wrapper">
							                                                    
							                                                    <span class="action-name" id="${idx.index}_postBtn">发货</span>									               									         									                                                                                                       
							                                                </span>
							                                            </span></a>
									                     </div>
									          </div>
									      </form>
									      </div>
									      </div>
									      
									      
								
                                    </td>
                                    
                                </tr>
                                </c:if>                                                                                                                           
                                </c:forEach>
                            </table>
                            
                        </div>
                     </div>
                                      
				</div>							
																																
										
				<div id="tab2">
					
                    <div class="row">
                    	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	
                            <table class="order-table">
                            	
                                <tr>
                                	<td><p>订单</p></td>
                                	<td><p>订单编号</p></td>
                                	<td><p>商品名称</p></td>
                                	<td><p>下单时间</p></td>
                                    <td><p>买家用户</p></td>
                                    <td><p>订单状态</p></td>
                                    
                                </tr>
                                <c:forEach var="order" items="${orders }" varStatus="idx">
                                <c:if test="${order.orderStatus == 0}">
                                <script>
								$(function(){
								
									
									$('#${idx.index}_order_nopay').click(function(){
							              $('#${idx.index}_nopayModal').modal('toggle');
							          });
									
								});
								
								 var options={
							              backdrop:true,
							              keyboard:true,
							              show:true
							          
							          }
								</script>
                                <tr>
                                	<td>
                                    	<p>${idx.count}</p>                                       
                                    </td>
                                	<td class="order-number">
                                    	<p><a id="${idx.index}_order_nopay" href="#">${order.orderID}</a></p>
                                    	
                                    	 <div id="${idx.index}_nopayModal" class="modal hide fade">
								           <div class="modal-header">
								          	  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
								      	   	  <h3 id="myModalLabel">订单详情</h3>
								    	</div>
								    	<div class="modal-body">
									      <table class="order-table">
									      	<tr>
									      		<td>订单号</td>
									      		<td>${order.orderID }</td>
									      	</tr>
									      	<tr>
									      		<td>订单状态</td>
									      		<td>已下订单，等待付款</td>
									      	</tr>
									      	<tr>
									      		<td>买家用户名</td>
									      		<td>${order.buyer.username }</td>
									      	</tr>
									      	<tr>
									      		<td>买家联系电话</td>
									      		<td>${order.buyer.telNum }</td>
									      	</tr>
									      	<tr>
									      		<td>送货地址</td>
									      		<td>${order.receiveInfo }</td>
									      	</tr>
									      	<tr>
									      		<td>商品名称</td>
									      		<td>${order.product.productName }</td>
									      	</tr>
									      	<tr>
									      		<td>商品编号</td>
									      		<td>${order.product.productId }</td>
									      	</tr>
									      	<tr>
									      		<td>购买数量</td>
									      		<td>${order.count }</td>
									      	</tr>
									      	<tr>
									      		<td>价格总计</td>
									      		<td>
									      		<fmt:formatNumber value="${order.product.price * order.count}" type="currency" pattern="￥.00"/>
									      		</td>
									      	</tr>
									      	<tr>
									      		<td>订单提交时间</td>
									      		<td>${order.postTime }</td>
									      	</tr>
									      	<tr>
									      		<td>订单更新时间</td>
									      		<td>${order.updateTime}</td>
									      	</tr>
									      										      	
									      </table>	
									      </div>
								</div>                                      
                                    </td>
                                    <td>
                                    	<p>${order.product.productName}</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.postTime}</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.buyer.username }</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.orderStatus}</p>                                       
                                    </td>                                    
                                   
                                </tr>
                                </c:if>                                                                                                                           
                                </c:forEach>
                            </table>
                            
                        </div>
                     </div>
                    										
											
				</div>
				<div id="tab3">
					
                    <div class="row">
                    	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	
                            <table class="order-table">
                            	
                                <tr>
                                	<td><p>订单</p></td>
                                	<td><p>订单编号</p></td>
                                	<td><p>商品名称</p></td>
                                	<td><p>下单时间</p></td>
                                    <td><p>买家用户</p></td>
                                    <td><p>订单状态</p></td>
                                    
                                </tr>
                                <c:forEach var="order" items="${orders }" varStatus="idx">
                                <c:if test="${order.orderStatus == 2}">
                                 <script>
								$(function(){
								
									$('#${idx.index}_order_check').click(function(){
							              $('#${idx.index}_checkModal').modal('toggle');
							          });
									
								});
								
								 var options={
							              backdrop:true,
							              keyboard:true,
							              show:true
							          
							          }
								</script>
                                <tr>
                                	<td>
                                    	<p>${idx.count}</p>                                       
                                    </td>
                                	<td class="order-number">
                                    	<p><a id="${idx.index}_order_check" href="#">${order.orderID}</a></p> 
                                    	
                                    	
                                        <div id="${idx.index}_checkModal" class="modal hide fade">
								           <div class="modal-header">
								          	  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
								      	   	  <h3 id="myModalLabel">订单详情</h3>
								    	</div>
								    	<div class="modal-body">
									      <table class="order-table">
									      	<tr>
									      		<td>订单号</td>
									      		<td>${order.orderID }</td>
									      	</tr>
									      	<tr>
									      		<td>订单状态</td>
									      		<td>已发货，等待确认收货</td>
									      	</tr>
									      	<tr>
									      		<td>买家用户名</td>
									      		<td>${order.buyer.username }</td>
									      	</tr>
									      	<tr>
									      		<td>买家联系电话</td>
									      		<td>${order.buyer.telNum }</td>
									      	</tr>
									      	<tr>
									      		<td>送货地址</td>
									      		<td>${order.receiveInfo }</td>
									      	</tr>
									      	<tr>
									      		<td>商品名称</td>
									      		<td>${order.product.productName }</td>
									      	</tr>
									      	<tr>
									      		<td>商品编号</td>
									      		<td>${order.product.productId }</td>
									      	</tr>
									      	<tr>
									      		<td>购买数量</td>
									      		<td>${order.count }</td>
									      	</tr>
									      	<tr>
									      		<td>价格总计</td>
									      		<td>
									      		<fmt:formatNumber value="${order.product.price * order.count}" type="currency" pattern="￥.00"/>
									      		</td>
									      	</tr>
									      	<tr>
									      		<td>物流单号</td>
									      		<td>${order.logisticsId }</td>
									      	</tr>
									      	<tr>
									      		<td>物流公司</td>
									      		<td>
									      		<c:choose>
									      			<c:when test="${order.conveyType==1 }">申通物流</c:when>
									      			<c:when test="${order.conveyType==2 }">韵达物流</c:when>
									      			<c:when test="${order.conveyType==3 }">EMS物流</c:when>
									      			<c:when test="${order.conveyType==4 }">顺丰物流</c:when>
									      			<c:otherwise>其他物流</c:otherwise>	
									      		</c:choose></td>
									      	</tr>
									      	<tr>
									      		<td>订单提交时间</td>
									      		<td>${order.postTime }</td>
									      	</tr>
									      	<tr>
									      		<td>订单更新时间</td>
									      		<td>${order.updateTime}</td>
									      	</tr>
									      										      	
									      </table>	
									      </div>
								</div>                                     
                                    </td>
                                    <td>
                                    	<p>${order.product.productName}</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.postTime}</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.buyer.username }</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.orderStatus}</p>                                       
                                    </td>                                    
                                    
                                </tr>
                                </c:if>                                                                                                                           
                                </c:forEach>
                            </table>
                            
                        </div>
                     </div>
                    
                   										
											
				</div>
				<div id="tab4">
					
                    <div class="row">
                    	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	
                            <table class="order-table">
                            	
                                <tr>
                                	<td><p>订单</p></td>
                                	<td><p>订单编号</p></td>
                                	<td><p>商品名称</p></td>
                                	<td><p>下单时间</p></td>
                                    <td><p>买家用户</p></td>
                                    <td><p>订单状态</p></td>
                                    
                                </tr>
                                <c:forEach var="order" items="${orders }" varStatus="idx">
                                <c:if test="${order.orderStatus == 3 or order.orderStatus == 4}">
                                <script>
								$(function(){
								
									$('#${idx.index}_order_succ').click(function(){
							              $('#${idx.index}_succModal').modal('toggle');
							          });
								});
								
								 var options={
							              backdrop:true,
							              keyboard:true,
							              show:true
							          
							          }
								</script>
                                <tr>
                                	<td>
                                    	<p>${idx.count}</p>                                       
                                    </td>
                                	<td class="order-number">
                                    	<p><a id="${idx.index}_order_succ" href="#">${order.orderID}</a></p> 
                                    	
                                    	<div id="${idx.index}_succModal" class="modal hide fade">
								           <div class="modal-header">
								          	  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
								      	   	  <h3 id="myModalLabel">订单详情</h3>
								    	</div>
								    	<div class="modal-body">
									      <table class="order-table">
									      	<tr>
									      		<td>订单号</td>
									      		<td>${order.orderID }</td>
									      	</tr>
									      	<tr>
									      		<td>订单状态</td>
									      		<td>交易成功</td>
									      	</tr>
									      	<tr>
									      		<td>买家用户名</td>
									      		<td>${order.buyer.username }</td>
									      	</tr>
									      	<tr>
									      		<td>买家联系电话</td>
									      		<td>${order.buyer.telNum }</td>
									      	</tr>
									      	<tr>
									      		<td>送货地址</td>
									      		<td>${order.receiveInfo }</td>
									      	</tr>
									      	<tr>
									      		<td>商品名称</td>
									      		<td>${order.product.productName }</td>
									      	</tr>
									      	<tr>
									      		<td>商品编号</td>
									      		<td>${order.product.productId }</td>
									      	</tr>
									      	<tr>
									      		<td>购买数量</td>
									      		<td>${order.count }</td>
									      	</tr>
									      	<tr>
									      		<td>价格总计</td>
									      		<td>
									      		<fmt:formatNumber value="${order.product.price * order.count}" type="currency" pattern="￥.00"/>
									      		</td>
									      	</tr>
									      	<tr>
									      		<td>物流单号</td>
									      		<td>${order.logisticsId }</td>
									      	</tr>
									      	<tr>
									      		<td>物流公司</td>
									      		<td>
									      		<c:choose>
									      			<c:when test="${order.conveyType==1 }">申通物流</c:when>
									      			<c:when test="${order.conveyType==2 }">韵达物流</c:when>
									      			<c:when test="${order.conveyType==3 }">EMS物流</c:when>
									      			<c:when test="${order.conveyType==4 }">顺丰物流</c:when>
									      			<c:otherwise>其他物流</c:otherwise>	
									      		</c:choose></td>
									      	</tr>
									      	<tr>
									      		<td>订单提交时间</td>
									      		<td>${order.postTime }</td>
									      	</tr>
									      	<tr>
									      		<td>订单更新时间</td>
									      		<td>${order.updateTime}</td>
									      	</tr>
									      										      	
									      </table>	
									      </div>
								</div>                                     
                                    </td>
                                    <td>
                                    	<p>${order.product.productName}</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.postTime}</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.buyer.username }</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.orderStatus}</p>                                       
                                    </td>                                    
                                    
                                </tr>
                                </c:if>                                                                                                                           
                                </c:forEach>
                            </table>
                            
                        </div>
                     </div>
                    					
				</div>
				<div id="tab5">
					
                    <div class="row">
                    	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	
                            <table class="order-table">
                            	
                                <tr>
                                	<td><p>订单</p></td>
                                	<td><p>订单编号</p></td>
                                	<td><p>下单时间</p></td>
                                    <td><p>买家用户</p></td>
                                    <td><p>订单状态</p></td>
                                    
                                </tr>
                                <c:forEach var="order" items="${orders }" varStatus="idx">
                                <c:if test="${order.orderStatus == -1}">
                                <script>
								$(function(){
								
									$('#${idx.index}_order_failure').click(function(){
							              $('#${idx.index}_failureModal').modal('toggle');
							          });
								});
								
								 var options={
							              backdrop:true,
							              keyboard:true,
							              show:true
							          
							          }
								</script>
                                <tr>
                                	<td>
                                    	<p>${idx.count}</p>                                       
                                    </td>
                                	<td class="order-number">
                                    	<p><a id="${idx.index}_order_failure" href="#">${order.orderID}</a></p>
                                    	
                                    	<div id="${idx.index}_failureModal" class="modal hide fade">
								           <div class="modal-header">
								          	  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
								      	   	  <h3 id="myModalLabel">订单详情</h3>
								    	</div>
								    	<div class="modal-body">
									      <table class="order-table">
									      	<tr>
									      		<td>订单号</td>
									      		<td>${order.orderID }</td>
									      	</tr>
									      	<tr>
									      		<td>订单状态</td>
									      		<td>交易失败</td>
									      	</tr>
									      	<tr>
									      		<td>买家用户名</td>
									      		<td>${order.buyer.username }</td>
									      	</tr>
									      	<tr>
									      		<td>买家联系电话</td>
									      		<td>${order.buyer.telNum }</td>
									      	</tr>
									      	<tr>
									      		<td>送货地址</td>
									      		<td>${order.receiveInfo }</td>
									      	</tr>
									      	<tr>
									      		<td>商品名称</td>
									      		<td>${order.product.productName }</td>
									      	</tr>
									      	<tr>
									      		<td>商品编号</td>
									      		<td>${order.product.productId }</td>
									      	</tr>
									      	<tr>
									      		<td>购买数量</td>
									      		<td>${order.count }</td>
									      	</tr>
									      	<tr>
									      		<td>价格总计</td>
									      		<td>
									      		<fmt:formatNumber value="${order.product.price * order.count}" type="currency" pattern="￥.00"/>
									      		</td>
									      	</tr>
									      	<tr>
									      		<td>物流单号</td>
									      		<td>${order.logisticsId }</td>
									      	</tr>
									      	<tr>
									      		<td>物流公司</td>
									      		<td>
									      		<c:choose>
									      			<c:when test="${order.conveyType==1 }">申通物流</c:when>
									      			<c:when test="${order.conveyType==2 }">韵达物流</c:when>
									      			<c:when test="${order.conveyType==3 }">EMS物流</c:when>
									      			<c:when test="${order.conveyType==4 }">顺丰物流</c:when>
									      			<c:otherwise>其他物流</c:otherwise>	
									      		</c:choose></td>
									      	</tr>
									      	<tr>
									      		<td>订单提交时间</td>
									      		<td>${order.postTime }</td>
									      	</tr>
									      	<tr>
									      		<td>订单更新时间</td>
									      		<td>${order.updateTime}</td>
									      	</tr>
									      										      	
									      </table>	
									      </div>
								</div>                                      
                                    </td>
                                    <td>
                                    	<p>${order.postTime}</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.buyer.username }</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.orderStatus}</p>                                       
                                    </td>                                    
                                    
                                </tr>
                                </c:if>                                                                                                                           
                                </c:forEach>
                            </table>
                            
                        </div>
                     </div>
                   										
											
				</div>
				<!--<div id="tab6">
					<div class="row">
						
                        <div class="col-lg-6 col-md-6 col-sm-6">
                        	<div class="pagination">
                            	<a href="#"><div class="previous"><i class="icons icon-left-dir"></i></div></a>
                                <a href="#"><div class="page-button">1</div></a>
                                <a href="#"><div class="page-button">2</div></a>
                                <a href="#"><div class="page-button">3</div></a>
                                <a href="#"><div class="next"><i class="icons icon-right-dir"></i></div></a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                    	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	
                            <table class="order-table">
                            	
                                <tr>
                                	<td><p>订单</p></td>
                                	<td><p>订单编号</p></td>
                                	<td><p>下单时间</p></td>
                                    <td><p>更新时间</p></td>
                                    <td><p>订单状态</p></td>
                                    <td><p>操作</p></td>
                                </tr>
                                <c:forEach var="order" items="${orders }" varStatus="status">
                                
                                <tr>
                                	<td>
                                    	<p>${status.count}</p>                                       
                                    </td>
                                	<td class="order-number">
                                    	<p><a href="#">${order.orderID}</a></p>                                      
                                    </td>
                                    <td>
                                    	<p>${order.postTime}</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.updateTime}</p>                                       
                                    </td>
                                    <td>
                                    	<p>${order.orderStatus}</p>                                       
                                    </td>                                    
                                    <td class="wishlist-actions">                                       
                                        <a href="#">
                                            <span class="add-to-cart">
                                                <span class="action-wrapper">
                                                    <i class="icons icon-dollar"></i>
                                                    <span class="action-name">查看</span>
                                                </span>
                                            </span>
                                        </a>
                                        <a href="#">
                                            <span class="add-to-trash">
                                                <span class="action-wrapper">
                                                    <i class="icons icon-trash-8"></i>
                                                    <span class="action-name">删除</span>
                                                </span>
                                            </span>
                                        </a>
                                    </td>
                                </tr>
                                                                                                                                                         
                                </c:forEach>
                            </table>
                            
                        </div>
                     </div>
                    
                    <div class="row">
                    
                        
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="pagination">
                                <a href="#"><div class="previous"><i class="icons icon-left-dir"></i></div></a>
                                <a href="#"><div class="page-button">1</div></a>
                                <a href="#"><div class="page-button">2</div></a>
                                <a href="#"><div class="page-button">3</div></a>
                                <a href="#"><div class="next"><i class="icons icon-right-dir"></i></div></a>
                            </div>
                        </div>
                    
                    </div>											
											
				</div>
				-->						
			</div>						
		</div>
	</div>
	
							
</div>
	
<!-- JavaScript 
<script type="text/javascript">
          var options={
              backdrop:true,
              keyboard:true,
              show:true
          
          }
          $('#postGoods').click(function(){
              $('#myModal').modal('toggle');
          });
          
          $('#order_post').click(function(){
              $('#postModal').modal('toggle');
          });
          
          $('#order_nopay').click(function(){
              $('#nopayModal').modal('toggle');
          });
          
          $('#order_check').click(function(){
              $('#checkModal').modal('toggle');
          });
          
          $('#order_succ').click(function(){
              $('#succModal').modal('toggle');
          });
          
          $('#order_failure').click(function(){
              $('#failureModal').modal('toggle');
          });
          </script>-->
		<script src="<%=request.getContextPath()%>/static/js/modernizr.min.js"></script>
		<script src="<%=request.getContextPath()%>/static/js/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery.raty.min.js"></script>
		
		<!-- Scroll Bar -->
		<script src="<%=request.getContextPath()%>/static/js/perfect-scrollbar.min.js"></script>
		
		<!-- Cloud Zoom -->
		<script src="<%=request.getContextPath()%>/static/js/zoomsl-3.0.min.js"></script>
		
		<!-- FancyBox -->
		<script src="<%=request.getContextPath()%>/static/js/jquery.fancybox.pack.js"></script>
		
		<!-- jQuery REVOLUTION Slider  -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery.themepunch.plugins.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery.themepunch.revolution.min.js"></script>

		<!-- FlexSlider -->
		<script defer src="<%=request.getContextPath()%>/static/js/flexslider.min.js"></script>
		
		<!-- IOS Slider -->
		<script src = "<%=request.getContextPath()%>/static/js/jquery.iosslider.min.js"></script>
		
		<!-- noUi Slider -->
		<script src="<%=request.getContextPath()%>/static/js/jquery.nouislider.min.js"></script>
		
		<!-- Owl Carousel -->
		<script src="<%=request.getContextPath()%>/static/js/owl.carousel.min.js"></script>
		
		<!-- Cloud Zoom -->
		<script src="<%=request.getContextPath()%>/static/js/zoomsl-3.0.min.js"></script>
		
		<!-- SelectJS -->
        <script src="<%=request.getContextPath()%>/static/js/chosen.jquery.min.js" type="text/javascript"></script>
        
        <!-- Main JS -->
        <script defer src="<%=request.getContextPath()%>/static/js/bootstrap.min.js"></script>
        <script src="<%=request.getContextPath()%>/static/js/main-script.js"></script>
</body>
</html>