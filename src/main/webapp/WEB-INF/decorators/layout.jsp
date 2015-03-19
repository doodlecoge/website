<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
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

<html>
<head>
    <title><decorator:title/> - Huaichao Wang's Website</title>

    <%
        Pattern ptn = Pattern.compile("^http://(localhost|127\\.0\\.0\\.1)");
        String url = request.getRequestURL().toString();
        Matcher m = ptn.matcher(url);
        if (m.find()) {

        } else {

        }
    %>

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/css/site.css"
          charset="utf-8">

    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/jquery-1.11.1.js"></script>

    <script type="text/javascript">
        console = console || {
            log: new Function()
        }
    </script>

    <decorator:head/>
</head>
<body>
<div id="nav">
    <div class="c">
        <a href="/">Home</a>
        <a href="/article">Articles</a>
        <a href="/article/new">Write sth.</a>
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
</body>
</html>
