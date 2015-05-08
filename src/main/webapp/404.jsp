<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/5/8
  Time: 14:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cp = request.getContextPath();
%>
<html>
<head>
    <title></title>
    <style type="text/css">
        body, html {
            height: 100%;
        }

        .not-found {
            position: absolute;
            width: 400px;
            height: 300px;
            top: 50%;
            left: 50%;
            margin-left: -200px;
            margin-top: -200px;
            text-align: center;
            font-family: Consolas, "Liberation Mono", Menlo, Courier, monospace;
        }

        .not-found span {
            font-size: 128px;
            color: #555;
        }

        .not-found a {
            font-size: 1.5em;
        }
    </style>
</head>
<body>
<div class="not-found">
    <span>404</span>
    <br/>
    <a href="<%=cp%>">HOME PAGE</a>
</div>

</body>
</html>
