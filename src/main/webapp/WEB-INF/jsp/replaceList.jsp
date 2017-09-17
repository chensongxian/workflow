<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<html>
<head>
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<title>委托</title>
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

<div class="btn-group" style="margin-left: 30px">
	<button class="btn-success" onclick="addReplace()">添加</button>
</div>
<div class="container" style="width: 99%;margin: 10px auto" >
	<div class="panel-body">
		<!-- 是一个表格  添加一种效果-->
		<table class="table table-striped table-bordered " id="tb_taskLisk">
		</table>
	</div>

</div>

<jsp:include page="common/footer.jsp" />

</body>

<script>

	$(function(){
		$("#tb_taskLisk").bootstrapTable({
			url:'${ctx}/replace/list',
			striped : true,
			dataType: 'json',
			contentType: "application/x-www-form-urlencoded",
			pagination : true,
			method:'post',
			singleSelect: false,
			clickToSelect: true,
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
					field: 'processKey',
					align: 'center'
				},
				{
					title: '委托人',
					field: 'changePerson',
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
					title: '状态',
					field: 'agree',
					align: 'center',
					formatter:function(value,row,index){
						if(value==0){
							return "待回复";
						}
						if(value ==1){
							return "同意";
						}
						if(value ==2){
							return "不同意";
						}
					}
				},
				{
					title: '操作',
					align: 'center',
					field:"id",
					formatter:function(value,row,index){
							return	'<button class="btn btn-xs btn-danger"  onclick="deleteBtn('+row.id+')">删除</button>';
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
	function addReplace() {
		url = "${ctx}/replace/gotoAdd",
				art.dialog.open(url, {
					title: "新增委托",
					id: 'detail',
					width: 1300,
					height: 600,
					lock: true,
					opacity: 0.3,
					close: function () { //关闭弹出层事件
						$("#tb_taskLisk").bootstrapTable('refresh');

					}
				});
	}
	function deleteBtn(id){
		$.ajax({
			url:"${ctx}/replace/deleteByIds?ids="+id,
			dataType:"json",
			success:function (data) {
				alert(data.message);
				if(data.success){
					$("#tb_taskLisk").bootstrapTable('refresh');
				}
			}

		})
	}



</script>


</html>


