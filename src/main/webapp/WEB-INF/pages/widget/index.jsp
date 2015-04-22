<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/4/22
  Time: 13:03
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
    <title>Wdigets</title>
    <link rel=stylesheet href="<%=cp%>/css/font-awesome.min.css">
    <style type="text/css">
        .add_link {
            font-size: 18px;
            font-weight: bold;
            color: #555;
            text-decoration: none;
        }
    </style>
</head>
<body>
<br/>
<a href="<%=cp%>/widget/new" class="add_link">
    <i class="fa fa-plus-circle"></i>
    Add a widget
</a>
<hr/>
<c:if test="${widgets != null || fn:length(widgets) > 0}">
    <ul>
        <c:forEach var="widget" items="${widgets}">
            <li>
                <a href="<%=cp%>/widget/${widget.id}">${widget.title}</a>
            </li>
        </c:forEach>
    </ul>
</c:if>
</body>
</html>
