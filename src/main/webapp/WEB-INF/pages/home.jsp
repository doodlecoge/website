<%--
  Created by IntelliJ IDEA.
  User: huaiwang
  Date: 6/25/14
  Time: 9:13 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>Home Page</title>
</head>
<body>
<c:forEach var="user" items="${users}">
  <c:out value="${user.username}"/>,
</c:forEach>
hi, huaichao!
</body>
</html>
