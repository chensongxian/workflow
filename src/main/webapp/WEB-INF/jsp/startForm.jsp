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
        <button type="button" class="btn btn-sm btn-success" style="margin-right: 20px"
                onclick="showPicWindow()">
            流程图
        </button>
        <button type="button" class="btn btn-sm btn-warning" style="margin-right: 20px"
                onclick="doCheck()">
            发起
        </button>
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
                    <td><input type="text" name="name" class="name"></td>
                    <td>年龄：</td>
                    <td><input type="text" name="age" class="age" ></td>
                </tr>
                <tr>
                    <td>籍贯：</td>
                    <td><input type="text" name="address"></td>
                    <td>手机号：</td>
                    <td><input type="text" name="telephone"></td>
                </tr>

            </table>
        </form>
    </div>

</div>




</body>
<jsp:include page="common/footer.jsp"/>
<script src="${ctx}/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script src="${ctx}/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script language='javascript' type="text/javascript">
    var key = "${processKey}";
  $(function () {

      //将数据填充到表单中

  })

    function doCheck() {
        var data2 = $("#dataForm").serializeArray();
        //data = JSON.stringify(data);
        data2 = JSON.stringify(data2);
        console.info(data2);
        var form = {"formData":data2,"key":key};
        console.info(form);
        if(confirm("你确定要发起流程吗?")){
            //发流程
            $.ajax({
                url:"${ctx}/startActivity/startProcess",
                dataType:"json",
                type:"post",
                data:form,
                success:function (data) {
                    console.info(data);
                    if(data.success){
                        alert(data.message);
                        window.location.href="${ctx}/page/startActivity";
                    }
                }
            })
        }
    }
    //查看流程图
  function showPicWindow() {
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


</script>


</html>
