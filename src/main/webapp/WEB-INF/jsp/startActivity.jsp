<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<title>启动流程</title>
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
	流程名称：<input type="text" name="name" id="name">
	类别：    <select name="processCategory" style="width: 200px;height: 20px"  id="type">
			<option value="">请选择</option>
			</select>
	<button type="button" class="btn btn-sm btn-success" onclick="searchfn()">搜索</button>
	<button type="button" onclick="clearForm()" class="btn btn-sm btn-default">清空</button>
</div>
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
			url:'${ctx}/startActivity/startActivityPage',
			striped : true,
			dataType: 'json',
			pagination : true,
			contentType: "application/x-www-form-urlencoded",
			method:'post',
			width:	80,
			pageList : [ 3, 5, 20 ],
			pageSize : 20,
			pageNumber : 1,
			queryParamsType: "",//这里只是选择适合我后台的逻辑，可以选择传入页数和显示数量
			queryParams : queryParams,
			sidePagination : 'server',//设置为服务器端分页
			columns: [
				{
					title: '名称',
					field: 'processDefName',
					align: 'center'
				},
				{
					title: '流程类别',
					field: 'processCategory',
					align: 'center',
				},
				{
					title: '操作',
					field: 'defKey',
					align: 'center',
					formatter:function(value,row,index){

							return '<button class="btn btn-xs btn-danger"  onclick="startActivity(\''+value+'\')">发起</button>' +

									'<button class="btn btn-xs btn-success" onclick="showPicWindow(\''+value+'\')" style="margin-top: 0px">流程图 </button>';

						/*return '<button class="btn btn-danger" id="row'+index+'"  onclick="doTask('+rows+')">审核</button>';*/
					}
				}

			]
		});
		//前端提交的数据
		function queryParams(params) {
			return {
				pageSize : params.pageSize,//键就是自己后台的参数
				page : params.pageNumber,
				name:$("#name").val(),
				processCategory:$("#type").val()
			};
		}

		$.ajax({
			url:"${ctx}/processType/query",
			type:"post",
			dataType:"json",
			async:false,
			success:function (data) {
				for (var i = 0; i < data.length; i++) {
					$("#type").append("<option value='" + data[i].codeId + "'>" + data[i].name + "</option>");

				}
			}

		})


	});

	function searchfn() {
		console.info("sss");
		$("#tb_taskLisk").bootstrapTable('refresh');
	}

	function showPicWindow(key) {
		url = "${ctx}/activitiPic/lookPicBeforeStart?key="+key,
				art.dialog.open(url, {
					title: "流程图",
					id: 'detail',
					width: 1300,
					height: 500,
					lock: true,
					opacity: 0.3
				});
	}

	//启动流程
	function startActivity(key)
	{
		window.location.href="${ctx}/startActivity/qotoStartForm?processKey="+key;
	}

</script>


</html>


