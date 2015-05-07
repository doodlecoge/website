<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/5/6
  Time: 14:24
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
    <title>User Management</title>
    <style type="text/css">
        li.group {
            display: table;
            width: 100%;
            height: 40px;
            line-height: 40px;
        }

        li.group > * {
            display: table-cell;
        }

        li.group span.txt {
            padding-left: 10px;
        }

        li.group a.btn {
            width: 1%;
            padding: 0 10px;
        }
    </style>
</head>
<body>
<c:choose>
    <c:when test="${users == null || fn:length(users) == 0}">
        No User
    </c:when>
    <c:otherwise>
        <ul>
            <c:forEach var="user" items="${users}">
                <li class="group">
                    <span class="txt">${user.fullname}</span>
                    <a class="btn" href="<%=cp%>/user/${user.username}/del">
                        <i class="fa fa-times"></i>
                    </a>
                    <a class="btn" href="<%=cp%>/user/${user.username}/edit">
                        <i class="fa fa-edit"></i>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </c:otherwise>
</c:choose>
</body>
</html>
