<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/5/6
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String cp = request.getContextPath();
%>
<html>
<head>
    <title>${user.fullname}</title>
</head>
<body>
<c:choose>
    <c:when test="${user == null}">
        <label class="error"> User Not Found! </label>
    </c:when>
    <c:otherwise>
        <form action="<%=cp%>/user/update" method="post">
            <p>
                <label>User Name</label>
                <br/>
                <input type="text" name="username" value="${user.username}">
            </p>

            <p>
                <label>Full Name</label>
                <br/>
                <input type="text" name="fullname" value="${user.fullname}">
            </p>

            <p>
                <label>Old Password</label>
                <br/>
                <input type="password" name="opassword">
            </p>

            <p>
                <label>New Password</label>
                <br/>
                <input type="password" name="npassword">
            </p>

            <p>
                <label>New Password Again</label>
                <br/>
                <input type="password" name="npassword2">
            </p>

            <p>
                <input type="submit" value="Save" class="button">
            </p>
        </form>
    </c:otherwise>
</c:choose>
</body>
</html>
