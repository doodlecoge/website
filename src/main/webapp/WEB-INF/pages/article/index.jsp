<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/1/17
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Articles</title>
</head>
<body>
<c:forEach items="${articles}" var="article">
    <c:out value="${article.title}"/>,
</c:forEach>
</body>
</html>
