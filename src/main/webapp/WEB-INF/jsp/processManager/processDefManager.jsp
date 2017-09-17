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
<%--    <jsp:include page="../common/header.jsp"/>--%>
    <link href="${ctx}/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="${ctx}/css/bootstrap-table.min.css" rel="stylesheet"/>
    <link href="${ctx}/plugs/zTree/metor.css" rel="stylesheet"/>
    <link href="${ctx}/css/bootstrap-select.css" rel="stylesheet">
    <link href="${ctx}/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>


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
            <td><span style="font-weight: bold;font-size: 12px">流程模型名称:</span>
                <input type="text" name="modelName" id="modelName">
            </td>
            <button type="button" class="btn btn-sm btn-success" onclick="searchfn()">搜索</button>
            <button type="button" onclick="clearForm()" class="btn btn-sm btn-default">清空</button>
        </tr>
    </form>
</div>

<div class="container" style="width: 99%;margin: 10px auto">
    <tr>
        <td>
            <button class="btn-success" data-toggle="modal" data-target="#adminSelect">新增</button>
        </td>
        <td>
            <button class="btn-danger"  onclick="copyModel()">复制模板</button>
        </td>

    </tr>
    <div class="panel-body">
        <table class="table table-striped table-bordered " id="tb_taskLisk">
        </table>
    </div>

    <div class="modal" id="adminSelect">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                            class="sr-only">Close</span></button>
                    <h4 class="modal-title">模型创建</h4>
                </div>
                <div class="modal-body">
                    <form id="addForm" method="post" action="${ctx}/flowDiagram/create" class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">模型名称:<i style="color: red;">*</i></label>
                            <div class="col-sm-8" style="width:450px;">
                                <input type="text"  name="name" id="name" class="form-control"  style="width: 400px;" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">模型描述:</label>
                            <div class="col-sm-8" style="width:450px;">
                                <input type="text"  name="description" class="form-control"  style="width: 400px;" />
                            </div>
                        </div>
                        <input  hidden name="key" id="key"/>
                        <input hidden name="systemId" id="systemId1">

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="submitAdd()">提交</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="systemShow">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">请选择对应的系统</h4>
                </div>
                <div class="modal-body">
                    <form  class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">系统选择:<i style="color: red;">*</i></label>
                            <div class="col-sm-8" style="width:450px;">
                                <select type="text" id="systemId" name="systemId"  class="form-control">
                                    <option value="null">请选择系统</option>
                                    <option value="1">ehr</option>
                                    <option value="2">erp</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="chose()">提交</button>
                </div>
            </div>
        </div>
    </div>







</div>
<%--<jsp:include page="common/footer.jsp" />--%>
<script src="${ctx}/js/jquery.min.js"></script>
<script src="${ctx}/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<script src="${ctx}/js/bootstrap-table.js"></script>
<script src="${ctx}/js/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript" src="${ctx}/plugs/artDialog/mifcommon.js"></script>
<script type="text/javascript" src="${ctx}/plugs/artDialog/jquery.artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${ctx}/plugs/artDialog/iframeTools.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.PrintArea.js"></script>
<script type="text/javascript" src="${ctx}/plugs/zTree/jquery.ztree.all.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bootstrap-select.js"></script>
<script type="text/javascript" src="${ctx}/js/bootstrap-typeahead.js"></script>
<script type="text/javascript" src="${ctx}/js/bootstrap-datepicker.js"></script>
<script src="${ctx}/js/commonjs.js"></script>
<script src="${ctx}/js/date.js"></script>

</body>

