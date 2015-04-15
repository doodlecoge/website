<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/4/15
  Time: 13:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cp = request.getContextPath();
%>
<html>
<head>
    <title>Tools</title>
    <style type="text/css">
        .list a {
            line-height: 30px;
            font-size: 18px;
            display: block;
        }
    </style>
</head>
<body>
<br/>

<div class="list">
    <a href="<%=cp%>/t/reqinfo">View HTTP Request Info</a>
    <a href="<%=cp%>/t/runjs">Online HTML/CSS/Javascript Editor</a>
</div>
</body>
</html>
