<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>知会</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
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
        form{
            font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;
            font-size: 12px
        }
    </style>
</head>
<body>

<div style="width: 80%;margin: auto">

    <div>
        <div style="margin-top: 3px;margin-bottom: 3px;margin-left: 3px">
            <input type="text" id="userName" placeholder="员工姓名"> <button type="button"class="btn btn-sm bg-info"  onclick="searchUser()">搜索</button>
            <div>
                <table class="table table-striped table-bordered " id="tb_taskLisk">
                </table>
            </div>
        </div>
    </div>
    <form id="changeForm">
        <input type="hidden" name="processId", value="${processId}">
        <input type="hidden" name="taskId", value="${taskId}">
        <input type="hidden" name="informPersonId", id="informPersonId">

    </form>
    <div class="panel-footer">
        <center>
            <button type="button" class="btn btn-sm btn-primary" style="margin-right: 20px" onclick="submitbtn()">
                提交
            </button>
            <a class="btn btn-sm  btn-danger" href="javascript:mif.closeForm();" id="btnDelete"><i class="fa fa-times"></i>取消</a>
        </center>
    </div>
</div>

</body>
<jsp:include page="common/footer.jsp"/>
<script>
    var queryParam ="";
    var $treeId = "";
    var zTree;
    var orgId="";
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

    //执行回退操作
    function submitbtn() {
        var array = $("#tb_taskLisk").bootstrapTable("getSelections");
        if(array.length==0){
            alert("请选择你还要知会的人");
            return;
        }
        console.info(array);
        var s = new Array();
        console.info(s);
        for(var i=0;i<array.length;i++){
            s.push(array[i].adminid);
        }
        console.info(s);
        $("#informPersonId").val(s.join(","));
        var url="${ctx}/informAct/insertProcessRole";
        $.ajax({
            url:url,
            data:$("#changeForm").serialize(),
            dataType:'json',
            success:function(data){
                alert(data.message);
                if(data.success){
                    mif.closeForm();
                }
            }
        })

    }
    /**
     * 查询人员
     */
    function searchUser(){

        $("#tb_taskLisk").bootstrapTable("refresh");
    }


</script>
</html>
