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
<%
    String cp = request.getContextPath();
%>
<html>
<head>
    <title>Articles</title>
    <style type="text/css">
        ul.tags {
            padding: 0;
            margin: 0;
        }

        ul.tags li {
            list-style: none;
            display: inline-block;
            background: #eee;
            padding: 5px 10px;
            font-size: 18px;
        }

        ul.tags li a.del {
            text-decoration: none;
        }
    </style>
</head>
<body>
<br/>
<ul class="tags">
    <c:forEach items="${tags}" var="tag">
        <li>
            <a href="<%=cp%>/article/bytag/${tag.id}">${tag.name}</a>
            <a href="<%=cp%>/tag/${tag.id}/del" class="del">x</a>
        </li>
    </c:forEach>
</ul>
<br/>

<form action="<%=cp%>/tag/add">
    <input type="text" name="name" id="ipt">
    <input type="submit" value="Add Tag">
</form>

<br/>
<br/>
<script type="text/javascript">
    $(function () {
        $('.tags').click(function (e) {
            if (e.target.nodeName != 'i') return;
            var tid = $(e.target).parent().attr('tid');
            alert(tid);
        });
    });
</script>
</body>
</html>
