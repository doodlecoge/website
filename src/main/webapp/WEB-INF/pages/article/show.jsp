<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/1/17
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Articles</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/marked.js"></script>
    <style type="text/css">
        .title {
            font-size: 24px;
            font-weight: bold;
            padding: 10px 0;
        }

        .tags {
            padding: 10px 0;
        }

        .tags span {
            padding: 5px 10px;
            background: #eee;
            margin-right: 10px;
        }

        #note {

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

<div class="title">${article.title}</div>
<hr/>
<div class="tags">
    <c:forEach items="${article.tags}" var="tag">
        <span>${tag.name}</span>
    </c:forEach>
</div>
<hr/>
<div>${article.content}</div>
<div id="note"></div>
</body>
</html>
