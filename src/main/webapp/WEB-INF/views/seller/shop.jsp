<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/owl.carousel.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/owl.theme.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/chosen.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery.js"></script> 
<style>  
.myssec{   
    width:218px;  
    height:200px;  
    border:solid 1px #ccc;  
    background-color:white;  
    background-image:url(image/DSCI0002.JPG); /*图片地址*/  
    background-origin:content;                /*从content区域开始显示背景*/  
    background-position:50% 50%;              /*图片上下左右居中*/  
    background-size:contain;                  /*保持图像本身的宽高比例，将图片缩放到宽度或高度正好适应定义背景的区域*/  
    background-repeat:no-repeat;              /*图像不重复显示*/  
}  
</style>  	
<title>shop</title>
</head>
<body>
	
	<div class="container">
	<c:choose>
		<c:when test="${flag == 1}"></c:when>
		<c:otherwise></c:otherwise>
	</c:choose>
	<script>
                            	$(function(){
																
									$("#submit").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/BuyerController/reLogin",
													type:"post",
													data:{username:$("#username").val(), password:$("#password").val()},
													success:function (data){
														if(data=="1"){
															//$("#loginModal").html();
															location.reload();
														}else{
															alert("用户名或密码错误!");
														}
														

													}
												}
											);
									});
									
									$("#logout").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/BuyerController/ajaxLogout",
													type:"post",
													data:{},
													success:function (data){
														if(data!=""){
															//$("#loginModal").html();
															location.reload();
														}else{
															alert("发生错误!");
														}
														

													}
												}
											);
									});
								
								});
								</script>
	<!-- Header -->
			<header class="row">
				
				<div class="col-lg-12 col-md-12 col-sm-12">
					<c:choose>
						<c:when test="${flag == 1}">
							<!-- Top Header -->
						      <div id="top-header">
						        <div class="row">
						          <nav id="top-navigation" class="col-lg-7 col-md-7 col-sm-7">
						            <ul class="pull-left">
						              <li><a href="<%=request.getContextPath()%>">主页</a></li>
						              <li><a href="<%=request.getContextPath()%>/toMyCart">购物车</a></li>
						              <li><a href="<%=request.getContextPath()%>/loadConnection">收藏夹</a></li>
						              <li><a href="#">关于我们</a></li>
						            </ul>
						          </nav>
						          <nav id="loginModal" class="col-lg-5 col-md-5 col-sm-5">
						            <ul class="pull-right">
						            <c:choose>
						            	<c:when test="${empty sessionScope.current_user}">
						            		<li class="purple"><a href="#"><i class="icons icon-user-3"></i> 登录</a>
						                <ul id="login-dropdown" class="box-dropdown">
						                  <li>
						                    <div class="box-wrapper">
						                      <h4>登录</h4>
						                      <div class="iconic-input">
						                        <input type="text" placeholder="Username" id="username">
						                        <i class="icons icon-user-3"></i> </div>
						                      <div class="iconic-input">
						                        <input type="text" placeholder="Password" id="password">
						                        <i class="icons icon-lock"></i> </div>
						                      <input type="checkbox" id="loginremember">
						                      <label for="loginremember">Remember me</label>
						                      <br>
						                      <br>
						                      <div class="pull-left">
						                        <input id="submit" type="submit" class="orange" value="登录">
						                      </div>
						                      
						                      <br class="clearfix">
						                    </div>
						                    <div class="footer">
						                      <h4 class="pull-left">新用户?</h4>
						                      <a class="button pull-right" href="<%=request.getContextPath()%>/toregister">注册</a> </div>
						                  </li>
						                </ul>
						              </li>
						              <li><a href="<%=request.getContextPath()%>/toregister"><i class="icons icon-lock"></i> 注册</a></li>
						            	</c:when>
						            	<c:otherwise>
						            		Hi! <a href="<%=request.getContextPath()%>/BuyerController/toBuyerMgr" class="navbar-link">${sessionScope.current_user.username}</a>|
						            		<a href="#" id="logout" class="navbar-link">注销</a>
						            	</c:otherwise>
						            </c:choose>
						              
						            </ul>
						          </nav>
						        </div>
						      </div>
						      <!-- /Top Header -->
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>												
					<!-- Main Header -->
					<div id="main-header">
						
						<div class="row">
							
							<div id="logo" class="col-lg-4 col-md-4 col-sm-4">
								<a href="#"><img src="<%=request.getContextPath()%>/static/img/logo.png" alt="Logo"></a>
							</div>
							
							<nav id="middle-navigation" class="col-lg-8 col-md-8 col-sm-8">
								<ul class="pull-right">
									<c:choose>
										<c:when test="${flag == 3}">
											<li class="orange"><a href="order_info.html"><i class="icons icon-basket-2"></i>17 Items</a>
						                <ul id="cart-dropdown" class="box-dropdown parent-arrow">
						                  <li>
						                    <div class="box-wrapper parent-border">
						                      <p>Recently added item(s)</p>
						                      <table class="cart-table">
						                        <tr>
						                          <td><img src="img/products/sample1.jpg" alt="product"></td>
						                          <td><h6>Lorem ipsum dolor</h6>
						                            <p>Product code PSBJ3</p></td>
						                          <td><span class="quantity"><span class="light">1 x</span> $79.00</span> <a href="#" class="parent-color">Remove</a></td>
						                        </tr>
						                        
						                      </table>
						                      <br class="clearfix">
						                    </div>
						                    <div class="footer">
						                      <table class="checkout-table pull-right">
						                        <tr>
						                          <td class="align-right">Tax:</td>
						                          <td>$0.00</td>
						                        </tr>
						                        <tr>
						                          <td class="align-right">Discount:</td>
						                          <td>$37.00</td>
						                        </tr>
						                        <tr>
						                          <td class="align-right"><strong>Total:</strong></td>
						                          <td><strong class="parent-color">$999.00</strong></td>
						                        </tr>
						                      </table>
						                    </div>
						                    <div class="box-wrapper no-border"> <a class="button pull-right parent-background" href="#">Checkout</a> <a class="button pull-right" href="order_info.html">View Cart</a> </div>
						                  </li>
						                </ul>
						              </li>
										</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
									
									<li><a href="#"><i class="icons icon-dollar"></i>店铺信息</a>
                                    	<ul class="box-dropdown parent-arrow">
											<li>
                                            	<div class="box-wrapper no-padding parent-border">
                                                    <table class="currency-table">
                                                    	<tr>
                                                        	<td><a href="#">店铺名称：${shop.shopName }</a></td>
                                                        </tr>
                                                        <tr>
                                                        	<td><a href="#">商家用户名:${seller.username }</a></td>
                                                        </tr>
                                                    </table>
                                                </div>
											</li>
										</ul>
                               </li>
                               <script>
								$(function(){
									$("#pro_toCon").click(function(){
										var url_ = "<%=request.getContextPath()%>/BMgrLoader/addFavorites";
										$.ajax({
											url : url_,
											type : "get",
											data : {
													fid : "${shop.shopId}",
													ftype : "0"
											},
											success : function(data) {
												if(data=="0"){
													alert("请先登录!");
												}else if(data == "2"){
													alert("店铺已经收藏!")
												}else {
													alert("店铺收藏成功!")
												}
											}
										});
									});
								});
							</script>
                                   	<li class="red"><a id="pro_toCon" href="#"><i class="icons icon-heart-empty"></i>收藏店铺</a>                                   	
                               </li>						
									
								</ul>
							</nav>
							
						</div>
						
					</div>
					<!-- /Main Header -->
					
					
					<!-- Main Navigation -->
					<nav id="main-navigation" class="style5">
						<ul>
							
							<li class="black">
								<a href="#">
									<span class="nav-caption">首页</span>
								</a>
								
							</li>
							
							<li class="black">
								<a href="#">
									<span class="nav-caption">商品分类</span>
								</a>
								
								<ul class="normal-dropdown normalAnimation">
									<li><a href="#">分类一 </a>										
									</li>
									<li><a href="#">分类二 </a>										
									</li>
									<li><a href="#">分类三 </a>										
									</li>
									<li><a href="#">分类四 </a>									
									</li>
								</ul>
								
							</li>
							
							<li class="black">
								<a href="#">
									<span class="nav-caption">新品上市</span>
								</a>
							</li>
							
							<li class="black">
								<a href="#">
									<span class="nav-caption">促销商品</span>
								</a>
							</li>
							
							<li class="black">
								<a href="#">
									<span class="nav-caption">热销商品</span>
								</a>
							</li>
							
							<li class="black">
								<a href="#">
									<span class="nav-caption">全部商品</span>
								</a>
							</li>
							
							<li class="nav-search">
                                	<i class="icons icon-search-1"></i>
							</li>
							
						</ul>
						
						<div id="search-bar">
							
							<div class="col-lg-12 col-md-12 col-sm-12">
                            	<table id="search-bar-table">
                                    <tr>
                                    	<td class="search-column-1">
                                            
                                            <input type="text" placeholder="Enter your keyword">
                                        </td>
                                        <td class="search-column-2">                                        
                                        	<select class="chosen-select-search">
                                                <option>商品</option>
                                                <option>其他</option>                                                
                                            </select>
                                		</td>
                                    </tr>
                                </table>
							</div>
							<div id="search-button">
								<input type="submit" value="">
								<i class="icons icon-search-1"></i>
							</div>
						</div>
						
					</nav>
					<!-- /Main Navigation -->
					
				</div>
				
			</header>
			<!-- /Header -->
	 		<!-- Content -->
			<div class="row content">
				
                <div class="col-lg-12 col-md-12 col-sm-12">
                	<div class="breadcrumbs">
                    	<p><a href="#">首页</a> <i class="icons icon-right-dir"></i></p>
                    </div>
                </div>
	 
	 
		<!-- Main Content -->
		<section class="main-content col-lg-9 col-md-9 col-sm-9 col-lg-push-3 col-md-push-3 col-sm-push-3">
		
		<!-- Featured Products -->
      	<div class="products-row row"> 
        
        <!-- Carousel Heading -->
        <div class="col-lg-12 col-md-12 col-sm-12">
          <div class="carousel-heading">
            <h4>促销商品</h4>
            <div class="carousel-arrows"> <i class="icons icon-left-dir"></i> <i class="icons icon-right-dir"></i> </div>
          </div>
        </div>
        <!-- /Carousel Heading --> 
        
        <!-- Carousel -->
        <div class="carousel owl-carousel-wrap col-lg-12 col-md-12 col-sm-12">
          <div class="owl-carousel" data-max-items="3"> 
            <c:if test="${!empty sessionScope.promotionGoods }">
		          <c:forEach var="promotionGood" items="${sessionScope.promotionGoods}" varStatus="idx">
     				<script>
								$(function(){
									$("#${idx.index}_addCart_p").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/addToCart?id=${promotionGood.productId}",
													type:"get",
													data:{ num:"1"},
													success:function (data){
														alert("添加购物车成功!");
														
													}
												}
											);
									});
									
									$("#${idx.index}_addColl_p").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/BMgrLoader/addFavorites",
													type:"get",
													data:{fid:"${promotionGood.productId}",ftype:"1"},
													success:function (data){
														if(data=="0"){
															alert("请先登录");
														}else{
															alert("添加收藏夹成功!");
														}
													}
												}
											);
									});
								
								});
								</script>
            <!-- Slide -->
            <div> 
              <!-- Carousel Item -->
              <div class="product">
                <div class="product-image"><img src="<%=request.getContextPath()%>/imgout?imgurl=${promotionGood.mainImgUrl}" alt="Product1" width=160px height=280px> <a onclick="top.window.location.href='<%=request.getContextPath()%>/toDetail?id=${promotionGood.productId}'" class="product-hover"> <i class="icons icon-eye-1"></i> Quick View </a></div>
                <div class="product-info">
                  <h5><a href="<%=request.getContextPath()%>/toDetail?id=${promotionGood.productId}" target="_top">${promotionGood.productName }</a></h5>
                  <span class="price">￥${promotionGood.price }</span>
                  <div class="rating readonly-rating" data-score="4"></div>
                </div>
                <div class="product-actions"> <span id="${idx.index}_addCart_p" class="add-to-cart"> <span class="action-wrapper"> <i class="icons icon-basket-2"></i> <span class="action-name">添加购物车</span> </span > </span> <span id="${idx.index}_addColl_p" class="add-to-favorites"> <span class="action-wrapper"> <i class="icons icon-heart-empty"></i> <span class="action-name">添加收藏夹</span> </span> </span> <span class="add-to-compare"> <span class="action-wrapper"> <i class="icons icon-docs"></i> <span class="action-name">分享</span> </span> </span> </div>
              </div>
              <!-- /Carousel Item --> 
            </div>
            <!-- /Slide --> 
            </c:forEach>
		    </c:if>                     
            
          </div>
        </div>
        <!-- /Carousel --> 
        
      </div>
      <!-- /Featured Products --> 
		
		<!-- Featured Products -->
      	<div class="products-row row"> 
        
        <!-- Carousel Heading -->
        <div class="col-lg-12 col-md-12 col-sm-12">
          <div class="carousel-heading">
            <h4>新品上市</h4>
            <div class="carousel-arrows"> <i class="icons icon-left-dir"></i> <i class="icons icon-right-dir"></i> </div>
          </div>
        </div>
        <!-- /Carousel Heading --> 
        
        <!-- Carousel -->
        <div class="carousel owl-carousel-wrap col-lg-12 col-md-12 col-sm-12">
          <div class="owl-carousel" data-max-items="3"> 
            <c:if test="${!empty sessionScope.newGoods }">
		          <c:forEach var="newGood" items="${sessionScope.newGoods}" varStatus="idx">
     			<script>
								$(function(){
									$("#${idx.index}_addCart_n").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/addToCart?id=${newGood.productId}",
													type:"get",
													data:{ num:"1"},
													success:function (data){
														alert("添加购物车成功!");
														
													}
												}
											);
									});
									
									$("#${idx.index}_addColl_n").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/BMgrLoader/addFavorites",
													type:"get",
													data:{fid:"${newGood.productId}",ftype:"1"},
													success:function (data){
														if(data=="0"){
															alert("请先登录");
														}else{
															alert("添加收藏夹成功!");
														}
													}
												}
											);
									});
								
								});
								</script>
            <!-- Slide -->
            <div> 
              <!-- Carousel Item -->
              <div class="product">
                <div class="product-image"><section class="mysec"> <img src="<%=request.getContextPath()%>/imgout?imgurl=${newGood.mainImgUrl}" alt="Product1" width=160px height=280px> <a onclick="top.window.location.href='<%=request.getContextPath()%>/toDetail?id=${newGood.productId}'" class="product-hover"> <i class="icons icon-eye-1"></i> Quick View </a> </section></div>
                <div class="product-info">
                  <h5><a href="<%=request.getContextPath()%>/toDetail?id=${newGood.productId}" target="_top">${newGood.productName }</a></h5>
                  <span class="price">￥${newGood.price }</span>
                  <div class="rating readonly-rating" data-score="4"></div>
                </div>
					<div class="product-actions"> <span id="${idx.index}_addCart_n" class="add-to-cart"> <span class="action-wrapper"> <i class="icons icon-basket-2"></i> <span class="action-name">添加购物车</span> </span > </span> <span id="${idx.index}_addColl_n" class="add-to-favorites"> <span class="action-wrapper"> <i class="icons icon-heart-empty"></i> <span class="action-name">添加收藏夹</span> </span> </span> <span class="add-to-compare"> <span class="action-wrapper"> <i class="icons icon-docs"></i> <span class="action-name">分享</span> </span> </span> </div>
              </div>
              <!-- /Carousel Item --> 
            </div>
            <!-- /Slide --> 
            </c:forEach>
		    </c:if>                     
            
          </div>
        </div>
        <!-- /Carousel --> 
        
      </div>
      <!-- /Featured Products --> 
		
		<!-- Featured Products -->
      	<div class="products-row row"> 
        
        <!-- Carousel Heading -->
        <div class="col-lg-12 col-md-12 col-sm-12">
          <div class="carousel-heading">
            <h4>全部商品</h4>
            <div class="carousel-arrows"> <i class="icons icon-left-dir"></i> <i class="icons icon-right-dir"></i> </div>
          </div>
        </div>
        <!-- /Carousel Heading --> 
        
        <!-- Carousel -->
        <div class="carousel owl-carousel-wrap col-lg-12 col-md-12 col-sm-12">
          <div class="owl-carousel" data-max-items="3"> 
            <c:if test="${!empty sessionScope.allGoods }">
		          <c:forEach var="allGood" items="${sessionScope.allGoods}" varStatus="idx">
     				<script>
								$(function(){
									$("#${idx.index}_addCart_a").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/addToCart?id=${allGood.productId}",
													type:"get",
													data:{ num:"1"},
													success:function (data){
														alert("添加购物车成功!");
														
													}
												}
											);
									});
									
									$("#${idx.index}_addColl_a").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/BMgrLoader/addFavorites",
													type:"get",
													data:{fid:"${allGood.productId}",ftype:"1"},
													success:function (data){
														if(data=="0"){
															alert("请先登录");
														}else{
															alert("添加收藏夹成功!");
														}
													}
												}
											);
									});
								
								});
								</script>
            <!-- Slide -->
            <div> 
              <!-- Carousel Item -->
              <div class="product">
                <div class="product-image"><section class="mysec"> <img src="<%=request.getContextPath()%>/imgout?imgurl=${allGood.mainImgUrl}" alt="Product1" width=160px height=280px> <a onclick="top.window.location.href='<%=request.getContextPath()%>/toDetail?id=${allGood.productId}'" class="product-hover"> <i class="icons icon-eye-1"></i> Quick View </a> </section></div>
                <div class="product-info">
                  <h5><a href="<%=request.getContextPath()%>/toDetail?id=${allGood.productId}" target="_top">${allGood.productName }</a></h5>
                  <span class="price">￥${allGood.price }</span>
                  <div class="rating readonly-rating" data-score="4"></div>
                </div>
				<div class="product-actions"> <span id="${idx.index}_addCart_a" class="add-to-cart"> <span class="action-wrapper"> <i class="icons icon-basket-2"></i> <span class="action-name">添加购物车</span> </span > </span> <span id="${idx.index}_addColl_a" class="add-to-favorites"> <span class="action-wrapper"> <i class="icons icon-heart-empty"></i> <span class="action-name">添加收藏夹</span> </span> </span> <span class="add-to-compare"> <span class="action-wrapper"> <i class="icons icon-docs"></i> <span class="action-name">分享</span> </span> </span> </div>
              </div>
              <!-- /Carousel Item --> 
            </div>
            <!-- /Slide --> 
            </c:forEach>
		    </c:if>                     
            
          </div>
        </div>
        <!-- /Carousel --> 
        
      </div>
      <!-- /Featured Products --> 
     
	</section>
	
	<!-- Sidebar -->
	<aside class="sidebar col-lg-3 col-md-3 col-sm-3  col-lg-pull-9 col-md-pull-9 col-sm-pull-9">
		<!-- Bestsellers -->
					<div class="row sidebar-box black">
						
						<div class="col-lg-12 col-md-12 col-sm-12">
							
							<div class="sidebar-box-heading">
                            <i class="icons icon-award-2"></i>
								<h4>销量排行</h4>
							</div>
							
							<div class="sidebar-box-content">
								<table class="bestsellers-table">
									<c:forEach var="rankGood" items="${sessionScope.rankGoods}" varStatus="status">
									<tr>
										<td class="product-thumbnail"><a href="#"><img src="<%=request.getContextPath()%>/imgout?imgurl=${rankGood.mainImgUrl}" alt="Product1"></a></td>
										<td class="product-info">
											<p><a href="<%=request.getContextPath()%>/toDetail?id=${rankGood.productId}" target="_top">${rankGood.productName }</a></p>
											<span class="price">price:￥${rankGood.price }</span>
											<span class="price">sales:${rankGood.salesNum }</span>
										</td>
									</tr>
									
									</c:forEach>
								</table>
							</div>
							
						</div>
						
					</div>
					<!-- /Bestsellers -->
					
					<!-- Specials -->
					<div class="row products-row sidebar-box black">
						 
						<div class="col-lg-12 col-md-12 col-sm-12">
							
							<!-- Carousel Heading -->
							<div class="carousel-heading no-margin">
								
								<h4><i class="icons icon-magic"></i> 商品推荐</h4>
								<div class="carousel-arrows">
									<i class="icons icon-left-dir"></i>
									<i class="icons icon-right-dir"></i>
								</div>
								
							</div>
							<!-- /Carousel Heading -->
							
						</div>
						
						<!-- Carousel -->
						<div class="carousel owl-carousel-wrap col-lg-12 col-md-12 col-sm-12">
							
							<div class="owl-carousel" data-max-items="1">
								<c:forEach var="newGood" items="${sessionScope.newGoods}" varStatus="idx">	
									<script>
								$(function(){
									$("#${idx.index}_addCart_t").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/addToCart?id=${newGood.productId}",
													type:"get",
													data:{ num:"1"},
													success:function (data){
														alert("添加购物车成功!");
														
													}
												}
											);
									});
									
									$("#${idx.index}_addColl_t").click(function(){
										$.ajax(
												{
													url:"<%=request.getContextPath()%>/BMgrLoader/addFavorites",
													type:"get",
													data:{fid:"${newGood.productId}",ftype:"1"},
													success:function (data){
														if(data=="0"){
															alert("请先登录");
														}else{
															alert("添加收藏夹成功!");
														}
													}
												}
											);
									});
								
								});
								</script>
								<!-- Slide -->
								<div>
									<!-- Carousel Item -->
									<div class="product">
										
										<div class="product-image">
											<img src="<%=request.getContextPath()%>/imgout?imgurl=${newGood.mainImgUrl}" alt="Product1">
											<a onclick="top.window.location.href='<%=request.getContextPath()%>/toDetail?id=${newGood.productId}'" class="product-hover">
												<i class="icons icon-eye-1"></i> Quick View
											</a>
										</div>
										
										<div class="product-info">
											<h5><a href="<%=request.getContextPath()%>/toDetail?id=${allGood.productId}" target="_top">${newGood.productName }</a></h5>
											<span class="price">￥${newGood.price }</span>
											<div class="rating readonly-rating" data-score="4"></div>
										</div>
										<div class="product-actions">
										 <span id="${idx.index}_addCart_t" class="add-to-cart"> 
										 <span class="action-wrapper">
										  <i class="icons icon-basket-2"></i>
										   <span class="action-name">添加购物车</span> </span > </span> <span id="${idx.index}_addColl_t" class="add-to-favorites"> <span class="action-wrapper"> <i class="icons icon-heart-empty"></i> <span class="action-name">添加收藏夹</span> </span> </span> <span class="add-to-compare"> <span class="action-wrapper"> <i class="icons icon-docs"></i> <span class="action-name">分享</span> </span> </span> </div>
										
										
									</div>
									<!-- /Carousel Item -->
								</div>
								<!-- /Slide -->
								</c:forEach>
								
							</div>
						
						</div>
						<!-- / Carousel -->
						
						
					</div>
					<!-- /Specials -->
					
			
    </aside>
	<!-- /Sidebar -->
    	
</div>
</div>
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