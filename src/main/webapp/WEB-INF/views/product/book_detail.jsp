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
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
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
	    <nav class="span12">
	      <ul class="breadcrumb">
	        <li><a href="#"><font size="+2">书籍</font></a><span class="divider"></span></li>
	        <li><a href="#">计算机类图书</a><span class="divider">></span></li>
	      </ul>
	    </nav>
	  </div>
  <div class="row-fluid">
	    <div class="span5">
	    	<div class="row-fluid">
	    		<div style="border: 1px solid #000">
	    			<img id="bigImg" width="400" height="266" src="${requestScope.product.mainImgUrl}">
	    		</div>
	    	</div>
	    	<div class="row-fluid">
	    		<c:forEach var="img" items="${requestScope.product.images}">
	    			<div class="span2">
	    				<img src="<%=request.getContextPath()%>/${img.imageUrl}" onmousemove="showBigImg('<%=request.getContextPath()%>/${img.imageUrl}')">
	    			</div>
	    		</c:forEach>
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
		   		<div class="span10">由新华书店负责发货，并提供售后服务。</div>
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
			   <div class="row-fluid">
			   		<div class="span2"></div>
			   		<div class="span10">
			   			<input type="button" class="btn btn-danger" value="直接付款" onclick="">
			   			<input type="submit" class="btn btn-danger" 
			   				style="margin-left: 20px;" value="加入购物车" onclick="addToCart();">
			   		</div>
			   </div>
		   </form>
	</div>
  </div>
  <div class="row-fluid" style="margin-top: 40px;">
    <div class="span4 thumbnail" style="width: 250px;margin-left: 65px;">
      <dl>
        <dt>卖&nbsp;&nbsp;家:&nbsp;<font color="#0066FF">新华书店</font></strong></dt>
        <hr/>
        <dt>综合评分：9.5</dt>
        <hr/>
        <dt>评分明细&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-1">与行业相比</font></dt>
        <dt>商品评分：9.62</dt>
        <dt>服务评分：9.30</dt>
        <dt>时效评分：9.73</dt>
        <hr/>
        <dt>在线客服：<a href="#" class="btn btn-danger">联系客服</a></dt>
        <hr/>
        <dt>公司名称：新华书店全国连锁</dt>
        <dt>所&nbsp;&nbsp;在&nbsp;&nbsp;地：江苏 苏州市</dt>
        <hr/>
        <dt class="text-center"><a href="#"><font color="#0033FF">进入卖家店铺</font></a></dt>
      </dl>
    </div>
    <div class="span8" style="margin-left: 60px;">
    	<ul id="myTab" class="nav nav-tabs">
              <li class="active"><a href="#instuction" data-toggle="tab">商品简介</a></li>
              <li><a href="#comment" data-toggle="tab">商品评论</a></li>
              <li><a href="#weibo" data-toggle="tab">微博评论</a></li>
        </ul>
        <div  class="tab-content">
          <div class="tab-pane fade in active" id="instuction">
            ${sessionScope.description}
          </div>
          <div class="tab-pane fade" id="comment">
            <p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit. Keytar helvetica VHS salvia yr, vero magna velit sapiente labore stumptown. Vegan fanny pack odio cillum wes anderson 8-bit, sustainable jean shorts beard ut DIY ethical culpa terry richardson biodiesel. Art party scenester stumptown, tumblr butcher vero sint qui sapiente accusamus tattooed echo park.</p>
          </div>
          <div class="tab-pane fade" id="weibo">
            <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade. Messenger bag gentrify pitchfork tattooed craft beer, iphone skateboard locavore carles etsy salvia banksy hoodie helvetica. DIY synth PBR banksy irony. Leggings gentrify squid 8-bit cred pitchfork. Williamsburg banh mi whatever gluten-free, carles pitchfork biodiesel fixie etsy retro mlkshk vice blog. Scenester cred you probably haven't heard of them, vinyl craft beer blog stumptown. Pitchfork sustainable tofu synth chambray yr.</p>
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
</body>
</html>