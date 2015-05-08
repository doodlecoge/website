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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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

        li.group {
            display: table;
            width: 100%;
            height: 40px;
            line-height: 40px;
        }

        li.group > * {
            display: table-cell;
        }

        li.group .txt {
            padding-left: 10px;
        }

        li.group a.btn {
            width: 1%;
            padding: 0 10px;
        }
    </style>
</head>
<body>
<br/>

<sec:authorize access="isAuthenticated()">
    <a href="<%=cp%>/widget/new" class="add_link">
        <i class="fa fa-plus-circle"></i>
        Add a widget
    </a>
    <hr/>
</sec:authorize>
<c:if test="${widgets != null || fn:length(widgets) > 0}">
    <ul class="list">
        <c:forEach var="widget" items="${widgets}">
            <li class="group">
                <a class="txt"
                   href="<%=cp%>/widget/${widget.id}">${widget.title}</a>
                <c:if test="${username == widget.user.username}">
                    <a class="btn" href="<%=cp%>/widget/${widget.id}/del">
                        <i class="fa fa-times"></i>
                    </a>
                </c:if>
            </li>
        </c:forEach>
    </ul>
</c:if>
</body>
</html>
