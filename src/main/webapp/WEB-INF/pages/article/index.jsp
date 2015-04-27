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
        @media screen and (max-device-width: 600px) {
            #content.c {
                padding: 0;
            }
        }
    </style>
</head>
<body>
<br/>
<c:if test="${fn:length(articles) > 0}">
    <ul class="articles">
        <c:forEach items="${articles}" var="article">
            <li class="line">
                <div class="img">
                    <%--<div style="width: 60px; height: 60px; background: #ccc; overflow: hidden;">--%>
                        <span class="helper"></span>
                        <c:if test="${article.image != null}">
                            <img src="<%=cp%>/image/${article.image.id}"
                                 style="max-width: 60px; max-height: 60px;">
                        </c:if>
                        <c:if test="${article.image == null}">
                            <img src="<%=cp%>/img/no-img.png"
                                 style="max-width: 60px; max-height: 60px;">
                        </c:if>
                    <%--</div>--%>
                </div>
                <div class="right">
                    <h2>
                        <a href="<%=cp%>/article/${article.id}">${article.title}</a>
                    </h2>

                    <c:if test="${fn:length(article.tags) > 0}">
                        <div>
                            <c:forEach items="${article.tags}" var="tag">
                                <a class="tag"
                                   href="<%=cp%>/article/${tag.id}/tag">${tag.name}</a>
                            </c:forEach>
                        </div>
                    </c:if>
                    <div style="margin-bottom:10px; color: #888;">
                        by ${article.user.fullname},
                        created at
                        <fmt:formatDate value="${article.createdAt}"
                                        pattern="yyyy-MM-dd"/>,
                        updated at
                        <fmt:formatDate value="${article.updatedAt}"
                                        pattern="yyyy-MM-dd"/>
                    </div>
                    <c:if test="${username == article.user.username}">
                        <div>
                            <a href="<%=cp%>/article/${article.id}/del"
                               class="del"
                               onclick="return confirm('delete this article?')">
                                Delete</a>
                            &nbsp;
                            <a href="<%=cp%>/article/${article.id}/edit"
                               class="edit">
                                Edit</a>
                        </div>
                    </c:if>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>

<c:if test="${fn:length(articles) == 0}">
    <p>
        <i class="fa fa-exclamation-triangle"
           style="font-size: 24px; color: #f33;"></i>
        No Articles!
    </p>
</c:if>
</body>
</html>
