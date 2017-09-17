<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>回退</title>
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
<div class="panel panel-info" style="height:80%;width: 99%;">
    <div class="panel-heading">
    </div>
    <div class="panel-body" style="height:100%;">
        <form id="changeForm" class="form-horizontal">
            <!-- BEGIN FORM-->
            <label class="col-sm-2 control-label">回退节点:</label>
            <div class="col-sm-8" style="width: 300px;">
                <select class="form-control" name="activityId" id="contranctmarker">
                    <c:forEach items="${activitys}" var="entry">
                        <option value="${entry.key}">${entry.value}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <%--<label class="col-sm-2 control-label">部门id:</label>--%>
                <div class="col-sm-5">
                    <input class="form-control" name="taskId" value="${taskId}" type="hidden" />
                    <input class="form-control" name="processId" value="${processId}" type="hidden" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">备注:</label>
                <div class="col-sm-8" style="width: 400px">
                    <textarea type="text" id="remark" name="remark"  class="form-control" rows="2">${contract.remark}</textarea>
                </div>
            </div>
        </form>
    </div>
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
    //执行回退操作
    function submitbtn() {
        var url="${ctx}/handle/doBackActivitys";
        $.ajax({
            url:url,
            data:$("#changeForm").serialize(),
            dataType:'json',
            type:'post',
            success:function(data){
                alert(data.message);
                if(data.success){
                    mif.closeForm();
                }
            }
        })
    }


</script>
</html>
