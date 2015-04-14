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
        @media screen and (min-device-width: 960px) {
            ul.tags li i.fa-times {
                color: #f55;
                cursor: pointer;
            }

            ul.tags li i.fa-times:hover {
                color: #f00;
            }
        }

        @media screen and (max-device-width: 600px) {
            ul.tags li {
                display: block;
                line-height: 35px;
                border-right-color: transparent;
            }
            ul.tags li:active {
                border: 1px solid transparent;
                border-bottom: 1px solid #468;
            }
            ul.tags li i {
                float: right;
                margin-top: 10px;
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
<br/>
<ul class="tags">
    <c:forEach items="${tags}" var="tag">
        <li>
            <a href="<%=cp%>/article/${tag.id}/tag">${tag.name}</a>
            <i class="del fa fa-times" tid="${tag.id}"></i>
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
            if (e.target.nodeName != 'I') return;
            e.preventDefault();
            var tid = $(e.target).attr('tid');
            location.href = "<%=cp%>/tag/" + tid + "/del";
        });
    });
</script>
</body>
</html>
