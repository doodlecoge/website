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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%
    String cp = request.getContextPath();
%>
<html>
<head>
    <title>Articles</title>
    <style type="text/css">
        a.tag {
            min-width: 150px;
        }

        @media screen and (max-device-width: 600px) {
            a.tag {
                line-height: 40px;
                width: 45%;
            }
        }
    </style>
</head>
<body>
<br/>

<div class="tags">
    <c:forEach items="${tags}" var="tag">
        <a class="tag" href="<%=cp%>/article/${tag.id}/tag">
                ${tag.name}
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <i class="del fa fa-times" tid="${tag.id}"></i>
            </sec:authorize>
        </a>
    </c:forEach>
</div>
<br/>
<sec:authorize access="hasRole('ROLE_ADMIN')">
    <form action="<%=cp%>/tag/add">
        <input type="text" name="name" id="ipt" placeholder="tag name...">
        <br/>
        <br/>
        <input type="submit" value="Add Tag" class="button">
    </form>
</sec:authorize>
<br/>
<br/>
<script type="text/javascript">
    $(function () {
        $('.tags').click(function (e) {
            if (e.target.nodeName != 'I') return;
            e.preventDefault();
            var tid = $(e.target).attr('tid');
            location.href = "<%=cp%>/tag/" + tid + "/del";
        });
    });
</script>
</body>
</html>
