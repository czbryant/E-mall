<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/static/css/bootstrap.css" rel="stylesheet">
<style type="text/css">
      body {
        padding-top: 60px;
        padding-left: 40px;
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
<title>卖家首页</title>
</head>
<body>
	<form action="<%=request.getContextPath() %>/SMgrLoader/loadProductMgr" method="post">
		<div class="hero-unit container-fluid text-center" style="margin-right: 30px;">
			<div class="row-fluid" style="margin-bottom: 20px;">商品已成功上架！</div>
			<input type="submit" class="btn btn-danger" value="继续添加商品">
		</div>
		
	</form>
</body>
</html>