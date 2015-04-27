<%@ page import="wang.huaichao.security.UserUtils" %>
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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
    String cp = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title><decorator:title/> - Huaichao Wang's Website</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" href="<%=cp%>/css/site.css" charset="utf-8">
    <link rel="stylesheet" href="<%=cp%>/css/site.mobile.css" charset="utf-8">
    <link rel="stylesheet" href="<%=cp%>/css/font-awesome.min.css"
          charset="utf-8">
    <script type="text/javascript" src="<%=cp%>/js/jquery-1.11.1.js"></script>
    <style type="text/css">

    </style>
    <script type="text/javascript">
        if (typeof console === 'undefined') {
            console = {
                log: new Function()
            }
        }

        function dockFooter() {
            var clientHeight = document.clientHeight ||
                    document.documentElement.clientHeight;
            var height = $(document.body).height();
            var cls = 'dock_bottom';
            var body = $(document.body);
            var fh = $('#footer').outerHeight();
            if (clientHeight > height) {
                if (!$('#footer').hasClass(cls)) {
                    $('#footer').addClass(cls);
                    body.css('padding-bottom', (10 + fh) + 'px');
                }
            } else {
                if ($('#footer').hasClass(cls)) {
                    $('#footer').removeClass(cls);
                    body.css('padding-bottom', '0');
                }
            }
        }
        $(function () {
            dockFooter();
            setTimeout(dockFooter, 200);
            $(window).on('resize', dockFooter);
        });
    </script>
    <decorator:head/>
</head>
<body>
<div id="nav">
    <div class="c">
        <div class="menus">
            <a href="<%=cp%>/">
                <i class="fa fa-home"></i>
                Home
            </a>
            <a href="<%=cp%>/article">
                <i class="fa fa-file-text-o"></i>
                Articles
            </a>
            <a href="<%=cp%>/tag">
                <i class="fa fa-bookmark-o"></i>
                tags
            </a>
            <a href="<%=cp%>/article/new">
                <i class="fa fa-pencil-square-o"></i>
                Write sth.
            </a>
            <%--<a href="<%=cp%>/t">--%>
            <%--<i class="fa fa-wrench"></i>--%>
            <%--Tools--%>
            <%--</a>--%>
            <a href="<%=cp%>/widget">
                <i class="fa fa-th"></i>
                Widgets
            </a>
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <a href="<%=cp%>/image">
                    <i class="fa fa-file-image-o"></i>
                    Images
                </a>
            </sec:authorize>
        </div>
        <div class="login_info">
            <sec:authorize access="isAuthenticated()">
                <a href="javascript:;">
                    Hi, <i class="fa fa-user"></i>
                    <sec:authentication property="principal.username"/>!
                </a>
                <a href="<%=cp%>/logout">
                    <i class="fa fa-power-off"></i>
                    Logout
                </a>
            </sec:authorize>
            <sec:authorize access="isAnonymous()">
                <a href="<%=cp%>/login">
                    <i class="fa fa-key"></i>
                    Login
                </a>
            </sec:authorize>
        </div>
        <div style="clear: both;"></div>
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
<%
    String host = request.getServerName();
    boolean bLocal = "localhost".equalsIgnoreCase(host) ||
            "127.0.0.1".equalsIgnoreCase(host);
    pageContext.setAttribute("blocal", bLocal);
%>
<c:if test='${pageContext.getAttribute("blocal") == false}'>
<jsp:include page="ga.jsp"></jsp:include>
</c:if>
</body>
</html>
