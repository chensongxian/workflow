<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<title>人员信息</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<!-- Bootstrap -->
	<jsp:include page="common/header.jsp"/>
	<style>
		body table {
			font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;
			font-size: 12px
		}
		.table thead{
			background-color: #d8d8d8;
		}
		.table tbody tr{
			height: 10px;
		}
		.table tbody tr th{
			vertical-align: middle;
		}
	</style>
</head>
<body>
<%--<jsp:include page="header.jsp"/>--%>
<%--<div class="panel">--%>

<div style="margin-left: 20px">
	<form id="searchForm">
		<tr>
			<td>姓名：</td>
			<input type="text" name="userName" id="userName">
			<button type="button" style="margin-left: 20px" class="btn btn-sm btn-success" onclick="searchfn()">搜索</button>
			<button type="button" onclick="clearForm()">清空</button>
		</tr>

	</form>
</div>
<div class="container" style="width: 99%;margin: 10px auto" >
	<div class="panel-body">
		<table class="table table-striped table-bordered " id="tb_taskLisk">
		</table>
		<form id="choseForm" action="${ctx}/${url}" method="post">
			<input hidden name="taskId", value="${param.taskId}">
			<input hidden name="processId", value="${param.processId}">
			<input hidden name="adminId" id="adminId">
		</form>

	</div>


	<div class="panel-footer">
		<center>
			<button type="button" class="btn btn-sm btn-primary" style="margin-right: 20px" onclick="submitbtn()">
				提交
			</button>
			<a class="btn btn-sm  btn-danger" href="javascript:mif.closeForm();" id="btnDelete"><i
					class="fa fa-times"></i>取消</a>
		</center>
	</div>
</div>

<jsp:include page="common/footer.jsp" />

</body>

<script>
	var queryParam ="";
	$(function(){
		$("#tb_taskLisk").bootstrapTable({
			url:'${ctx}/adminRole/getUserByUserLoginOrUserNameList',
			contentType: "application/x-www-form-urlencoded",
			striped : true,
			dataType: 'json',
			pagination : true,
			method:'post',
			width:	80,
			pageList : [ 5,10,15, 20,30 ],
			pageSize : 20,
			pageNumber : 1,
			queryParamsType: "",//这里只是选择适合我后台的逻辑，可以选择传入页数和显示数量
			queryParams : queryParams,
			strictSearch: true,
			sidePagination : 'client',//设置为服务器端分页
			columns: [
				{
					field: 'chick',
					checkbox: true
				},
				{
					title: '公司部门',
					field: 'departmentname',
					align: 'center',

				},
				{
					title: '岗位',
					field: 'specrolename',
					align: 'center',

				},
				{
					title: '姓名',
					field: 'adminname',
					align: 'center'
				}

			]
		});
		//前端提交的数据
		function queryParams(params) {
			//var roleName =  $("#role_name").val();
			return {
				pageSize : params.pageSize,//键就是自己后台的参数
				page : params.pageNumber,
				userName:$("#userName").val(),
			};
		}


	});

	function searchfn() {
			$("#tb_taskLisk").bootstrapTable('refresh');

	}
	function clearForm() {
		$("#branchname").val("");
		$("#departmentname").val("");
		$("#specrolename").val("");
		$("#adminname").val("")
		$("#tb_taskLisk").bootstrapTable('refresh');
	}


	/**
	 * 设置权限
	 * @param key
     */
	function addProcessRole(roleid) {
			url = "${ctx}/processRole/goToProcessPage?roleId="+roleid;
			art.dialog.open(url, {
				title: "添加",
				id: 'detail',
				width: 	800,
				height: 500,
				lock: true,
				opacity: 0.3,
			});
	}

	function submitbtn() {
		var rows = $("#tb_taskLisk").bootstrapTable('getSelections');
		if(rows==null || rows.length==0){
			alert("请选择人员");
			return;
		}
		if(rows.length>1){
			alert("请选择单个人员");
			return;
		}
		$("#adminId").val(rows[0].adminid);
		$("#choseForm").submit();

	}
</script>


</html>


