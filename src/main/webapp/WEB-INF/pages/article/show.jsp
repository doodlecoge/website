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
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/marked.js"></script>
    <style type="text/css">
        .tags {
            padding: 10px 0;
        }

        .tags span {
            padding: 5px 10px;
            background: #eee;
            margin-right: 10px;
        }
        #note_wrapper {
            margin-top: 10px;
            background: #ddd;
            position: relative;
            border-top: 1px dashed #69c;
            vertical-align: top;
        }
        #note {
            margin-right: 310px;
            padding-right: 10px;
            height: 100%;
            background: #f8f8f8;
            vertical-align: top;
        }
        #outline {
            float: right;
            width: 300px;
            padding: 5px 0;
            min-height: 100px;
        }
        #outline ul {
            padding: 0;
            margin: 0;
            padding-left: 30px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var txt = $('#raw').val();
            var data = marked.withOutline(txt);
            $("#note").html(data.html);
            $("#outline").html(data.outline);
        });
    </script>
</head>
<body>
<textarea id="raw" style="display: none;">${article.content}</textarea>

<h1 style="margin-bottom: 10px;">${article.title}</h1>

<div style="color: #888; margin-bottom: 10px">
    by ${article.user.username}
    created at
    <fmt:formatDate value="${article.createdAt}"
                    pattern="yyyy-MM-dd"/>,
    updated at
    <fmt:formatDate value="${article.updatedAt}"
                    pattern="yyyy-MM-dd"/>
</div>
<c:if test="${fn:length(article.tags) > 0}">
    <ul class="tags">
        <c:forEach items="${article.tags}" var="tag">
            <li>
                <a href="<%=cp%>/article/${tag.id}/tag" class="tag">${tag.name}</a>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${username == article.user.username}">
    <a href="<%=cp%>/article/${article.id}/del">Delete</a>
    <a href="<%=cp%>/article/${article.id}/edit">Edit</a>
</c:if>
<div id="note_wrapper">
    <div id="outline"></div>
    <div id="note"></div>
</div>
</body>
</html>
