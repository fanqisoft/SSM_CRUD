<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>

<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!-- 
			Web路径问题
不以 / 开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以 / 开始的相对路径，找资源，以服务器的路径为标准（http：//localhost：3306）：需要加上项目名
				http：//localhost：3306/ssm_crud
 -->
	<!-- 引入Jquery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <!-- Bootstrap CSS -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入Bootstrap JS -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题行 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-2 col-md-offset-10">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover table-bordered">
					<tr>
						<th>序号</th>
						<th>员工姓名</th>
						<th>性别</th>
						<th>电子邮箱</th>
						<th>部门名称</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId } </th>
							<th>${emp.empName }</th>
							<th>${emp.gender == "M"?"男":"女" }</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn btn-primary btn-sm">
								编辑
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
								</button>
								<button class="btn btn-danger btn-sm">
								删除
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								</button>
							</th>
						</tr>		
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				当前${pageInfo.pageNum}页,总${pageInfo.pages }页,总${pageInfo.total }条记录
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
		    		<c:if test="${pageInfo.pageNum == 1  }">
			    		<li class="disabled"><a href="#">首页</a></li>
			    	</c:if>
			    	<c:if test="${pageInfo.pageNum != 1  }">
   			    		<li><a href="${APP_PATH }/emps">首页</a></li>
					    <li>
					      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
			    	</c:if>  
				    <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num"> 
				    	<c:if test="${page_Num == pageInfo.pageNum  }">
				    		<li class="active"><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num }</a></li>
				    	</c:if>
				    	<c:if test="${page_Num != pageInfo.pageNum  }">
		   				    <li><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num }</a></li>
				    	</c:if>  
				    </c:forEach>
   		    		<c:if test="${pageInfo.pageNum == pageInfo.pages  }">
					    <li class="disabled"><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">末页</a></li>
			    	</c:if>
			    	<c:if test="${pageInfo.pageNum != pageInfo.pages  }">
					    <li>
					      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					    <li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">末页</a></li>
			    	</c:if> 
				  </ul>
				</nav>
			</div>
		</div>
	</div>
	

</body>
</html>