<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript">
	var req;
	var lastItem;
	var parentOrBrother = "b";

	function init() {
		if (window.XMLHttpRequest) {
			req = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}

	function changeDrop1() {
		init();
		var url = "GetProductTypeChilds?id="
				+ escape(document.frm.parent.options[document.frm.parent.selectedIndex].value);
		lastItem = escape(document.frm.parent.options[document.frm.parent.selectedIndex].value);
		
		req.open("GET", url, true);
		req.onreadystatechange = callback;
		req.send(null);
	}

	function changeDrop2() {
		init();
		if(document.frm.child.options[document.frm.child.selectedIndex].value == "-1")
			parentOrBrother = "p";
		else
			lastItem = escape(document.frm.child.options[document.frm.child.selectedIndex].value);
		var url = "GetProductTypeGrandChilds?id="
				+ escape(document.frm.child.options[document.frm.child.selectedIndex].value);
		
		req.open("GET", url, true);
		req.onreadystatechange = callback;
		req.send(null); 
	}
	
	function changeDrop3() {
		if(document.frm.grandson.options[document.frm.grandson.selectedIndex].value == "-1")
			parentOrBrother = "p";
		else
			lastItem = escape(document.frm.grandson.options[document.frm.grandson.selectedIndex].value);
	}
	
	function changeDrop4() {
		init();
		var url = "addProductType?id=" + escape(lastItem)
				+ "&b_OR_p=" + escape(parentOrBrother) 
				+ "&productType=" + escape(document.addform.productType.value);
		req.open("POST", url, true);
		req.onreadystatechange = callback;
		req.send(null);
	}

	function callback() {
		if (4 == req.readyState) {
			if (200 == req.status || 0 == req.status) {
				//alert(req.responseText + "  5555");
				//alert(lastItem);	
				//alert(parentOrBrother);
				eval(req.responseText);
			}
		}
	}
</script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员主页</title>

<script type="text/javascript"	src="<%=request.getContextPath()%>/static/js/jquery.js"></script>
<!-- Le styles -->
<link href="<%=request.getContextPath()%>/static/css/bootstrap.css"	rel="stylesheet">
<link href="<%=request.getContextPath()%>/static/css/bootstrap-responsive.css"	rel="stylesheet">
<link href="<%=request.getContextPath()%>/static/js/google-code-prettify.css"	rel="stylesheet">
<link href="<%=request.getContextPath()%>/static/js/docs.css"	rel="stylesheet">
</head>

<body>
	<div class="container">
		<div class="text-center">
			<h1>后台管理</h1>
		</div>
	</div>
	<div class="container">
		<div class="row-fluid">
			<div class="span3 bs-docs-sidebar">
				<ul class="nav nav-list bs-docs-sidenav">
					<li><a href="#download-bootstrap"><i
							class="icon-chevron-right"></i>广告 </a></li>
					<li><a href="#file-structure"><i
							class="icon-chevron-right"></i> 公告</a></li>
					<li><a href="#contents"><i class="icon-chevron-right"></i>商品类型</a></li>
				</ul>
			</div>

			<div class="span9">

				<!-- 广告
        ======================================================= -->
				<section id="download-bootstrap">
				<div class="page-header">
					<h1>1. 广告</h1>
				</div>
				<div class="row-fluid">
				
					<c:if test="${empty sessionScope.Advertisements}">
						<div class="hero-unit well">
							<h1>没有广告信息</h1>
						</div>
					</c:if>
					<c:if test="${!empty sessionScope.Advertisements}">
						<table class="table table-hover table-bordered" border="1">
							<caption>
								<h3>广告表管理</h3>
							</caption>
							<thead>
								<tr>
									<th></th>
									<th>Image</th>
									<th>简要介绍</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item_adv" items="${sessionScope.Advertisements}" varStatus="idx_adv">
									<script>
									$(function(){
									$("#${idx_adv.index}_delAdvBtn").click(
									function(){
										var url_ = "<%=request.getContextPath()%>/AdminController/deleteAdvertisement";
											$.ajax({	url : url_,
														type : "get",
														data : {
																id : "${item_adv.id}"},
														success : function(	data) {
															$("#${idx_adv.index}_tr_adv").remove();
														}
													});
										});
										

									});
									</script>
									<tr id="${idx_adv.index}_tr_adv">
										<td>
											<label class="checkbox"> 
											 <input type="checkbox" name="subBox" value="${item_adv.id }">
											</label>
										</td>
										<td>
											<img src="<%=request.getContextPath()%>/imgout?imgurl=${item_adv.imageURL}">
										</td>
										<td>
											${item_adv.profile}
										</td>
										<td>
											<button class="btn btn-danger" id="${idx_adv.index}_delAdvBtn">删除</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<button id="newAdvertisement" class="btn btn-success">添加新广告</button>
					</div>
				</div>

				<div id="myModal" class="modal hide fade">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h3 id="myModalLabel">添加新广告</h3>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" 
								action="<%=request.getContextPath()%>/AdminController/addAdvertisement" method="post" enctype="multipart/form-data">
							<div class="control-group">
								<label class="control-label">图片</label>
								<div class="controls">
									<input type="file" id="imageURL" name="imageURL">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="profile">简要介绍</label>
								<div class="controls">
									<textarea rows="3" cols="20" id="profile" name="profile" maxlength="30"
										placeholder="最大长度30"></textarea>
								</div>
							</div>

							<div class="control-group">
								<div class="controls">
									<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
									<button type="submit" class="btn btn-primary">保存</button>
								</div>
							</div>
						</form>
					</div>
				</div>

				<script type="text/javascript">
					var options = {
						backdrop : true,
						keyboard : true,
						show : true

					}
					$('#newAdvertisement').click(function() {
						$('#myModal').modal('toggle');
					});
				</script> 
				
				</section>



				<!-- 公告
        ========================================================== -->
				<section id="file-structure">
				<div class="page-header">
					<h1>2. 公告</h1>
				</div>

				<div class="row-fluid">
					<c:if test="${empty sessionScope.Announcements}">
						<div class="hero-unit well">
							<h1>没有公告信息</h1>
						</div>
					</c:if>
					<c:if test="${!empty sessionScope.Announcements}">
					<table class="table table-hover table-bordered" border="1">
						<caption>
							<h3>公告表管理</h3>
						</caption>
						<thead>
							<tr>
								<th></th>
								<th>标题</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="item_ann" items="${sessionScope.Announcements}" varStatus="idx_ann">
							<script>
								$(function(){
								$("#${idx_ann.index}_delAnnBtn").click(
									function(){
										var url_ = "<%=request.getContextPath()%>/AdminController/deleteAnnouncement";
											$.ajax({	url : url_,
														type : "get",
														data : {
																id : "${item_ann.id}"},
														success : function(	data) {
															$("#${idx_ann.index}_tr_ann").remove();
														}
													});
										});
										

									});
							</script>
							<tr id="${idx_ann.index}_tr_ann">
								<td>
									<label class="checkbox"> 
										<input type="checkbox" name="subBox" value="${item_ann.id }">
									</label>
								</td>
								<td>
									${item_ann.title}
								</td>
								<td>
									<button class="btn btn-danger" id="${idx_ann.index}_delAnnBtn">删除</button>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					</c:if>
				</div>
				<div class="row-fluid">
					<div class="span3 offset=span9">
						<button id="newAnnouncement" class="btn btn-success">添加新公告</button>
					</div>
				</div>

				<div id="myModal2" class="modal hide fade">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h3 id="myModalLabel">添加新公告</h3>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" action=
							"<%=request.getContextPath()%>/AdminController/addAnnouncement" method="post">
							<div class="control-group">
								<label class="control-label">标题</label>
								<div class="controls">
									<input type="text" id="announcementTitle" name="announcementTitle" maxlength="20"
										placeholder="最大长度20">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="announcementContent">公告内容</label>
								<div class="controls">
									 <textarea rows="10" cols="30" id="announcementContent" wrap="virtual"
										name="announcementContent" maxlength="2000" placeholder="最大长度2000"></textarea>
								</div>
							</div>

							<div class="control-group">
								<div class="controls">
									<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
									<button type="submit" class="btn btn-primary">保存</button>
								</div>
							</div>
						</form>
					</div>
				</div>

				<script type="text/javascript">
					var options = {
						backdrop : true,
						keyboard : true,
						show : true

					}
					$('#newAnnouncement').click(function() {
						$('#myModal2').modal('toggle');
					});
				</script> </section>



				<!-- Contents
        ================================================== -->
				<section id="contents">
				<div class="page-header">
					<h1>3. 商品类型</h1>
				</div>
				<div class="row-fluid">
					<form name="frm" method="get">
						<select name="parent" multiple="multiple" onchange="changeDrop1()">
							<c:forEach var="item_ptype" items="${sessionScope.ProductTypes}">
								<option value="${item_ptype.id}">${item_ptype.name}</option>
							</c:forEach>
						</select>
						<select name="child" multiple="multiple" onchange="changeDrop2()">
							<!--<option value="-1">Not Selected!</option>  -->
						</select>
						
						<select name="grandson" multiple="multiple"  onchange="changeDrop3()">
							<!--<option value="-1">Grandson Not Selected!</option>  -->
						</select>
					</form>
				</div>
				<div class="row-fluid">
					<div class="span3 offset=span9">
						<button id="newProductType" class="btn btn-success">添加新商品类型</button>
					</div>
				</div>

				<div id="myModal3" class="modal hide fade">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h3 id="myModalLabel">添加新商品类型</h3>
					</div>
					<div class="modal-body">
						<form class="form-horizontal"  name="addform" method="post">
							<div class="control-group">
								<label class="control-label">类型名称</label>
								<div class="controls">
									<input type="text" name="productType" maxlength="30"
										placeholder="最大长度30">
								</div>
							</div>
							<!-- 
							<div class="control-group">
								<label class="control-label" for="parentTypeID">父类型名称</label>
								<div class="controls">
									<input type="text" id="parentTypeID">
								</div>
							</div> -->

							<div class="control-group">
								<div class="controls">
									<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
									<button type="submit" class="btn btn-primary" onclick="changeDrop4()">保存</button>
								</div>
							</div>
						</form>
					</div>
				</div>

				<script type="text/javascript">
					var options = {
						backdrop : true,
						keyboard : true,
						show : true

					}
					$('#newProductType').click(function() {
						$('#myModal3').modal('toggle');
					});
				</script> </section>


			</div>
		</div>

	</div>
	
	


	<!-- Le javascript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->

	<script
		src="<%=request.getContextPath()%>/static/js/eusyui/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/static/js/bootstrap.js"></script>
	<script src="<%=request.getContextPath()%>/static/js/holder.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/static/js/google-code-prettify/prettify.js"></script>
	<script
		src="<%=request.getContextPath()%>/static/js/bootstrap-modal.js"></script>
	<script src="<%=request.getContextPath()%>/static/js/application.js"></script>

</body>
</html>