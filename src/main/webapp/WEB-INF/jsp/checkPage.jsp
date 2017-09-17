<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>审批页面</title>
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
        form{
            font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;
            font-size: 12px
        }
    </style>

</head>
<body>
<div class="container">
    <div class="row">
        <div class="row col-lg-8" style="position:absolute;left: 0;right: 576px;">
            <div class="col-lg-12" style="position:relative;">
                <div class="panel panel-info" style="width: 99%; height:98%;">
                    <div class="panel-heading">
                        <span style="font-weight: bold" class="panel-title">审核表单</span>
                    </div>
                    <%--<div class="panel-body" style="height: 600px" id="div_applyInfo">
                        <iframe src="${ctx}/startActivity/inviteForm?processId=${processId}&taskId=${taskId}" style="width: 100%;height: 100%;" id="iframejsp"></iframe>
                    </div>--%>
                    <div class="panel-body">
                        <form id="dataForm">
                            <table  class="table-bordered  text-center "
                                    style="width: 99%;margin:-20px auto; WORD-WRAP: break-word;BORDER-TOP: medium none;BORDER-BOTTOM: medium none;BORDER-LEFT: medium none; border:1px;">
                                <caption>
                                    <h1 style="text-align: center">申请表单</h1>
                                </caption>
                                <tbody>
                                <tr>
                                    <td>姓名：</td>
                                    <td><input type="text" name="name" class="name"
                                               <c:if test="${formDataInfo ne null}">
                                               value="${formDataInfo['name']}"

                                    </c:if>

                                        <c:if test="${!empty formDataInfo['name']}">
                                    </c:if>
                                        ></td>
                                    <td>年龄：</td>
                                    <td><input type="text" name="age" class="age"

                                    <c:if test="${formDataInfo ne null}">
                                               value="${formDataInfo['name']}"

                                    </c:if>

                                    <c:if test="${!empty formDataInfo['age']}">
                                    </c:if>
									
                                    ></td>
                                    </tr>
                                    <tr>
                                    
                                    <td>籍贯：</td>
                                    <td><input type="text" name="address" class="address"

                                    <c:if test="${formDataInfo ne null}">
                                               value="${formDataInfo['address']}"

                                    </c:if>

                                    <c:if test="${!empty formDataInfo['address']}">
                                    </c:if>

                                    ></td>
                                    <td>手机号：</td>
                                    <td><input type="text" name="telephone" class="telephone"

                                    <c:if test="${formDataInfo ne null}">
                                               value="${formDataInfo['telephone']}"

                                    </c:if>

                                    <c:if test="${!empty formDataInfo['telephone']}">
                                    </c:if>

                                    ></td>
                                </tr>

                            </table>
                        </form>

                  

                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="col-lg-4" style="position:absolute;left: 70%;right:0;height: 88%">
        <div class="panel panel-info" style="height:99%;width: 88%;">
            <div class="panel-heading">
                <span style="font-weight: bold" class="panel-title">审批</span>
            </div>
            <div class="panel-body" style="height:70%;">
                <c:if test="${notify}">
                    <button class="btn btn-xs btn-success" onclick="addActivity()" style="margin-top: 0px" id="addActivity">
                        加签
                    </button>
                    <button class="btn btn-xs btn-success" onclick="joinProcess()" style="margin-top: 0px">
                        会签
                    </button>
                </c:if>

                <form id="checkForm" class="form-horizontal">
                    <div class="form-group">
                        <%--<label class="col-sm-2 control-label">部门id:</label>--%>
                        <div class="col-sm-5">
                            <input class="form-control" name="taskId" id="taskId" value="${taskId}" type="hidden"/>
                            <input class="form-control" name="processId" id="processId" value="${processId}" type="hidden"/>
                        </div>
                    </div>
                    <c:forEach items="${checkInfo}" var="form">
                        <c:if test="${form.type eq 'boolean'}">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">${form.name}:</label>
                        <div class="col-sm-8">
                            <div class="checkbox">
                                <label class="checkbox">
                                    <input type="radio" name="${form.id}" value="true">是
                                    <input type="radio" name="${form.id}" value="false">否
                                </label>
                                </div>
                            </div>
                        </div>
                        </c:if>
                    </c:forEach>
                    <!-- BEGIN FORM-->
                    <!--如果不是知会节点的话-->
                    <c:if test="${notify}">
                        <div class="form-group">
                            <label class="col-sm-4 control-label">审核:</label>
                            <div class="col-sm-8">
                                <div class="checkbox">
                                    <label class="checkbox">
                                        <input type="radio" name="noProblem" value="true" checked> 同意
                                        <input type="radio" name="noProblem" value="false"> 不同意
                                    </label>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${notify}">
                        <div class="form-group">

                        </div>
                    </c:if>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">意见:</label>
                        <div class="col-sm-8">
                                <textarea type="text" id="remark" name="remark" class="form-control"
                                          rows="2"></textarea>
                        </div>
                    </div>
                </form>

            </div>
            <div class="panel-footer">
                <center>
                    <c:if test="${notify}">
                        <button type="button" class="btn btn-sm btn-success" style="margin-right: 20px"
                                onclick="doCheck()">
                            通过
                        </button>
                        <button type="button" class="btn  btn-sm btn-primary" style="margin-right: 20px"
                                onclick="noAgree()">
                            不通过
                        </button>
                        <%--                      <button type="button" class="btn  btn-sm btn-danger" style="margin-right: 20px"
                                                      onclick="processSuppend()">
                                                  挂起
                                              </button>--%>
                    </c:if>
                    <c:if test="${notify eq false}">
                        <button type="button" class="btn btn-sm btn-success" style="margin-right: 20px"
                                onclick="inform()">
                            提交
                        </button>
                    </c:if>

                </center>
            </div>
        </div>
    </div>
