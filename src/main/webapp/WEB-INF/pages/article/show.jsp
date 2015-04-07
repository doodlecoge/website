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

        #note {
            border-top: 1px dashed #69c;
        }
    </style>
    <script type="text/javascript">
        marked.setOptions({
            renderer: new marked.Renderer(),
            gfm: true,
            tables: true,
            breaks: false,
            pedantic: false,
            sanitize: true,
            smartLists: true,
            smartypants: false
        });
        $(function () {
            var txt = $('#raw').val();
            var html = marked(txt);
            $("#note").html(html);
        });
    </script>
</head>
<body>
<textarea id="raw" style="display: none;">${article.content}</textarea>

<h1>${article.title}</h1>

<div style="margin-top: 6px; color: #888;">
    by ${article.user.username}
    created at
    <fmt:formatDate value="${article.createdAt}"
                    pattern="yyyy-MM-dd"/>,
    updated at
    <fmt:formatDate value="${article.updatedAt}"
                    pattern="yyyy-MM-dd"/>
</div>
<c:if test="${fn:length(article.tags) > 0}">
    <div class="tags">
        <c:forEach items="${article.tags}" var="tag">
            <a href="<%=cp%>/article/${tag.id}/tag" class="tag">${tag.name}</a>
        </c:forEach>
    </div>
</c:if>
<c:if test="${username == article.user.username}">
    <a href="<%=cp%>/article/${article.id}/del">Delete</a>
    <a href="<%=cp%>/article/${article.id}/edit">Edit</a>
</c:if>
<div id="note"></div>
</body>
</html>
