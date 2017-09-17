<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>流程管理系统</title>
</head>
<frameset rows="50,*">
    <frame name="top" src="${ctx}/page/header" frameborder="0" scrolling="no"/>
    <frame name="main" frameborder="0" src="${ctx}/page/indexPage"/>
</frameset>

</html>
