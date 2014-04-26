<%@page import="ustc.sse.water.utils.GZipUtil"%>
<%@page import="ustc.sse.water.pojo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>商品详细页面</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">

	<!-- Le styles -->
	<link href="<%=request.getContextPath()%>/static/css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/static/css/bootstrap-responsive.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/static/js/google-code-prettify/prettify.css" rel="stylesheet" type="text/css">
	<%-- <link href="<%=request.getContextPath()%>/static/css/pshow.css" rel="stylesheet" type="text/css"> --%>
	
		<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/perfect-scrollbar.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/style.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/flexslider.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/fontello.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/jquery.fancybox.css">
		
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/1.6.2/jquery.min.js"></script>
	<script type="text/javascript">
		function pay(){
			document.detailform.action = "#";
			document.detailform.submit();
		}
		
		function addToCart(){
			document.detailform.action="<%=request.getContextPath()%>/addToCart?id=${requestScope.product.productId}";
			document.detailform.submit();
		}
		function showBigImg(imgPath){
		    bigImg.src = imgPath;
		}
		
		$(document).ready(function(){
			$("#addToCart").click(function(){
				$.ajax(
						{
							url:"<%=request.getContextPath()%>/addToCart?id=${requestScope.product.productId}",
							type:"get",
							data:{num:$('#text_box').val()},
							success:function (data){
								if(data=="0"){
									window.location.href="<%=request.getContextPath()%>/tologin";
								}
							}
						}
					);
			});
		});
	</script>
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
	
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/head.jsp"></jsp:include>
	<div class="container-fluid">
	  
  <div class="row-fluid">
  <div class="span5">
  <div class="col-lg-4 col-md-4 col-sm-4 product-single-image">
								
								<div id="product-slider">
									<ul class="slides">
										<li>
											<img class="cloud-zoom" src="<%=request.getContextPath()%>/imgout?imgurl=${requestScope.product.mainImgUrl}" data-large="<%=request.getContextPath()%>/imgout?imgurl=${requestScope.product.mainImgUrl}"  alt="">
											<a class="fullscreen-button" href="<%=request.getContextPath()%>/imgout?imgurl=${requestScope.product.mainImgUrl}">
												<div class="product-fullscreen">
													<i class="icons icon-resize-full-1"></i>
												</div>
											</a>
										</li>
									</ul>
								</div>
								<div id="product-carousel">
									<ul class="slides">
										<c:forEach var="img" items="${requestScope.product.images}">
							    			<li>
											<a class="fancybox" rel="product-images" href="<%=request.getContextPath()%>/imgout?imgurl=${img.imageUrl}"></a>
											<img src="<%=request.getContextPath()%>/imgout?imgurl=${img.imageUrl}" data-large="<%=request.getContextPath()%>/imgout?imgurl=${img.imageUrl}" alt="">
											</li>
							    		</c:forEach>
										
									</ul>
									<div class="product-arrows">
										<div class="left-arrow">
											<i class="icons icon-left-dir"></i>
										</div>
										<div class="right-arrow">
											<i class="icons icon-right-dir"></i>
										</div>
									</div>
								</div>
     </div>
	   
