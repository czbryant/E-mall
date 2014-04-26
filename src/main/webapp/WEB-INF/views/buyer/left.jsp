<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>我的主页</title>
    <script type="text/javascript">
		function showcontent(content){  
   				$('#content').load(content + '.html');
			} 
    </script>
    <script type="text/css">
		div#box {
			height: 150px;
			width: 150px;
			float: left;
			}
    </script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery.js"></script>
        <!-- Le styles -->
        <link href="<%=request.getContextPath() %>/static/css/bootstrap3.min.css" rel="stylesheet">
        <style type="text/css">
          body {
            padding-top:1px;
            padding-bottom: 40px;
          }
          .sidebar-nav {
            padding: 0px 0;
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
	<div class="container">
      <div class="row">
		<div class="col-md-3" id="sidebar" role="navigation">
              <div class="list-group">
                <a class="list-group-item active" data-collapsed="">我的购物栏</a>
                <a href="<%=request.getContextPath() %>/BMgrLoader/loadCenter" target="right" class="list-group-item">我的主页</a>
                <a href="<%=request.getContextPath() %>/BMgrLoader/loadArrive" target="_parent" class="list-group-item">待确认收货&nbsp;<span style="color: blue;">(${requestScope.arriveCounts})</span></a>
                <a href="<%=request.getContextPath() %>/BMgrLoader/loadOrder" target="right" class="list-group-item">我的订单</a>
                <!-- <a href="<%=request.getContextPath() %>/BMgrLoader/loadAlreadyBuy" target="right" class="list-group-item">已购买物品</a> -->
                <a href="<%=request.getContextPath() %>/BMgrLoader/loadConnection" target="right" class="list-group-item">我的收藏夹</a>                               
                <a class="list-group-item active">我的账户信息</a>
                <a href="<%=request.getContextPath() %>/BMgrLoader/loadPerINF" target="right" class="list-group-item">个人信息</a>
                <a href="<%=request.getContextPath() %>/BMgrLoader/loadAddr" target="right" class="list-group-item">地址管理</a>
                <a href="<%=request.getContextPath() %>/BMgrLoader/loadSecurity" target="right" class="list-group-item">安全中心</a>                
                <a class="list-group-item active">我的反馈</a>
                <!-- <a href="<%=request.getContextPath() %>/BMgrLoader/loadComplaint" target="right" class="list-group-item">我要投诉</a> -->
                <a href="<%=request.getContextPath() %>/BMgrLoader/loadAssess" target="_top" class="list-group-item">我要评价&nbsp;<span style="color: blue;">(${requestScope.evaCounts})</span></a>
              </div>
            </div><!--/span-->
      </div><!--/row-->
     </div>
</body>
</html>