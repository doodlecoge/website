<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/1/17
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Articles</title>
    <style type="text/css">
        .articles {
            margin: 0;
            padding: 0;
        }

        .articles li {
            padding-bottom: 20px;
            list-style: none;
        }

        .articles li .title {
            font-size: 1.6em;
        }
    </style>
</head>
<body>
<ul class="articles">
    <c:forEach items="${articles}" var="article">
        <li>
            <a href="<%=request.getContextPath()%>/article/${article.id}"
               class="title">
                    ${article.title}
            </a>

            <div>
                created at
                <fmt:formatDate value="${article.createdAt}"
                                pattern="yyyy-MM-dd"/>
                updated at
                <fmt:formatDate value="${article.updatedAt}"
                                pattern="yyyy-MM-dd"/>
            </div>
            <div>
                by ${article.username},${username}
            </div>
            <c:if test="${username == article.username}">
                <a href="<%=request.getContextPath()%>/article/${article.id}/del">Delete</a>
                <a href="<%=request.getContextPath()%>/article/${article.id}/edit">Edit</a>
            </c:if>
        </li>
    </c:forEach>
</ul>
</body>
</html>
