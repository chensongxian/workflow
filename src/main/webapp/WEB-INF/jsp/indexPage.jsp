<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
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
<%--<div class="panel panel-info" style="position: absolute;width: 45%;height: 50%">
	<div class="panel-heading">
		<h3 class="panel-title">委托回复</h3>
	</div>
	<div class="panel-body">
		<table class="table table-striped table-bordered " id="tb_taskLisk">
		</table>
	</div>
</div>--%>

<jsp:include page="common/footer.jsp" />

</body>

<script>

	$(function(){
		$("#tb_taskLisk").bootstrapTable({
			url:'${ctx}/replace/queryAgreePage',
			striped : true,
			height:200,
			dataType: 'json',
			method:'post',
			pagination : true,
			contentType: "application/x-www-form-urlencoded",
			singleSelect: false,
			clickToSelect: true,
			width:	80,
			pageList : [ 3, 5, 20 ],
			pageSize : 5,
			pageNumber : 1,
			queryParamsType: "",//这里只是选择适合我后台的逻辑，可以选择传入页数和显示数量
			queryParams : queryParams,
			sidePagination : 'server',//设置为服务器端分页
			columns: [
				{
					title: '流程类型',
					field: 'processKey',
					align: 'center'
				},
				{
					title: '委托人',
					field: 'checkPerson',
					align: 'center'
				},
				{
					title: '开始时间',
					field: 'startTime',
					align: 'center',
					formatter:function(value,row,index){
						var i = value.lastIndexOf(".");
						return value.substring(0,i);
					}
				},
				{
					title: '结束时间',
					field: 'endTime',
					align: 'center',
					formatter:function(value,row,index){
						var i = value.lastIndexOf(".");
						return value.substring(0,i);
					}
				},
				{
					title: '操作',
					align: 'center',
					field:"id",
					formatter:function(value,row,index){
						return	'<button class="btn btn-xs btn-success"  onclick="yesAgree('+row.id+')">同意</button>' +
								'<button class="btn btn-xs btn-danger"  onclick="noAgree('+row.id+')">不同意</button>';
					}
				}

			]
		});
		//前端提交的数据
		function queryParams(params) {
			return {
				pageSize : params.pageSize,//键就是自己后台的参数
				page : params.pageNumber,
				agree: 0,
			};
		}

	});


	/**
	 * 同意
	 * @param id
     */
	function  yesAgree(id) {
		if(confirm("你确认要同意委托？")){
			$.ajax({
				url: "${ctx}/replace/updateAgree?agree=1&id="+id,
				dataType:"json",
				success:function (data) {
					if(data.success){
						alert("处理成功");
						$("#tb_taskLisk").bootstrapTable("refresh");
					}
				}
			})
		}

	}

	/**
	 * 不同意该代签
	 * @param id
	 */
	function  noAgree(id) {
		if(confirm("你确认要不同意委托吗？")) {
			$.ajax({
				url: "${ctx}/replace/updateAgree?agree=2&id="+id,
				dataType:"json",
				success:function (data) {
					if(data.success){
						alert("处理成功");
						$("#tb_taskLisk").bootstrapTable("refresh");
					}
				}
			})
		}


	}





</script>


</html>


