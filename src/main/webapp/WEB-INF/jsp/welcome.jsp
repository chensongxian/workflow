<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>流程管理系统</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
</head>
<frameset rows="50,*">
    <frame name="top" src="${ctx}/page/activity" frameborder="0" scrolling="no"/>
    <frame name="main" frameborder="0" scrolling="yes"/>
</frameset>

</html>
