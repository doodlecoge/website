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
<div id="ccc"></div>
</body>
</html>
