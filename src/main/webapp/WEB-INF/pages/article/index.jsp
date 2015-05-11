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
</head>
<body>
<br/>
<c:if test="${fn:length(articles) > 0}">
    <ul class="articles">
        <c:forEach items="${articles}" var="article">
            <li>
                <div class="img">
                    <c:if test="${article.image != null}">
                        <img src="<%=cp%>/image/${article.image.id}">
                    </c:if>
                    <c:if test="${article.image == null}">
                        <img src="<%=cp%>/img/no-img.png">
                    </c:if>
                </div>
                <div class="right">
                    <h2>
                        <a href="<%=cp%>/article/${article.id}">${article.title}</a>
                    </h2>

                    <c:if test="${fn:length(article.tags) > 0}">
                        <p style="margin-bottom: 0">
                            <c:forEach items="${article.tags}" var="tag">
                                <a class="tag"
                                   href="<%=cp%>/article/${tag.id}/tag">${tag.name}</a>
                            </c:forEach>
                        </p>
                    </c:if>
                    <p style="margin: 0 0 5px 0;">
                        <i>${article.user.fullname}</i>
                    </p>

                    <p style="margin: 0 0 5px 0;">
                        <fmt:formatDate value="${article.createdAt}"
                                        pattern="yyyy-MM-dd"/>
                        ~
                        <fmt:formatDate value="${article.updatedAt}"
                                        pattern="yyyy-MM-dd"/>
                    </p>
                    <c:if test="${username == article.user.username}">
                        <p style="margin: 0 0 5px 0;">
                            <a href="<%=cp%>/article/${article.id}/del"
                               class="del"
                               onclick="return confirm('delete this article?')">
                                DELETE</a>
                            <a href="<%=cp%>/article/${article.id}/edit"
                               class="edit">
                                EDIT</a>
                        </p>
                    </c:if>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>

<c:if test="${fn:length(articles) == 0}">
    <div class="alert warn">
        <i class="fa fa-exclamation-triangle icon"></i>
        <span class="txt">No articles!</span>
    </div>
</c:if>
</body>
</html>
