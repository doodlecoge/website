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
        ul.articles {
            margin: 0;
            padding: 0;
        }

        ul.articles li.line {
            padding-bottom: 20px;
            list-style: none;
            position: relative;
        }

        ul.articles li.line div.img {
            position: absolute;
            top: 0;
            left: 0;
            width: 60px;
            height: 60px;
            padding: 5px;
            border: 1px solid #ccc;
            text-align: center;
            font-size: 0;
        }

        ul.articles span.helper {
            vertical-align: middle;
            display: inline-block;
            height: 100%;
        }

        ul.articles img {
            vertical-align: middle;
        }

        ul.articles li.line div.right {
            margin-left: 80px;
        }

        ul.articles li.line .title {
            font-size: 1.6em;
            text-decoration: none;
            display: block;
            margin-bottom: 10px;
        }

        ul.articles li.line .title:hover {
            text-decoration: underline;
            color: #f55;
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
                    <div style="width: 60px; height: 60px; background: #ccc; overflow: hidden;">
                        <span class="helper"></span>
                        <c:if test="${article.image != null}">
                            <img src="<%=cp%>/image/${article.image.id}"
                                 style="max-width: 60px; max-height: 60px;">
                        </c:if>
                        <c:if test="${article.image == null}">
                            <img src="<%=cp%>/img/no-img.png"
                                 style="max-width: 60px; max-height: 60px;">
                        </c:if>
                    </div>
                </div>
                <div class="right">
                    <a href="<%=cp%>/article/${article.id}"
                       class="title">
                            ${article.title}
                    </a>
                    <c:if test="${fn:length(article.tags) > 0}">
                        <ul class="tags">
                            <c:forEach items="${article.tags}" var="tag">
                                <li>
                                    <a href="<%=cp%>/article/${tag.id}/tag">${tag.name}</a>
                                </li>
                            </c:forEach>
                        </ul>
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
