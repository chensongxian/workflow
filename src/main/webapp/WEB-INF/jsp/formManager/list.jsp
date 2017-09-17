<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <title></title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!-- Bootstrap -->
    <jsp:include page="../common/header.jsp"/>
    <style>
        body table {
            font-family: "Microsoft YaHei", SimSun, Arial, Helvetica, sans-serif;
            font-size: 12px
        }

        .table thead {
            background-color: #d8d8d8;
        }

        .table tbody tr {
            height: 10px;
        }

        .table tbody tr th {
            vertical-align: middle;
        }
    </style>
</head>
<body>

<div style="margin-left: 20px">
    <form id="searchForm">
        <tr>
            <td><span style="font-weight: bold;font-size: 12px">表单名称:</span>
                <input type="text" name="processName" id="processName">
            </td>
            <button type="button" class="btn btn-sm btn-success" onclick="searchfn()">搜索</button>
            <button type="button" onclick="clearForm()">清空</button>
        </tr>
    </form>
</div>

<div class="container" style="width: 99%;margin: 10px auto">
    <tr>
        <button class="btn   btn-primary" onclick="location.href='${ctx}/index.html'" style="margin-top: 0px">
            添加
        </button>

    </tr>
    <div class="panel-body">
        <table class="table table-striped table-bordered " id="tb_taskLisk">
        </table>
    </div>
    <div class="modal fade" id="activitiesName"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width:300px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h5 class="modal-title" id="myModalLabel">活动节点选择</h5>
                </div>
                <div class="modal-body" >
                   <table id="checkTask" style="text-align: center">

                   </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="choseBtton()">提交</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

    <div class="modal fade" id="cutActivities"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width:300px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h5 class="modal-title">活动节点选择</h5>
                </div>
                <div class="modal-body" >
                    <table id="checkTask2" style="text-align: center">

                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="choseCutBtton()">提交</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>











</div>
<jsp:include page="../common/footer.jsp"/>
</body>

<script>
    var queryParam = "";
    var processId = "";
    var taskId = "";
	var mapFormList=[];
    $(function () {
        $("#tb_taskLisk").bootstrapTable({
            url: '${ctx}/flowDiagram/queryPage.do',
            striped: true,
            dataType: 'json',
            pagination: true,
            contentType: "application/x-www-form-urlencoded",
            width: 80,
            pageList: [3, 5, 10, 15, 20],
            pageSize: 15,
            pageNumber: 1,
            queryParamsType: "",//这里只是选择适合我后台的逻辑，可以选择传入页数和显示数量
            queryParams: queryParams,
            method:'post',
            sidePagination: 'server',//设置为服务器端分页
            columns: [
                {
                    field: 'chick',
                    checkbox: true
                },
                {
                    title: '表单id',
                    field: 'formid',
                    align: 'center'
                },
                {
                    title: '页面数据',
                    field: 'parseform',
                    align: 'center',
                    formatter:function(index, row, element) {
                    	mapFormList[element]=row.parseform;
                    	var str=row.parseform
                    	if(str.length>50){
                    		str=str.substring(0,50)+"....";
                    	}
                    	return escapeHTML(str);
                    }
                },
                {
                    title: '表单名称',
                    field: 'formtype',
                    align: 'center',
                },
                {
                    title: '操作',
                    field: 'formid',
                    align: 'center',
                    formatter:function(index, row, element) {
                    	var editUrl="${ctx}/updateForm.html?formid="+row.formid
                    	var str='<button class="btn btn-xs btn-danger" onclick="location.href=\''+editUrl+'\'">编辑</button>';
                    	str+='&nbsp; <button class="btn btn-xs btn-danger" onclick="deleteForm('+row.formid+')">删除</button>'
                    	str+='&nbsp; <button class="btn btn-xs btn-danger" onclick="show('+element+')">预览</button>'
                    	return str;
                    }
                },
            ]
        });
        //前端提交的数据
        function queryParams(params) {
            return {
                pageSize: params.pageSize,//键就是自己后台的参数
                page: params.pageNumber,
                processName: $("#processName").val(),
            };
        }
    });


    function searchfn() {
        $("#tb_taskLisk").bootstrapTable('refresh');
    }
    function clearForm() {
        $("#processName").val("");
    }
    
    function show(index){
    	var win_parse=window.open('','','width=800,height=400,alwaysRaised=yes,top=100,left=200');
    	console.info("---" + mapFormList[index])
    	var str='<div style="border:1px solid grey">'+mapFormList[index]+'</div>';
        win_parse.document.write(str);
        win_parse.focus();     
    }

    function deleteForm(id){
    	alert(id)
    	if(!confirm("确定要删除？")){
    		return 
    	}
    	$.ajax({
    		   type: "POST",
    		   url: "${ctx}/flowDiagram/deleteForm.do",
    		   data: {"formId":id},
    		   dataType:"json",
    		   success: function(msg){
    			   alert(msg.msg)
    			   if(msg.status==0){
    				   searchfn()
    			   }
    		   }
    		});
    }
    
 	// 转义;  
    var escapeHTML = function (text) {  
        if (typeof text === 'string') {  
            return text  
                .replace(/&/g, '&amp;')  
                .replace(/</g, '&lt;')  
                .replace(/>/g, '&gt;')  
                .replace(/"/g, '&quot;')  
                .replace(/'/g, '&#039;')  
                .replace(/`/g, '&#x60;');  
        }  
        return text;  
    };  

    function del(){
    	
    }
    

   



</script>


</html>


