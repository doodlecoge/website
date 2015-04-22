<%--
  Created by IntelliJ IDEA.
  User: huaiwang
  Date: 6/25/14
  Time: 9:13 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String cp = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>Home Page</title>
    <script type="text/javascript" src="<%=cp%>/js/jquery.plugins.js"></script>
    <style type="text/css">
        #widget_link {
            font-size: 18px;
            font-weight: bold;
            color: #555;
            line-height: 50px;
            border-bottom: 1px solid #ddd;
        }
    </style>
    <script type="text/javascript">
        <c:if test="${widget != null}">
        $(function () {
            var xhr = $.ajax({
                url: '<%=cp%>/widget/${widget.id}/json',
                dataType: 'json'
            });
            xhr.done(function (data) {
                $.fn.loadWidget({
                    appendTo: '#ccc',
                    html: data.html,
                    js: data.js,
                    css: data.css
                });
            });
        });
        </c:if>
    </script>
</head>
<body>
<c:if test="${widget != null}">
    <div id="widget_link">
        <b>Widget of Day:</b>
        <a href="<%=cp%>/widget/${widget.id}">
                <i>${widget.title}</i>
        </a>
    </div>
</c:if>
<div id="ccc"></div>
</body>
</html>
