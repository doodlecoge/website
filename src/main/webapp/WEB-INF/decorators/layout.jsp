<%--
  Created by IntelliJ IDEA.
  User: hch
  Date: 2014/5/28
  Time: 18:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
           prefix="decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String cp = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title><decorator:title/> - Huaichao Wang's Website</title>
    <link rel="stylesheet" href="<%=cp%>/css/site.css" charset="utf-8">
    <script type="text/javascript" src="<%=cp%>/js/jquery-1.11.1.js"></script>
    <style type="text/css">
        .dock_bottom {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
        }
    </style>
    <script type="text/javascript">
        if (typeof console === 'undefined') {
            console = {
                log: new Function()
            }
        }
    </script>
    <decorator:head/>
</head>
<body>
<div id="nav">
    <div class="c">
        <a href="<%=cp%>">Home</a>
        <a href="<%=cp%>/article">Articles</a>
        <a href="<%=cp%>/tag">tags</a>
        <a href="<%=cp%>/article/new">Write sth.</a>
    </div>
</div>
<div id="header">
    <div class="c">
        <span class="brand">huaichao.wang</span>
    </div>
</div>

<div id="content" class="c">
    <decorator:body/>
</div>
<div id="footer">
    <div class="c">
        Copyright &copy; huaichao.wang since 2014.
    </div>
</div>
<script type="text/javascript">
    $(function () {
        console.log($(document).height(),$(document.body).height());
        if ($(document).height() > $(document.body).height()) {
            $('#footer').addClass('dock_bottom');
        }
    });
</script>
</body>
</html>
