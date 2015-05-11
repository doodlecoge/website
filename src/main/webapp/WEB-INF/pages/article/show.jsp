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
    String cp = ".";
    String base = request.getScheme() + "://"
            + request.getServerName()
            + ":" + request.getServerPort()
            + request.getContextPath()
            + "/";
%>
<html>
<head>
    <title>Articles</title>
    <base href="<%=base%>">
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/marked.js"></script>
    <script type="text/x-mathjax-config">
        MathJax.Hub.Config({
          tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
        });
    </script>
    <script src='https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML'></script>
    <style type="text/css">
        .tags {
            margin: 0;
            padding: 0;
        }

        .tags li {
            display: inline;
        }

        .tags li a {
            margin-bottom: 6px;
        }

        #note_wrapper {
            margin-top: 10px;
            border-top: 1px dashed #69c;
            vertical-align: top;
            position: relative;
        }

        #outline {
            font-size: 18px;
        }

        #outline ul {
            margin: 0;
            padding: 0 0 0 20px;
        }

        #outline ul a:hover {
            text-decoration: underline;
            color: #69c;
        }

        #note {
            height: 100%;
            vertical-align: top;
        }

        .overmenu {
            position: fixed;
            top: 0px;
            right: 10px;
            background: #f5f5f5;
            max-width: 250px;
            padding: 10px;
            -webkit-box-shadow: 0px 0px 15px 0px rgba(50, 50, 50, 0.5);
            -moz-box-shadow: 0px 0px 15px 0px rgba(50, 50, 50, 0.5);
            box-shadow: 0px 0px 15px 0px rgba(50, 50, 50, 0.5);
        }

        @media screen and (max-device-width: 600px) {
            .overmenu {
                position: inherit;
            }
        }

        p {
            margin: 0;
            color: #555;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var txt = $('#raw').val();
            var data = marked.withOutline(txt);
            $("#note").html(data.html);
            MathJax.Hub.Queue(
                    ["Typeset", MathJax.Hub, $('#note').get(0)]
            );
            $("#outline").html(data.outline);

            var outline = $('#outline');
            $('#pholder').height(outline.height());
            var h = outline.offset().top + outline.height();

            $(window).on('scroll', function () {
                if ($(window).scrollTop() > h) {
                    outline.addClass('overmenu');
                } else {
                    outline.removeClass('overmenu');
                }
            });


            var href = location.href;
            var idx = href.indexOf('#');
            if (idx != -1) href = href.substr(0, idx);

            $('#outline').click(function (e) {
                if (e.target.nodeName.toLowerCase() == 'a') {
                    e.preventDefault();
                    location.href = href + $(e.target).attr('href');
                }
            });
        });
    </script>
</head>
<body>
<textarea id="raw" style="display: none;">${article.content}</textarea>

<div style="text-align: center">
    <h1 style="margin-bottom: 6px;">${article.title}</h1>

    <p style="font-weight: bold;">${article.user.fullname}</p>

    <p>
        <fmt:formatDate value="${article.createdAt}" pattern="yyyy-MM-dd"/>
        ~
        <fmt:formatDate value="${article.updatedAt}" pattern="yyyy-MM-dd"/>
    </p>

    <p class="h5"></p>

    <c:if test="${fn:length(article.tags) > 0}">
        <ul class="tags">
            <c:forEach items="${article.tags}" var="tag">
                <li>
                    <a href="<%=cp%>/article/${tag.id}/tag"
                       class="tag">${tag.name}</a>
                </li>
            </c:forEach>
        </ul>
    </c:if>

    <c:if test="${username == article.user.username}">
        <a href="<%=cp%>/article/${article.id}/del">DELETE</a>
        <a href="<%=cp%>/article/${article.id}/edit">EDIT</a>
    </c:if>
</div>

<div id="note_wrapper">
    <h1 style="margin: 0">Table of Contents:</h1>

    <div id="pholder">
        <div id="outline"></div>
    </div>
    <br/>

    <div id="note" class="preview"></div>
</div>

</body>
</html>
