<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
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
<%--<jsp:include page="header.jsp"/>--%>
<%--<div class="panel">--%>
<div class="container" style="width: 99%;margin: 10px auto" >
	<div class="panel-body">
		<!-- 是一个表格  添加一种效果-->
		<table class="table table-striped table-bordered " id="tb_taskLisk">
		</table>
	</div>

</div>

<div class="modal" id="goBackHandle">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title">流程图</h4>
			</div>
			<div class="modal-body">

			</div>
		</div>
	</div>
</div>
<jsp:include page="common/footer.jsp" />

</body>

<script>

	$(function(){
		$("#tb_taskLisk").bootstrapTable({
			url:'${ctx}/informAct/informActPage',
			contentType: "application/x-www-form-urlencoded",
			striped : true,
			dataType: 'json',
			pagination : true,
			method:'post',
			width:	80,
			pageList : [ 3, 5, 20 ],
			pageSize : 10,
			pageNumber : 1,
			queryParamsType: "",//这里只是选择适合我后台的逻辑，可以选择传入页数和显示数量
			queryParams : queryParams,
			sidePagination : 'server',//设置为服务器端分页
			columns: [
				{
					title: '流程类型',
					field: 'processId',
					align: 'center',
					formatter:function(value,row,index){
						var s = "";
						$.ajax({
							url:'${ctx}/histroyProcessQuery/queryProcessById?processId='+row.processId,
							dataType:"json",
							async:false,
							success:function (data) {
								s=data.processName;
							}
						})
						return s;
					}
				},
				{
					title: '知会操作人',
					field: 'opertPersonName',
					align: 'center'
				},
				{
					title: '知会时间',
					field: 'createTime',
					align: 'center',
					formatter:function(val,row,index){
						return new Date(val).Format("yyyy-MM-dd hh:mm:ss");
					}
				},
				{
					title: '详情',
					field: 'taskId',
					align: 'center',
					formatter:function(value,row,index){
						return '<button class="btn btn-xs btn-danger" onclick="taskInfo(\''+row.processId+'\')">详情</button>' +
								'<button class="btn btn-xs btn-success" onclick="showPicWindow(\''+row.processId+'\')">流程图</button>';
					}
				},
				{
					title: '日志',
					field: 'processId',
					align: 'center',
					formatter: function (value, row, index) {
						return '<button class="btn btn-xs btn-default"  onclick="lookLog(\''+value+'\')">日志</button>';
					}
				}

			]
		});
		//前端提交的数据
		function queryParams(params) {
			return {
				pageSize : params.pageSize,//键就是自己后台的参数
				page : params.pageNumber
			};
		}

	});
	function showPicWindow(processId) {
		url = "${ctx}/activitiPic/lookPic?processId="+processId,
				art.dialog.open(url, {
					title: "流程图",
					id: 'detail',
					width: 1300,
					height: 500,
					lock: true,
					opacity: 0.3
				});


	}
	function taskInfo(processId) {
		var detailurl = "${ctx}/startActivity/inviteForm?processId="+processId;
		//alert(detailurl);
		art.dialog.open(detailurl, {
			title: "审批详情",
			id: 'detail',
			width: 800,
			height: 600,
			lock: true,
			opacity: 0.3
		});

	}
	function lookLog(processId) {
		url = "${ctx}/doLog/goToLog?processId="+processId,
				art.dialog.open(url, {
					title: "日志",
					id: 'detail',
					width: 800,
					height: 400,
					lock: true,
					opacity: 0.3
				});

	}



</script>


</html>


