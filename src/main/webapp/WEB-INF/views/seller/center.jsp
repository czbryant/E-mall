<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<link href="<%=request.getContextPath() %>/static/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/static/css/bootstrap.css" rel="stylesheet"> 	
    <script src="<%=request.getContextPath()%>/static/js/bootstrap.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap-scrollspy.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery-1.4.2.min.js"></script>

<title>shop here</title>
</head>
<body>
		<c:choose>
			<c:when test="${empty shop }">
				<div class="container">
				<!-- Main Content -->
				<section class="main-content col-lg-12 col-md-12 col-sm-12">
                    <div class="row">
                    	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	                        	
                            <div class="carousel-heading no-margin">
                                <h4>账户基本信息</h4>
                            </div>                            
                            <table class="orderinfo-table">
                            <script>
                            	$(function(){
									$("#createBtn").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/SellerController/createShop?id=${seller.sellerID}",
													type:"post",
													data:{shopName:$("#shopName").val()},
													success:function (data){
														alert("Create shop success!");
														//location.reload();
														top.window.location.href="<%=request.getContextPath()%>/SMgrLoader/loadSMgr";
													}
												}
											);
									});
									
									$("#authBtn").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/SellerController/authSeller?id=${seller.sellerID}",
													type:"post",
													data:{trueName:$("#trueName").val(), idFlag:$("#idFlag").val(), idNumber:$("#idNumber").val()},
													success:function (data){
														alert("Auth success!");
														location.reload();

													}
												}
											);
									});
								
								});
								</script>
                                <tr>
                                	<th>注册账户</th>
                                    <td>${seller.username }</td>
                                </tr> 
                                
                                <tr>
                                	<th>商家昵称</th>
                                    <td>${seller.sellerName }</td>
                                </tr>
                                
                                <tr>
                                	<th>真实姓名</th>
                                    <td>${seller.trueName }</td>
                                </tr>
                                <tr>
                                	<th>证件类型</th>
                                	<c:choose>
                                		<c:when test="${ seller.idFlag==1}">
                                			<td>身份证</td>
                                		</c:when>
                                		<c:when test="${seller.idFlag==2 }">
                                			<td>学生证</td>
                                		</c:when>
                                		<c:when test="${seller.idFlag==3 }">
                                			<td>军官证</td>
                                		</c:when>
                                		<c:otherwise>
                                			<td>
			                                    <div class="row">
			                                    <div class="col-lg-6 col-md-6 col-sm-6"><span><em>您还未实名认证</em></span></div>
			                                    <div class="col-lg-6 col-md-6 col-sm-6">
			                                    	<div id="top-header">																						            
														              <li class="purple"><a href="#">
														              	<span class="add-to-cart">
							                                                <span class="action-wrapper">
							                                                  
							                                                    <span class="action-name">认证</span>									               									         									                                                                                                       
							                                                </span>
							                                            </span></a>
														                <ul id="login-dropdown" class="box-dropdown">
														                  <li>
														                    <div class="box-wrapper">
														                      <h4>请输入</h4>
														                      <div class="iconic-input">
														                        <input id="trueName" type="text" placeholder="姓名" class="input-block-level" name="trueName">						
																				
																				 <select id="idFlag" name="idFlag">
																				 <option value="1" selected>身份证</option>													
																				<option value="2">学生证</option>
																				<option value="3">军官证</option>
																				</select>   
																		
														                        <input id="idNumber" type="text" placeholder="证件号码" class="input-block-level" name="idNumber" maxlength="18">						
																				                             
														                      <div class="pull-left">
														                      
														             <a href="#">
														              	<span class="add-to-cart">
							                                                <span class="action-wrapper">
							                                                    
							                                                    <span class="action-name" id="authBtn">认证</span>									               									         									                                                                                                       
							                                                </span>
							                                            </span></a>
														                        <!--  <input id="${idx.index}_addBtn" type="submit" class="orange" value="确定">-->
														                      </div>
														                      
														                      <br class="clearfix">
														                    </div>                   
														                  </li>
														                </ul>
														              </li>											              														            
												          </div>
												   </div> 
												</div>
											</td>
                                		</c:otherwise>
                                	</c:choose>
                                </tr>
                                
                                <tr>
                                	<th>证件号码</th>
                                	<c:choose>
                                		<c:when test="${seller.idFlag == 0 }">
                                			<td>还未认证</td>
                                		</c:when>
                                		<c:otherwise>
                                			<td>${seller.identification }</td>
                                		</c:otherwise>
                                	</c:choose>
                                    <td></td>
                                </tr>
                                <tr>
                                	<th>店铺信息</th>
                                	<c:choose>
                                	<c:when test="${empty shop }">                	                	               
	                                    <td>
	                                    <div class="row">
	                                    <div class="col-lg-6 col-md-6 col-sm-6"><span><em>您还未开通店铺</em></span></div>
	                                    <div class="col-lg-6 col-md-6 col-sm-6">
	                                    	<div id="top-header">																						            
												              <li class="purple"><a href="#">
												              	<span class="add-to-cart">
					                                                <span class="action-wrapper">
					                                                  
					                                                    <span class="action-name">开店</span>									               									         									                                                                                                       
					                                                </span>
					                                            </span></a>
					                                            <c:choose>
					                                            	<c:when test="${seller.idFlag==0 }">
					                                            	<ul id="login-dropdown" class="box-dropdown">
												                  		<li>
														                    <div class="box-wrapper">
														                      <h4>开店请先实名认证</h4>
														                    </div>
														                    <div class="iconic-input"></div>                                
												                      
														                </li>
														             </ul>
					                                            	</c:when>
					                                            	<c:otherwise>
					                                            	<ul id="login-dropdown" class="box-dropdown">
												                  <li>
												                    <div class="box-wrapper">
												                      <h4>请输入店铺名称</h4>
												                      <div class="iconic-input">
												                        <input id="shopName" type="text" placeholder="Shop name" class="input-block-level" name="shopName">						
																		</div>                                
												                      <div class="pull-left">
												                      <a href="#">
												              	<span class="add-to-cart">
					                                                <span class="action-wrapper">
					                                                    
					                                                    <span class="action-name" id="createBtn">开店</span>									               									         									                                                                                                       
					                                                </span>
					                                            </span></a>
												                        <!--  <input id="${idx.index}_addBtn" type="submit" class="orange" value="确定">-->
												                      </div>
												                      
												                      <br class="clearfix">
												                    </div>                   
												                  </li>
												                </ul>
					                                            	</c:otherwise>
					                                            </c:choose>
												                
												              </li>											              
												            
												          </div>
												     </div> 
												  </div>
											</td>
									</c:when>
									<c:otherwise>
										<td>
											<h5>店铺名：${shop.shopName }</h5>
											<h5>店铺ID：${shop.shopId }</h5>
											<h5>总评论数：${shop.evaluateNum }</h5>
										</td>
									</c:otherwise>
									</c:choose>
                                </tr>
                                
                                <tr>
                                	<th>性别</th>
                                    <td>男</td>
                                </tr>
                                
                                <tr>
                                	<th>生日</th>
                                    <td>${seller.birthday }</td>
                                </tr>
                                
                                                                
								<tr>
                                	<th>账户余额</th>
                                    <td>${seller.account }</td>
                                </tr>
                                
                                <tr>
                                	<th>详细地址</th>
                                    <td>${seller.localAddr }</td>
                                </tr>
                                
                                <tr>
                                	<th>联系电话</th>
                                    <td>${seller.telNum }</td>
                                </tr>
                                
                                <tr>
                                	<th>邮箱地址</th>
                                    <td>${seller.email }</td>
                                </tr>
                                
                                <tr>
                                	<th>信誉度</th>
                                    <td>${seller.sellerCredit }</td>
                                </tr>
                                
                                <tr>
                                	<th>好评率</th>
                                    <td>${seller.sellerRate }</td>
                                </tr>
                                
                                <tr>
                                	<th>注册时间</th>
                                    <td>${seller.registerTime }</td>
                                </tr>								                                                   
                                
                            </table>                                                                                 
                    </div>
                </section>
                </div>
			</c:when>
			<c:otherwise>
				<section class="main-content col-lg-8 col-md-8 col-sm-8">
                    <div class="row">
                    	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	                        	
                            <div class="carousel-heading no-margin">
                                <h4>最新交易发布</h4>
                            </div>                            
                            <table class="orderinfo-table">
                            
                                <tr>
                                	<td>序号</td>
                                	<td>订单号</td>
                                	<td>买家</td>
                                	<td>订单状态</td>
                                    
                                </tr> 
                               <c:forEach var="newTradeOrder" items="${sessionScope.newTradeOrders}" varStatus="status">
                               		<tr>
                               			<td>${status.count }</td>
                               			<td>${newTradeOrder.orderID }</td>
                               			<td>${newTradeOrder.buyer.username }</td>
                               			<td>
                               				<c:choose>
                               					<c:when test="${newTradeOrder.orderStatus == 0 }">
                               						买家已下单，等到付款
                               					</c:when>
                               					<c:otherwise>
                               						买家已付款，等待发货
                               					</c:otherwise>
                               				</c:choose>
                               			</td>
                               		</tr>
                               </c:forEach>
                            </table>
                  		</div>
                  	</div>
                    <div class="row">	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	                        	
                            <div class="carousel-heading no-margin">
                                <h4>最新成功信息</h4>
                            </div>                            
                            <table class="orderinfo-table">
                            
                                <tr>
                                	<td>序号</td>
                                	<td>订单号</td>
                                	<td>买家</td>
                                	<td>订单状态</td>
                                </tr> 
                                <c:forEach var="newSuccOrder" items="${sessionScope.newSuccOrders}" varStatus="status">
                               		<tr>
                               			<td>${status.count }</td>
                               			<td>${newSuccOrder.orderID }</td>
                               			<td>${newSuccOrder.buyer.username }</td>
                               			<td><c:choose>
                               					<c:when test="${newTradeOrder.orderStatus == 3 }">
                               						已确认收货，等到评价
                               					</c:when>
                               					<c:otherwise>
                               						已评价完成，交易成功
                               					</c:otherwise>
                               				</c:choose></td>
                               		</tr>
                               </c:forEach>                                                         								                                                                                 
                            </table>
                    </div>       
                    <div class="row">	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	                        	
                            <div class="carousel-heading no-margin">
                                <h4>最新评论信息</h4>
                            </div>                            
                            <table class="orderinfo-table">
                            
                                <tr>
                                	<td>序号</td>
                                	<td>订单号</td>
                                	<td>买家</td>
                                	<td>店铺评分</td>
                                    <td>商品评论</td>
                                </tr> 
                                 <c:forEach var="viewOrder" items="${sessionScope.viewOrders}" varStatus="status">
                               		<tr>
                               			<td>${status.count }</td>
                               			<td>${viewOrder.orderID }</td>
                               			<td>${viewOrder.buyer.username }</td>
                               			<td>${viewOrder.evaluate.shopEvaluation }</td>
                               			<td>${viewOrder.evaluate.productEval }</td>
                               		</tr>
                               </c:forEach>                                                         								                                                                                 
                            </table>
                    </div>
                    
                </section>
                
                <!-- Main Content -->
				<section class="main-content col-lg-4 col-md-4 col-sm-4">
                    <div class="row">
                    	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	                        	
                            <div class="carousel-heading no-margin">
                                <h4>账户基本信息</h4>
                            </div>                            
                            <table class="orderinfo-table">
                            
                                <tr>
                                	<th>注册账户</th>
                                    <td>${seller.username }</td>
                                </tr> 
                                
                                <tr>
                                	<th>商家昵称</th>
                                    <td>${seller.sellerName }</td>
                                </tr>
                                
                                <tr>
                                	<th>真实姓名</th>
                                    <td>${seller.trueName }</td>
                                </tr>
                                
                                <tr>
                                	<th>店铺信息</th>                               	
										<td>
											<h5>店铺名：${shop.shopName }</h5>
											<h5>店铺ID：${shop.shopId }</h5>
											<h5>总评论数：${shop.evaluateNum }</h5>
										</td>									
                                </tr>
                                
                                <tr>
                                	<th>性别</th>
                                    <td>男</td>
                                </tr>
                                
                                <tr>
                                	<th>生日</th>
                                    <td>${seller.birthday }</td>
                                </tr>
                                
                                <tr>
                                	<th>证件类型</th>
                                	<c:choose>
                                		<c:when test="${ seller.idFlag==1}">
                                			<td>身份证</td>
                                		</c:when>
                                		<c:when test="${seller.idFlag==2 }">
                                			<td>学生证</td>
                                		</c:when>
                                		<c:when test="${seller.idFlag==3 }">
                                			<td>军官证</td>
                                		</c:when>
                                		<c:otherwise>
                                			<td>
			                                    <div class="row">
			                                    <div class="col-lg-4 col-md-4 col-sm-4"><span><em>您还未实名认证</em></span></div>
			                                    <div class="col-lg-8 col-md-8 col-sm-8">
			                                    	<div id="top-header">																						            
														              <li class="purple"><a href="#">
														              	<span class="add-to-cart">
							                                                <span class="action-wrapper">
							                                                  
							                                                    <span class="action-name">认证</span>									               									         									                                                                                                       
							                                                </span>
							                                            </span></a>
														                <ul id="login-dropdown" class="box-dropdown">
														                  <li>
														                    <div class="box-wrapper">
														                      <h4>请输入</h4>
														                      <div class="iconic-input">
														                        <input id="trueName" type="text" placeholder="姓名" class="input-block-level" name="trueName">						
																				
																				 <select id="idFlag" name="idFlag">
																				 <option value="1" selected>身份证</option>													
																				<option value="2">学生证</option>
																				<option value="3">军官证</option>
																				</select>   
																		
														                        <input id="idNumber" type="text" placeholder="证件号码" class="input-block-level" name="idNumber">						
																				                             
														                      <div class="pull-left">
														                      
														             <a href="#">
														              	<span class="add-to-cart">
							                                                <span class="action-wrapper">
							                                                    
							                                                    <span class="action-name" id="authBtn">认证</span>									               									         									                                                                                                       
							                                                </span>
							                                            </span></a>
														                        <!--  <input id="${idx.index}_addBtn" type="submit" class="orange" value="确定">-->
														                      </div>
														                      
														                      <br class="clearfix">
														                    </div>                   
														                  </li>
														                </ul>
														              </li>											              														            
												          </div>
												   </div> 
												</div>
											</td>
                                		</c:otherwise>
                                	</c:choose>
                                </tr>
                                
                                <tr>
                                	<th>证件号码</th>
                                	<c:choose>
                                		<c:when test="${seller.idFlag == 0 }">
                                			<td>还未认证</td>
                                		</c:when>
                                		<c:otherwise>
                                			<td>${seller.identification }</td>
                                		</c:otherwise>
                                	</c:choose>
                                    <td></td>
                                </tr>
                                
								<tr>
                                	<th>账户余额</th>
                                    <td>${seller.account }</td>
                                </tr>
                                
                                <tr>
                                	<th>详细地址</th>
                                    <td>${seller.localAddr }</td>
                                </tr>
                                
                                <tr>
                                	<th>联系电话</th>
                                    <td>${seller.telNum }</td>
                                </tr>
                                
                                <tr>
                                	<th>邮箱地址</th>
                                    <td>${seller.email }</td>
                                </tr>
                                
                                <tr>
                                	<th>信誉度</th>
                                    <td>${seller.sellerCredit }</td>
                                </tr>
                                
                                <tr>
                                	<th>好评率</th>
                                    <td>${seller.sellerRate }</td>
                                </tr>
                                
                                <tr>
                                	<th>注册时间</th>
                                    <td>${seller.registerTime }</td>
                                </tr>								                                                   
                                
                            </table>
                            
                                                     
                    </div>
                </section>
			</c:otherwise>
		</c:choose>		
					
                
               
       <!-- JavaScript -->
       <script type="text/javascript">
          var options={
              backdrop:true,
              keyboard:true,
              show:true
          
          }
          $('#pwd_modify').click(function(){
              $('#myModal_1').modal('toggle');
          });
		  		  
          </script>
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