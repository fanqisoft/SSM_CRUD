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

<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">员工修改</h4>
      </div>
      <div class="modal-body">
      
		<form class="form-horizontal">
		  <div class="form-group">
		    <label for="empName_update_input" class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <p class="form-control-static" id="empName_update_static"></p> 
		       <span id="" class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="email_update_input" class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@fanqisoft.cn">
		      <span id="" class="help-block"></span>
		    </div>
		  </div>
  		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      	<label class="radio-inline">
			  		<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  	<input type="radio" name="gender" id="gender2_update_input" value="F"> 女
				</label>
		    </div>
		  </div>
		  
   		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-6">
		    	<!-- 部门提交部门ID即可 -->
				<select class="form-control" name="deptId" id="dept_update_select">
				</select>
		    </div>
		  </div>

		</form>
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>






<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
      
		<form class="form-horizontal">
		  <div class="form-group">
		    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
		       <span id="" class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="email_add_input" class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@fanqisoft.cn">
		      <span id="" class="help-block"></span>
		    </div>
		  </div>
  		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      	<label class="radio-inline">
			  		<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  	<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
				</label>
		    </div>
		  </div>
		  
   		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-6">
		    	<!-- 部门提交部门ID即可 -->
				<select class="form-control" name="deptId" id="dept_add_select">
				</select>
		    </div>
		  </div>

		</form>
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>




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
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover table-bordered" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"/></th>
							<th>序号</th>
							<th>员工姓名</th>
							<th>性别</th>
							<th>电子邮箱</th>
							<th>部门名称</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav-area">
			</div>
		</div>
	</div>
	
	<script>
		var totalRecord;   //定义一个js全局变量,用以保存总记录数
		
		var currentPage;  //定义一个js全局变量,用于保存当前页码数

		$(function(){
			to_page(1)
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"get",
				success:function(result){
					//1.解析并显示员工信息
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result)
					//3.解析显示分页条信息
					build_page_nav(result)
				}			
			});
		}
		//表格数据回调函数
		function build_emps_table(result)
		{
			//先清空元素然后填充
			$("#emps_table tbody").empty();
			
			var emps = result.extend.pageInfo.list;
			
			$.each(emps,function(index,item){
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				
				//为编辑按钮添加一个自定义的属性,来表示当前员工的id
				var editBtn  = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
									.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
									.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//为删除按钮添加一个自定义的属性,来表示当前员工的id
				delBtn.attr("del-id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append("&nbsp;").append(delBtn);
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(checkBoxTd)
							  .append(empIdTd)
							  .append(empNameTd)
							  .append(genderTd)
							  .append(emailTd)
							  .append(deptNameTd)
							  .append(btnTd)
							  .appendTo("#emps_table tbody");
			});
		}
		
		function build_page_info(result)
		{
			$("#page_info_area").empty();
			
			$("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,总"+result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"条记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		//解析显示分页条
		function build_page_nav(result)
		{
			$("#page_nav-area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));

			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			else{
				firstPageLi.click(function(){
					to_page(1);
				})
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}
			else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			
			ul.append(firstPageLi).append(prePageLi);
			
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				})
				ul.append(numLi);
			})		
			ul.append(nextPageLi).append(lastPageLi);		
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav-area");
		}
		
		//表单重置方法
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function(){
			//在操作之前清除表单数据(表达重置)
			reset_form("#empAddModal form");  
			//1.发出ajax请求,查出部门信息,显示在下拉列表中
			getDepts("#dept_add_select");
			//2.弹出模态框
			$('#empAddModal').modal({
				backdrop:"static"
			});
		})
		
		//查出所有的部门信息并显示在下拉列表中
		function getDepts(ele){
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"get",
				success:function(result){
					//console.log(result)
					//{"code":100,"msg":"处理成功!","extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
					//将返回的部门信息json填充到下拉列表中
					$.each(result.extend.depts,function(index,item){
						var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
						optionEle.appendTo(ele);
					})
				}		
			})
		}
		
		//校验表单数据
		function validate_add_form(){
			//1.拿到要检验的数据,使用正则表达式
			var empNameVal = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empNameVal)){
				//alert("用户名可以是2-5位中文或者是5-16位英文和数字的组合");
				show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者是5-16位英文和数字的组合")
				//$("#empName_add_input").parent().addClass("has-error");
				//$("#empName_add_input").next("span").text("用户名可以是2-5位中文或者是5-16位英文和数字的组合");
				
				return false;
			}
			else{
				show_validate_msg("#empName_add_input","success","")
				//$("#empName_add_input").parent().addClass("has-success").removeClass("has-error");
				//$("#empName_add_input").next("span").text("");
			}
			//2.检验邮箱信息
			var empEmailVal = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(empEmailVal)){
				//alert("邮箱格式不正确!");
				show_validate_msg("#email_add_input","error","邮箱格式不正确!")
				//$("#email_add_input").parent().addClass("has-error");
				//$("#email_add_input").next("span").text("邮箱格式不正确!");
				return false;
			}
			else{
				show_validate_msg("#email_add_input","success","")
				//$("#email_add_input").parent().addClass("has-success").removeClass("has-error");
				//$("#email_add_input").next("span").text("");
			}
			return true;
		}
		
		//显示校验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//首先应该清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if(status == "success"){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}
			else if(status == "error"){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		$("#emp_save_btn").click(function(){
			//1. 对表单中的数据进行校验
			if(!validate_add_form()){
				return false;
			}
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"post",
				data:$(".form-horizontal").serialize(),
				success:function(result){
					if(result.code == 100){
						alert("添加成功!");
						//1.关闭模态框
						$('#empAddModal').modal('hide');
						//2.发送ajax请求来到最后一页,显示刚才保存的数据.
						//to_page(9999);//因为分页插件页码不会超出总的页码数,所以输入一个较大的
						//页码是会转向到最后一页的,但随着数据量的增大,该逻辑会失效并错误.
						to_page(totalRecord);
						
					}
					else{
// 						//关闭模态框
// 						$('#empAddModal').modal('hide');
						if(undefined != result.extend.errorFields.email){
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email)
						}
						if(undefined != result.extend.errorFields.empName){
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName)
						}
					}
				}
			});
		});

		//检验用户名是否可用
		$("#empName_add_input").blur(function(){
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkEmpName",
				type:"get",
				data:"empName="+empName,
				success:function(result){
					if(result.code == 100){  //用户名可用
						show_validate_msg("#empName_add_input","success","用户名可用")
						$("#emp_save_btn").attr("ajax-va","success");
					}
					else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg)
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			})
		})
		
		$(document).on("click",".edit_btn",function(){
			//alert("编辑的点击事件!");
			//1.查出员工信息,显示员工信息
			getEmp($(this).attr("edit-id"));
			//2.查出部门信息,显示部门列表
			getDepts("#dept_update_select");
			//3.弹出模态框
			//把员工的ID传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$('#empUpdateModal').modal({
				backdrop:"static"
			});
		})
		
		//点击单个删除
		$(document).on("click",".delete_btn",function(){
			  var empName = $(this).parents("tr").find("td:eq(2)").text();
			  var empId = $(this).attr("del-id");
			  var empId2 = $(this).parents("tr").find("td:eq(1)").text();
			 if (confirm("你确定要删除 "+ empName + " 吗?")==true){ 
				 $.ajax({
					 url:"${APP_PATH}/emp/" + empId2,
					 type:"DELETE",
					 success:function(result){
						 if(result.code == 100){
							 alert("删除成功!");
							 to_page(currentPage);
						 }
					 }
				 })
			 }
			 else{
				alert("点击了取消!"); 
			 }
		})
		
		//获取员工信息
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/" + id,
				type:"get",
				success:function(result){
					console.log(result);
					if(result.code == 100){
						var empData = result.extend.emp;
						$("#empName_update_static").text(empData.empName);
						$("#email_update_input").val(empData.email);
						$("#empUpdateModal input[name=gender]").val([empData.gender]);
						$("#empUpdateModal select").val([empData.deptId]);
					}
					//{"code":100,"msg":"处理成功!","extend":{"emp":{"empId":7,"deptId":1,"empName":"5d6bb5","gender":"M","email":"5d6bb5@fanqisoft.cn","department":null}}}
				}
			})
		}
		
		//点击更新按钮
		$("#emp_update_btn").click(function(){
			//检验邮箱是否合适
			var emailVal = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(emailVal)){
				show_validate_msg("#email_update_input","error","邮箱格式不正确!")
				return false;
			}
			else{
				show_validate_msg("#email_update_input","success","")
			}
			
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//1. 关闭模态框
					$("#empUpdateModal").modal("hide");
					//2. 回到当前页面(异步刷新数据)
					to_page(currentPage);
				}			
			})	
		})
		
		//完成全选 / 全部选 功能
		
		$("#check_all").click(function(){
			//attr 获取 checked 是 undefined
			//应使用prop来获取和修改原生DOM属性的值,而使用attr来获取和修改自定义属性的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		})
		
		$(document).on("click",".check_item",function(){
			var flag = $(".check_item").length == $(".check_item:checked").length;
			$("#check_all").prop("checked",flag);
		})
		
		$("#emp_delete_all_btn").click(function(){
			var empNameList = "";
			var empIdList = "";
			$(".check_item:checked").each(function(index,item){
				empNameList += $(this).parents("tr").find("td:eq(2)").text() + ",";
				empIdList += $(this).parents("tr").find("td:eq(1)").text()+"-"
			})
			empNameList = empNameList.substring(0,empNameList.length-1);
			empIdList = empIdList.substring(0,empIdList.length-1);
			if(confirm("你确定要删除 "+ empNameList + " 吗?")==true){
				$.ajax({
					url:"${APP_PATH}/emp/" + empIdList,
					type:"DELETE",
					success:function(result){
						if(result.code == 100){
							alert("批量删除完成");
							to_page(currentPage);
						}
					}
				})
			}
			else{
				alert("点击了取消!");
			}
		})
	</script>

</body>
</html>