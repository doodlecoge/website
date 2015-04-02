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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String cp = request.getContextPath();
%>
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
            text-decoration: none;
            display: block;
            margin-bottom: 5px;
        }
        .articles li .title:hover{
            text-decoration: underline;
            color: #f66;
        }
    </style>
</head>
<body>
<ul class="articles">
    <c:forEach items="${articles}" var="article">
        <li>
            <a href="<%=cp%>/article/${article.id}"
               class="title">
                    ${article.title}
            </a>
            <c:if test="${fn:length(article.tags) > 0}">
                <div>
                    <c:forEach items="${article.tags}" var="tag">
                        <a class="tag"
                           href="<%=cp%>/article/${tag.id}/tag">${tag.name}</a>
                    </c:forEach>
                </div>
            </c:if>
            <div style="margin-top: 6px; color: #888;">
                by ${article.username},
                created
                <fmt:formatDate value="${article.createdAt}"
                                pattern="yyyy-MM-dd"/>
                updated
                <fmt:formatDate value="${article.updatedAt}"
                                pattern="yyyy-MM-dd"/>
            </div>
            <c:if test="${username == article.username}">
                <a href="<%=cp%>/article/${article.id}/del">Delete</a>
                <a href="<%=cp%>/article/${article.id}/edit">Edit</a>
            </c:if>
        </li>
    </c:forEach>
</ul>
</body>
</html>
