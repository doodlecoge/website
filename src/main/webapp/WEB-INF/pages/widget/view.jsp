<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/4/21
  Time: 14:02
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
    <title>${widget.title}</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <style type="text/css">${widget.css}</style>
    <script type="text/javascript" src="<%=cp%>/js/jquery-1.11.1.js"></script>
</head>
<body>
${widget.html}
<script type="text/javascript">${widget.js}</script>
</body>
</html>
