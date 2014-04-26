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
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/bootstrap.min.css">
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
 	<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery.js"></script> 
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap-scrollspy.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery-1.4.2.min.js"></script>
    <style type="text/css">
		 body {
            padding-top: 20px;
            padding-bottom: 40px;
			padding-right: 20px;
          }
    </style>
</head>
<body>

	<!-- <div class="row"> -->
							
			<div class="col-lg-12 col-md-12 col-sm-12">
								
				<div class="tabs">
								
					<div class="tab-heading">
						<a href="#tab1" class="button big">出售中的商品</a>
						<a href="#tab2" class="button big">添加商品</a>
					</div>
									
				<div class="page-content tab-content">
										
					<div id="tab1">
					
                    <div class="row">
                    	
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        	
                            <table class="wishlist-table">
                            	
                                <tr>
                                	<td class="wishlist-image">商品</td>
                                	<td class="wishlist-info">商品信息</td>
                                    <td class="wishlist-price">销量</td>
                                    <td class="wishlist-price">库存</td>
                                    <td class="wishlist-price">单价</td>
                                    <td class="wishlist-actions">操作</td>
                                </tr>
                                <c:forEach var="pro" items="${proSell }" varStatus="idx">
                                <script>
								$(function(){
									$("#${idx.index}_addBtn").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/SellerController/addInStock?id=${pro.productId}",
													type:"post",
													data:{itemId:"${pro.productId}" ,addCount:$("#${idx.index}_addCount").val()},
													success:function (data){
														alert("Add success!");
														$("#${idx.index}_tr_td").text(parseInt($("#${idx.index}_addCount").val())+parseInt("${pro.inventory}"));
														<!--$("#${idx.index}_tr_td").append("<span class='price'>"+(parseInt($("#${idx.index}_addCount").val())+parseInt("${pro.inventory}"))+"</span>");
														-->
													}
												}
											);
									});
									
									$("#${idx.index}_delBtn").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/SellerController/delFromShop?id=${pro.productId}",
													type:"post",
													data:{itemId:"${pro.productId}"},
													success:function (data){
														$("#${idx.index}_tr").remove();
													}
												}
											);
									});
								
								});
								</script>
                                <tr id="${idx.index}_tr">
                                	<td class="wishlist-image">
                                    	<a href="#"><img src="<%=request.getContextPath()%>/imgout?imgurl=${pro.mainImgUrl}" alt="Product1"></a>
                                    </td>
                                    <td class="wishlist-info">
                                    	<h5><a href="#">${pro.productName}</a></h5>
                                    	<h6>${pro.productId}</h6>                                       
                                    </td>
                                    <td class="wishlist-price">
                                    	<span class="price">${pro.salesNum}</span>
                                    </td>
                                    <td class="wishlist-price" >
                                    	<span class="price" id="${idx.index}_tr_td">${pro.inventory}</span>
                                    </td>
                                    <td class="wishlist-price">
                                    	<span class="price">${pro.price}</span>
                                    </td>
                                    <td class="wishlist-actions">
                                    	<div class="row">
                                    	<div class="col-lg-12 col-md-12 col-sm-12">
                                         <div id="top-header">																						            
											              <li class="purple"><a href="#">
											              	<span class="add-to-cart">
				                                                <span class="action-wrapper">
				                                                    
				                                                    <span class="action-name">补货</span>									               									         									                                                                                                       
				                                                </span>
				                                            </span></a>
											                <ul id="login-dropdown" class="box-dropdown">
											                  <li>
											                    <div class="box-wrapper">
											                      <h4>请输入补货量</h4>
											                      <div class="iconic-input">
											                        <input id="${idx.index}_addCount" type="text" placeholder="count" class="input-block-level" name="addCount">						
																	</div>                                
											                      <div class="pull-left">
											                      <a href="#">
											              	<span class="add-to-cart">
				                                                <span class="action-wrapper">
				                                                    <i class="icons icon-basket-2"></i>
				                                                    <span class="action-name" id="${idx.index}_addBtn">补货</span>									               									         									                                                                                                       
				                                                </span>
				                                            </span></a>
											                        <!--  <input id="${idx.index}_addBtn" type="submit" class="orange" value="确定">-->
											                      </div>
											                      
											                      <br class="clearfix">
											                    </div>                   
											                  </li>
											                </ul>
											              </li>											              
											            <li class="purple">
		                                        <a href="#">
		                                            <span class="add-to-trash">
		                                                <span class="action-wrapper" >
		                                                    
		                                                    <span class="action-name" id="${idx.index}_delBtn">下架</span>
		                                                </span>
		                                            </span>
		                                        </a>
													</li>											              
											          </div>
											     </div> 
																						
                                        </div>                                      
                                    </td>
                                </tr>                                                                                                                             
                                </c:forEach>
                            </table>
                            
                        </div>
                     </div>
                    
                   
				</div>							
																																
										
				<div id="tab2">
											
					<div class="hero-unit">
        				<div class="container-fluid">
			        	<form action="<%=request.getContextPath()%>/SMgrLoader/toproPage" method="post">
			                <div class="row-fluid">
			                    <div class="span3"  style="height:450px;">
                    
                    	<select multiple="multiple" name="proType">
                    		<option value="book_page">书籍</option>
                    		<option value="fruit_page">鲜果</option>
                        	<option value="shoes">鞋</option>
                            <option value="bags">包</option>
                            <option value="clothes">衣服</option>
                            <option value="digitals">数码3C</option>
                            <option value="home_appliances">家电</option>
                        </select>
                    </div>
                    <div class="span9">
                    	<div  style="text-align:center">
                    		<textarea rows="5" readonly disabled="disabled" style="width: 560px;">
                    		商城规则
第一章 概述
第一条
为促进开放、透明、分享、责任的新商业文明，保障酱油用户合法权益，维护酱油正常经营秩序，根据《酱油宣言》及《酱油服务协议》、制定本规则。 
第二条
酱油规则，是对酱用户增加基本义务或限制基本权利的条款。
第三条
违规行为的认定与处理，应基于酱油的事实并严格依规执行。酱油用户在适用规则上一律平等。
第四条
用户应遵守国家法律、行政法规、部门规章等规范性文件。对任何涉嫌违反国家法律、行政法规、部门规章等规范性文件的行为，本规则已有规定的，适用本规则；本规则尚无规定的，酱油有权酌情处理。但酱油对用户的处理不免除其应尽的法律责任。用户在酱油的任何行为，应同时遵守与酱油及其关联公司所签订的各项协议。 酱油有权随时变更本规则并在网站上予以公告。若用户不同意相关变更，应立即停止使用酱油的相关服务或产品。酱油有权对用户行为及应适用的规则进行单方认定，并据此处理。 
                    		</textarea>
                    	</div>
                    	<div class="row-fluid" style="text-align: center">
                    		<input class="btn btn-info btn-large" type="submit" value="同意以上规定，开始添加商品">
                    	</div>
                    </div>
                </div>
               </from>
     		</div>
     	</div>
											
						</div>
										
				</div>						
					</div>
		</div>				
							

<!-- /Product Tabs -->
<!-- </div> --> 
  
  
  <!-- JavaScript -->
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