</div>
</div>
</body>
<jsp:include page="common/footer.jsp"/>

<script>
$.prototype.serializeObject = function() {  
    var a, o, h, i, e;  
    a = this.serializeArray();  
    o = {};  
    h = o.hasOwnProperty;  
    for (i = 0; i < a.length; i++) {  
        e = a[i];  
        if (!h.call(o, e.name)) {  
            o[e.name] = e.value;  
        }  
    }  
    return o;  
};  
    var url = "";
    var reson = "";
    var noProblem = "";

    $(function(){
        var processId = $("#processId").val();
        var taskId = $("#taskId").val();
        $.ajax({
            //先判定是否已经加过签了
            url:"${ctx}/tempActivityChange/isAddActivity?processId="+processId+"&taskId="+taskId,
            dataType:"json",
            async:true,
            success:function(data) {
                //如果成功 则代表可以加签
                if (!data.success) {
                    $("#addActivity").hide();
                }
            }
        })

        $.ajax({
            //先判定是否已经加过签了
            url:"${ctx}/tempActivityChange/isAddActivity?processId="+processId+"&taskId="+taskId,
            dataType:"json",
            success:function(data) {
                //等于false的话则代表有在该节点加的签
                if (!data.success && data.processId != null) {

                }else {
                    $("#cutActivity").hide();
                }
            }
        })
    });
    //确认
    function inform() {
        var noAgreeUrl = "${ctx}/process/doTaskConfirm?taskId=${taskId}";
        $.ajax({
            url: noAgreeUrl,
            type: "POST",
            dataType: "json",
            success: function (data) {
                alert(data.message);
                if (data.success) {
                    window.location.href = "${ctx}/page/taskList";
                }
            }
        })
    }

    //不通过
    function noAgree() {
        var noAgreeUrl = "${ctx}/process/processDelete";
        reson = $("#remark").val();
        if (reson == null || reson == "") {
            alert("不同意，请填写意见");
            return;
        }
        $.ajax({
            url: noAgreeUrl,
            data:$("#checkForm").serialize(),
            type: "POST",
            dataType: "json",
            success: function (data) {
                alert(data.message);
                if (data.success) {
                    window.location.href = "${ctx}/page/taskList";
                }
            }
        })

    }
    //流程挂起
    function processSuppend() {
        var processSuppendUrl = "${ctx}/process/processSuppend";
        $.ajax({
            url: processSuppendUrl,
            data: {'processId': '${processId}'},
            type: "POST",
            dataType: 'json',
            async: false,
            success: function (data) {
                alert(data.message);
                if (data.success) {
                    window.location.href = "${ctx}/page/taskList";
                }
            }
        })
    }
	
    //通过审批
    function doCheck() {
        url = "${ctx}/task/doTask";
        reson = $("#remark").val();
        noProblem = $("input[name='noProblem']:checked").val();
        var check1 =  $("#checkForm").serializeArray();
        var check3 = $("#dataForm").serializeArray();
        var s2 = {};
        for(var i=0;i<check3.length;i++){
            s2[check3[i]['name']] = check3[i]['value'];
        }
        var s = {"fomrData_test":JSON.stringify(s2)};
        for(var i=0;i<check1.length;i++){
            s[check1[i]['name']] = check1[i]['value'];
        }
        $.ajax({
            url: url,
            data:  s ,
            type: "POST",
            dataType: 'json',
            async: false,
            success: function (data) {
                alert(data.message);
                if (data.success) {
                    window.location.href = "${ctx}/page/taskList";
                }
            }
        })
    }


    function joinProcess() {
        var goToJoinUrl="${ctx}/tempActivityChange/goToJoinProcess?processId=${processId}&taskId=${taskId}";
        art.dialog.open(goToJoinUrl, {
            title: "会签",
            id: 'detail',
            width: 1000,
            height: 500,
            lock: true,
            opacity: 0.3,
            close: function () { //关闭弹出层事件
                <%
                 request.getSession().removeAttribute("adminIds");
                %>
                $.ajax({
                    url:"${ctx}/tempActivityChange/changeAfterTask?processId=${processId}",
                    dataType:"json",
                    success:function(data){
                        $("#processId").val(data.processId);
                        $("#taskId").val(data.taskId);
                        console.info("获取重新的流程任务节点");

                    }
                })
            }
        });
    }

    function informProcess() {
        url = "${ctx}/informAct/gotoInformPage?processId=${processId}&taskId=${taskId}";
        art.dialog.open(url, {
            title: "知会",
            id: 'detail',
            width: 1000,
            height: 600,
            lock: true,
            opacity: 0.3,
        });
    }

    //加签功能
    function addActivity() {
        var processId = $("#processId").val();
        var taskId = $("#taskId").val();
        $.ajax({
            //先判定是否已经加过签了
            url:"${ctx}/tempActivityChange/isAddActivity?processId="+processId+"&taskId="+taskId,
            dataType:"json",
            success:function(data){
                //如果成功 则代表可以加签
                if(data.success){
                    url = "${ctx}/tempActivityChange/gotoAddActivityPage?processId="+processId+"&taskId="+taskId,
                            art.dialog.open(url, {
                                title: "加签",
                                id: 'detail',
                                width: 1000,
                                height: 500,
                                lock: true,
                                opacity: 0.3,
                                close: function () { //关闭弹出层事件
                                    <%
                                    request.getSession().removeAttribute("roles");
                                     %>
                                    //加签成功
                                    $.ajax({
                                        url:"${ctx}/tempActivityChange/changeAfterTask?processId=${processId}",
                                        dataType:"json",
                                        success:function(data){
                                            $("#processId").val(data.processId);
                                            $("#taskId").val(data.taskId);

                                            $("#cutActivity").show();

                                        }
                                    })

                                }
                            })
                }else {
                    //否则已经加过签了
                    alert("你已经加过签了")
                    $("#addActivity").attr("disabled","disabled");
                }
            }
        });
    }

    //回退
    function back() {
        //回退
        url = "${ctx}/handle/goToBackPage?processId=${processId}&taskId=${taskId}",
                art.dialog.open(url, {
                    title: "回退",
                    id: 'detail',
                    width: 800,
                    height: 300,
                    lock: true,
                    opacity: 0.3,
                    close: function () { //关闭弹出层事件
                        window.location.href = "${ctx}/page/taskList";
                    }

                });

    }


    function cutActivity() {
        var processId = $("#processId").val();

        var taskId = $("#taskId").val();

        $.ajax({
            //先判定是否已经加过签了
            url:"${ctx}/tempActivityChange/isAddActivity?processId="+processId+"&taskId="+taskId,
            dataType:"json",
            success:function(data){
                //等于false的话则代表有在该节点加的签
                if(!data.success && data.processId !=null){
                    url = "${ctx}/tempActivityChange/gotoCutActivityPage?processId="+processId+"&taskId="+taskId+"&id="+data.processId,
                            art.dialog.open(url, {
                                title: "减签",
                                id: 'detail',
                                width: 1000,
                                height: 500,
                                lock: true,
                                opacity: 0.3,
                                close: function () { //关闭弹出层事件
                                    $.ajax({
                                        url:"${ctx}/tempActivityChange/changeAfterTask?processId=${processId}",
                                        dataType:"json",
                                        success:function(data){
                                            $("#processId").val(data.processId);
                                            $("#taskId").val(data.taskId);
                                            $("#cutActivity").show();
                                        }
                                    })

                                    //window.location.href = "${ctx}/page/taskList";

                                }
                            })
                }else {
                    //否则已经加过签了
                    alert("您尚未加签，不能减签");
                    $("#cutActivity").attr("disabled","disabled");
                }
            }
        });
    }



    /**
     * 流程作废
     */
    function deleteProcess() {
        mif.showQueryMessageBox("你确认要删除该流程吗？", deleteRecord);
    }
    function deleteRecord() {
        $.ajax({
            url: "${ctx}/process/processDelete?processId=${processId}&taskId=${taskId}" ,
            dataType: "json",
            success: function (data) {
                alert(data.message);
                if (data.success) {
                    window.location.href = "${ctx}/page/taskList"
                }
            }
        })
    }
    //转办

    function agree() {
        $("#back").hide();
    }
    
</script>
</html>
