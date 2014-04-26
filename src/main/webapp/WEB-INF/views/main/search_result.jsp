<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta>
    <title>E-Mall</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="<%=request.getContextPath()%>/static/css/bootstrap.css" rel="stylesheet">
    <script src="<%=request.getContextPath()%>/static/js/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/static/js/bootstrap-paginator.js" type="text/javascript"></script>
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
    <link href="<%=request.getContextPath()%>/static/css/bootstrap-responsive.css" rel="stylesheet">

</head>
<body>
	<jsp:include page="/WEB-INF/views/main/head.jsp"></jsp:include>
	<div class="container-fluid">
		<c:if test="${!empty requestScope.queryResult}">
			<div class="row">
				<c:forEach var="product" items="${requestScope.queryResult}">
					<div class="span4">
		            	<a class="thumbnail" onclick="window.location.href='<%=request.getContextPath()%>/toDetail?id=${product.productId}'">
		            		<img data-src="holder.js/100%x180" alt="Responsive image" 
		      			src="<%=request.getContextPath()%>/imgout?imgurl=${product.mainImgUrl}"
		      			class="img-rounded img-responsive" style="hight:200px; width:200px" >
	            	</a>
	            	<div class="caption">
							<a onclick="window.location.href='<%=request.getContextPath()%>/toDetail?id=${product.productId}'">
								<p class="text-center">${product.productName}&nbsp;${product.price}￥</p>
							</a>
					</div>
	            </div>
				</c:forEach>
			</div><!-- 搜索结果展示 row1 -->
			
			<div class="row-fluid">
				<div id="pageChange" style="text-align: center;margin-top: 20px;"></div>
				<%-- <c:set var="totalPages" value="${requestScope.queryResult.totalRecord} / 3 + 1"/> --%>
				<script type="text/javascript">
				var options = {
			            currentPage: ${currentPage},
			            totalPages: ${totalpages},
			            pageUrl: function(type, page, current){
			            	return "<%=request.getContextPath()%>/search?page=" + page + "&productname=${sessionScope.queryname}";
			            }
			        }
			        $('#pageChange').bootstrapPaginator(options);
				</script>
			</div><!-- 翻页 row2 -->
		</c:if>	
	</div>
	<hr>
	<footer>
        <p class="text-center">&copy; J2ee.ustcsz.edu 2013, All Rights Reserved</p>
    </footer>
</body>
</html>