<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/31
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!-- Bootstrap -->
    <jsp:include page="common/header.jsp"/>
</head>
<style type="text/css">
</style>

</head>
<body>
    <iframe src="${pageContext.request.contextPath}/activitiPic/lookMakePic?processId=${processId}&method=1" style="width: 100%;height: auto"></iframe>

    <iframe src="${pageContext.request.contextPath}/activitiPic/lookMakePic?processId=${processId}&method=0"  style="width:100% ;height: auto" ></iframe>


</body>
<jsp:include page="common/footer.jsp"/>



</html>