</div>
		<div class="span7">
		   <div class="row-fluid">
				<h3><strong>${requestScope.product.productName }</strong></h3>
		   </div>
		     <hr/>
		   <div class="row-fluid" style="height: 50px;" id="price">
				<div class="span2">单    价:</div>
		   		<div class="span10">￥${requestScope.product.price}</div>
		   </div>
		   <div class="row-fluid" style="height: 50px;">
		   		<div class="span2">服    务:</div>
		   		<div class="span10">由寻真水果负责发货，并提供售后服务。</div>
		   </div>
		   <form class="form-inline" name="detailform" method="post">
			   <div class="row-fluid" style="height: 50px;">
			   		<div class="span2">购买数量:</div>
			   		<div class="span10">
			   			<script>
								$(function(){
									var t = $("#text_box");
									
									var inventory = ${requestScope.product.inventory};
									$("#add").click(function(){
										if(parseInt(t.val())>=1 && parseInt(t.val())<=inventory){
											t.val(parseInt(t.val())+1)
											setTotal();
										} else {
											$("#add").attr('disabled',"true");
										}
										
									})
									$("#min").click(function(){
										if(parseInt(t.val())>=1 && parseInt(t.val())<=inventory){
											t.val(parseInt(t.val())-1)
											setTotal();
										} else {
											$("#min").attr('disabled',"true");
										}
									})
									
									setTotal();
								})
								
								function setTotal(){
										var t = $("#text_box");
										var s_price = ${requestScope.product.price};
										var inventory = ${requestScope.product.inventory};
										if(parseInt(t.val())>=1 && parseInt(t.val())<=inventory){
											$("#total").html("总价:"+(parseInt(t.val())*s_price).toFixed(2));
										} else {
											$("#msg").attr('color', "red");
											$("#total").html("请输入正确的数量！");  
										};
										
									}
						</script>
						<input id="min" class="btn" type="button" value="-" />
						<input id="text_box" name="num" class="input-mini text-center" type="text" value="1" onchange="setTotal();"/>
						<input id="add" class="btn" type="button" value="+" />
							（库存:<label>${requestScope.product.inventory}</label>）
						<p id="msg" style="margin-top: 20px;"><label id="total"></label></p>
			   		</div>
				</div>
				<script>
					$(function(){
						$("#pro_toCon").click(function(){
							var url_ = "<%=request.getContextPath()%>/BMgrLoader/addFavorites";
							$.ajax({
								url : url_,
								type : "post",
								data : {
										fid : "${requestScope.product.productId}",
										ftype : "1"
								},
								success : function(data) {
									alert(22);
								}
							});
						});
					});
				</script>

				<div class="row-fluid">
			   	<div class="span2"></div>
				<div class="span10">
		   			<input type="button" class="btn btn-danger" value="直接付款" onclick="">
			   		<input type="submit" class="btn btn-danger" 
			   			style="margin-left: 20px;" value="加入购物车" id="addToCart">
			   		<button class="btn btn-danger" id="pro_toCon">收藏</button>
										
				</div>
			</div>
		</form>
	</div>
  </div>
  <div class="row-fluid" style="margin-top: 40px;">
    <div class="span4 thumbnail" style="width: 250px;margin-left: 15px;">
      <dl>
        <dt>店&nbsp;&nbsp;铺:&nbsp;<font color="#0066FF">${shop.shopName }</font></strong></dt>
        <hr/>
        <dt>综合评分：${requestScope.product.score }</dt>
        <hr/>
        <dt>在线客服：<a href="#" class="btn btn-danger">联系客服</a></dt>
        <hr/>
        <dt class="text-center"><a href="<%=request.getContextPath()%>/toSellerShop?id=${shop.shopId}"><font color="#0033FF">进入卖家店铺</font></a></dt>
      </dl>
    </div>
    <div class="span8" style="margin-left: 100px;">
    	<ul id="myTab" class="nav nav-tabs">
              <li class="active"><a href="#instuction" data-toggle="tab">商品简介</a></li>
              <li><a href="#comment" data-toggle="tab">商品评论</a></li>
        </ul>
        <div  class="tab-content">
          <div class="tab-pane fade in active" id="instuction">
            ${sessionScope.description}
          </div>
          <div class="tab-pane fade" id="comment">
            <c:if test="${empty requestScope.product.evaluates}">
            	<p class="text-left">暂无评价!</p>
            </c:if>
            <c:if test="${!empty requestScope.product.evaluates}">
            	<c:forEach var="eva" items="${requestScope.product.evaluates}" varStatus="idx">
            		<div class="row-fluid">
            			<div class="span6 text-left">
            				<p>${eva.orderItem.buyer.username}:${eva.productEval}</p>
            			</div>
            			<div class="span2 text-left">给分:${eva.shopEvaluation}</div>
            			<div class="span4 text-right">
            				<p>${eva.postTime}</p>
            			</div>
            		</div>
            		<hr>
            	</c:forEach>
            </c:if>
          </div>
        </div>
    </div>
  </div>
  <hr>
  <div class="row-fluid">
    <div class="span3">
      <div align="center">
        <h4>我是新手</h4>
      </div>
      <div align="center"><a href="#">购物流程</a></div>
      <div align="center"><a href="#">常见问题</a></div>
      <div align="center"><a href="#">联系客服</a></div>
    </div>
    <!-- /span -->
    <div class="span3">
      <div align="center">
        <h4>支付方式</h4>
      </div>
      <div align="center"><a href="#">货到付款</a></div>
      <div align="center"><a href="#">支付宝</a></div>
      <div align="center"><a href="#">分期付款</a></div>
      <div align="center"><a href="#">邮局汇款</a></div>
    </div>
    <!-- /span -->
    <div class="span3">
      <div align="center">
        <h4>配送方式</h4>
      </div>
      <div align="center"><a href="#">上门提货</a></div>
      <div align="center"><a href="#">EMS</a></div>
      <div align="center"><a href="#">其他快递</a></div>
    </div>
    <!-- /span -->
    <div class="span3">
      <div align="center">
        <h4>售后服务</h4>
      </div>
      <div align="center"><a href="#">售后政策</a></div>
      <div align="center"><a href="#">退款说明</a></div>
      <div align="center"><a href="#">退换货</a></div>
      <div align="center"><a href="#">取消订单</a></div>
    </div>
  </div>
  <hr>
  <footer>
    <p class="text-center">&copy; J2ee.ustcsz.edu 2013, All Rights Reserved</p>
  </footer>
</div>
<!--/.fluid-container--> 

				<!-- Le javascript
				    ================================================== --> 
				<!-- Placed at the end of the document so the pages load faster --> 
				<script src="<%=request.getContextPath() %>/static/js/jquery.js"></script> 
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-transition.js"></script> 
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-alert.js"></script> 
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-modal.js"></script> 
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-dropdown.js"></script> 
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-scrollspy.js"></script> 
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-tab.js"></script> 
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-tooltip.js"></script> 
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-popover.js"></script> 
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-button.js"></script>
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-collapse.js"></script> 
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-carousel.js"></script> 
				<script src="<%=request.getContextPath() %>/static/js/bootstrap-typeahead.js"></script>
				
				
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