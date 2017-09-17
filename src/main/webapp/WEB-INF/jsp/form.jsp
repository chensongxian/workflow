<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/12/5
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <jsp:include page="common/header.jsp"/>
    <style>
        body table {
            font-family: "Microsoft YaHei", SimSun, Arial, Helvetica, sans-serif;
            font-size: 12px
        }

        form {
            font-family: "Microsoft YaHei", SimSun, Arial, Helvetica, sans-serif;
            font-size: 12px
        }
    </style>
</head>
<body style="height:120%;">
<div class="panel-info" style="width: 800px; margin: auto">

    <div class="panel-heading" style="text-align: right">
       <%-- 用于重新发起--%>
        <c:if test="${show ne 1}">
        <button type="button" class="btn btn-sm btn-success" style="margin-right: 20px"
                onclick="showPicWindow()">
            流程图
        </button>
        <button type="button" class="btn btn-sm btn-warning" style="margin-right: 20px"
                onclick="doCheck()">
            重新发起
        </button>
        </c:if>
    </div>


    <div class="panel-body" >
        <form id="dataForm">
            <table  class="table-bordered  text-center "
                    style="width: 99%;margin:-20px auto; WORD-WRAP: break-word;BORDER-TOP: medium none;BORDER-BOTTOM: medium none;BORDER-LEFT: medium none; border:1px;">
                <caption>
                    <h1 style="text-align: center">申请表单</h1>
                </caption>
                <tbody>
                <tr>
                    <td>姓名：</td>
                    <td><input type="text" name="name" class="name" value="${dataInfo['name']}"
                        <c:if test="${show eq 1}"> readonly </c:if>
                    ></td>
                    <td>年龄：</td>
                    <td><input type="text" name="age" class="age" value="${dataInfo['age']}"
                    <c:if test="${show eq 1}"> readonly</c:if>
                    >

                    </td>
                </tr>
                <tr>
                    <td>籍贯：</td>
                    <td><input type="text" name="address" value="${dataInfo['address']}"
                    <c:if test="${show eq 1}">
                               readonly
                    </c:if>
                    ></td>
                    <td>手机号：</td>
                    <td><input type="text" name="telephone" value="${dataInfo['telephone']}"
                    <c:if test="${show eq 1}">
                               readonly
                    </c:if>

                    ></td>
                </tr>
                <c:if test="${historyAdviceList!= null}">
                <c:forEach items="${historyAdviceList}" var="historyTask">
                <c:if test="${historyTask.checkResult eq true}">
                <tr style="height: 80px">
                    <td>${historyTask.taskName}意见</td>
                    <td colspan='3'>
                        <span style="color: #0e90d2">[同意]</span>
                        <span style="margin-left: 3px">${historyTask.remark}</span>
                    </td>
                    <td colspan='2'>
                        <span>签字：${historyTask.checkUser} </span>
                        <br>
                        <span>日期：<fmt:formatDate value="${historyTask.checkDate}" pattern="yyyy-MM-dd HH:mm"/> </span>
                    </td>
                </tr>
                </c:if>
                <c:if test="${historyTask.checkResult eq false}">
                <tr style="height: 80px">
                    <td>${historyTask.taskName}意见</td>
                    <td colspan='3'>
                        <span style="color: #0e90d2">[不同意]</span>
                        <span style="margin-left: 3px">${historyTask.remark}</span>
                    </td>
                    <td colspan='2'>
                        <span>签字：${historyTask.checkUser} </span>
                        <br>
                                    <span>日期：
                                    <fmt:formatDate value="${historyTask.checkDate}" pattern="yyyy-MM-dd HH:mm"/>
                                     </span>
                    </td>
                </tr>
                </c:if>

                </c:forEach>
                </c:if>
            </table>
        </form>

    </div>

    <hr>
    <h3>操作</h3>
    <table class="table table-bordered">
        <c:if test="${historyList!= null}">
            <tr>
                <th>任务名称</th>
                <th>审批人</th>
                <th>操作</th>
                <th>时间</th>
                <th>审核</th>
                <th>意见</th>
            </tr>
            <c:forEach items="${historyList}" var="historyTask">
                <c:if test="${historyTask.checkUser !=null}">
                    <tr>
                        <td>${historyTask.taskName}</td>
                        <td>${historyTask.checkUser}</td>
                        <td>${historyTask.doWhat}</td>
                        <td>
                            <fmt:formatDate value="${historyTask.doTime}" pattern="yyyy-MM-dd HH:mm"/> </span>
                        </td>
                        <td>${historyTask.checkResult}</td>
                        <td>${historyTask.remark}</td>
                    </tr>
                </c:if>
            </c:forEach>
        </c:if>
    </table>

</div>

</body>
<jsp:include page="common/footer.jsp"/>
<script src="${ctx}/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script src="${ctx}/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script language='javascript' type="text/javascript">
  $(function () {
      //将数据填充到表单中
  })
  //重新发起表单
  function doCheck() {
      var data2 = $("#dataForm").serializeArray();
      //data = JSON.stringify(data);
      data2 = JSON.stringify(data2);
      var taskId = '${taskId}';
      var form = {"formData":data2,"taskId":taskId};
      if(confirm("你确定要重新发起流程吗?")){
          //发流程
          $.ajax({
              url:"${ctx}/waitApplyProcess/reSubmitAgain",
              dataType:"json",
              type:"post",
              data:form,
              success:function (data) {
                  console.info(data);
                  if(data.success){
                      alert(data.message);
                      window.location.href="${ctx}/page/waitApplyProcess";
                  }
              }
          })
      }
  }
  function showPicWindow() {
      url = "${ctx}/activitiPic/lookPic?processId=${processId}",
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
