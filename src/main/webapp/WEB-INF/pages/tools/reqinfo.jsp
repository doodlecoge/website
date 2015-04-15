<%--
  Created by IntelliJ IDEA.
  User: hch
  Date: 2015/4/15
  Time: 21:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%
    String cp = request.getContextPath();
%>
<html>
<head>
    <title>Show Http Request Info</title>
    <style type="text/css">
        table {
            width: 100;
            border-collapse: collapse;
        }
        td {
            vertical-align: middle;
            border: 1px solid #ccc;
            height: 35px;
            padding: 5px;
        }
    </style>
</head>
<body>
<br/>
<table>
    <c:forEach items="${reqinfo}" var="h">
        <tr>
            <td style="width: 1%; background: #eee;">${h.key}</td>
            <td style="width: 1px;">:</td>
            <td>${h.value}</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