<script>

    var queryParam = "";
    var processId = "";
    var taskId = "";
    var systemId;
    $(function () {
        $("#systemShow").modal({
            backdrop:'static',
            keyboard:false,
            show:true,
        })
        if(systemId==null||systemId==''||systemId==undefined){
            return;
        }

    });

    function initTable() {
        $("#tb_taskLisk").bootstrapTable({
            url: '${ctx}/processModel/queryPage',
            striped: true,
            method: 'post',
            dataType: 'json',
            pagination: true,
            contentType: "application/x-www-form-urlencoded",
            width: 80,
            pageList: [3, 5, 10, 15, 20],
            pageSize: 15,
            pageNumber: 1,
            queryParamsType: "",//这里只是选择适合我后台的逻辑，可以选择传入页数和显示数量
            queryParams: queryParams,

            sidePagination: 'server',//设置为服务器端分页
            columns: [
                {
                    field: 'chick',
                    checkbox: true
                },
                {
                    title: '模型名称',
                    field: 'modelName',
                    align: 'center'
                },/*,
                 {
                 title: '模型版本',
                 field: 'version',
                 align: 'center',
                 formatter: function (data, row, index) {
                 if(data ==null || data == ""){
                 return "";
                 }else {
                 return data;
                 }
                 }
                 },*/
                {
                    title: '创建时间',
                    field: 'createTime',
                    align: 'center',
                    formatter: function (data, row, index) {
                        return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                    }
                },
                {
                    title: '更新时间',
                    field: 'updateTime',
                    align: 'center',
                    formatter: function (data, row, index) {
                        if (data == null || data == "") {
                            return "";
                        }
                        return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                    }
                },
                {
                    title: '流程名称',
                    field: 'processName',
                    align: 'center',
                    formatter: function (data, row, index) {
                        if(row.deployId ==null || row.deployId == ''){
                            return "<font color='#5f9ea0'>未发布</font>";
                        }
                        return  data;
                    }
                },
                {
                    title: 'key',
                    field: 'processDefKey',
                    align: 'center'
                },
                {
                    title: '流程发布时间',
                    field: 'deployTime',
                    align: 'center',
                    formatter: function (data, row, index) {
                        if(row.deployId ==null || row.deployId == ''){
                            return "<font color='#5f9ea0'>未发布</font>";
                        }else {
                            return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                        }
                    }
                },/*,
                 {
                 title: '流程版本',
                 field: 'processDefVersion',
                 align: 'center',
                 formatter: function (data, row, index) {
                 if(row.deployId ==null || row.deployId == ''){
                 return "<font color='#5f9ea0'>未发布</font>";
                 }else {
                 return data;
                 }
                 }
                 },*/
                {
                    title: '流程模型发布',
                    field: 'modelId',
                    align: 'center',
                    formatter: function (value, row, index) {
                        console.info(row.processDefVersion);
                        if(row.version ==null){
                            return "";
                        }
                        if(row.deployId ==null || row.deployId == ''){
                            return '<button class="btn btn-xs btn-success"  onclick="apply(\''+value+'\')">发布</button>';
                        }else{
                            //流程发布时间小于更新时间
                            if(row.deployTime<row.updateTime){
                                return '<button class="btn btn-xs btn-warning"  onclick="apply(\''+value+'\')">更新发布</button>';
                            }else {
                                return "已发布";
                            }
                        }
                    }
                },
                {
                    title: '操作',
                    field: 'modelId',
                    align: 'center',
                    formatter: function (value, row, index) {
                        return '<button class="btn btn-xs btn-danger"  onclick="editModel(\''+value+'\')">编辑</button>';
                    }
                }

            ]
        });
        //前端提交的数据
        function queryParams(params) {
            return {
                pageSize: params.pageSize,//键就是自己后台的参数
                page: params.pageNumber,
                modelName: $("#modelName").val(),
                systemId:systemId,
            };
        }
    }
    function chose(){
        systemId = $("#systemId").val();
        if(systemId=='null'||systemId==undefined||systemId==''){
            alert("请选择对应的系统");
            return;
        }
        $("#systemShow").modal('hide');
        initTable();
    }
    function editModel(modelId) {
        window.location.href= '${ctx}/modeler.html?modelId='+modelId;
    }
    //copy模板
    function copyModel() {
        var rows = $("#tb_taskLisk").bootstrapTable("getSelections");
        //如果大于1
        if(rows.length==0){
            alert("请选择你需要复制的模板");
            return;
        }
        if(rows.length>1){
            alert("请选择单个模板进行复制");
            return;
        }
        //alert(rows[0].modelId);
        var modelId = rows[0].modelId;
        $.ajax({
            url:"${ctx}/processModel/copyModel?id="+modelId,
            type:"post",
            dataType:"json",
            success:function (data) {
                if(data.success){
                    alert(data.message);
                    $("#tb_taskLisk").bootstrapTable("refresh")
                }else {
                    alert(data.message);
                }
            }

        })
  /*      $.ajax({
            url:""
        })*/
    }



    function apply(modelId) {

        if(confirm("你确认要发布该流程模型吗？")){
       $.ajax({
           url:'${ctx}/processModelManager/processModelStart?modelId='+modelId,
           dataType:"json",
           success:function (data) {
               alert(data.message);
               if(data.success){
                   $("#tb_taskLisk").bootstrapTable("refresh");
               }
           }
       })
        }
    }


    function searchfn() {
        $("#tb_taskLisk").bootstrapTable('refresh');

    }
    function clearForm() {
        $("#modelName").val("");
        $("#tb_taskLisk").bootstrapTable('refresh');
    }
    //提交进入流程编辑器
    function submitAdd() {
        if(systemId==null || systemId=="" || systemId == undefined){
            $("#systemId").val(1);
        }
        if($("#name").val()==''){
            alert("流程模型名称必须填写")
            return;
        }
        $("#systemId1").val(systemId);
        //生成唯一的key
        $.ajax({
            url:"${ctx}/openapi/process/produceUUID",
            dataType:"json",
            success:function(data){
                if(data.success){
                    $("#key").val(data.message);
                    $("#addForm").submit();
                }
            }

        })

    }







    function showPicWindow(processId) {
        url = "${ctx}/activitiPic/lookPic?processId=" + processId,
                art.dialog.open(url, {
                    title: "流程图",
                    id: 'detail',
                    width: 1300,
                    height: 500,
                    lock: true,
                    opacity: 0.3
                });
    }








</script>


</html>


