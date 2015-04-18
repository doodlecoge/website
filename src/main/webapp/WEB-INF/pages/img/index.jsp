<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/4/17
  Time: 17:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String cp = request.getContextPath();
%>
<html>
<head>
    <title>Uploaded Images</title>
    <style type="text/css">
        ul.imgs img {
            max-width: 100px;
            max-height: 100px;
            margin: auto;
            vertical-align: middle;
        }

        ul.imgs {
            margin: 0;
            padding: 0;
        }

        ul.imgs li {
            list-style: none;
            display: inline-block;
            height: 100px;
            width: 100px;
            border: 1px solid #ccc;
            padding: 5px;
            vertical-align: top;
            line-height: 100px;
        }

        ul.imgs li div {
            height: 100px;
            width: 100px;
            background: #ccc;
            font-size: 0;
        }

        form input {
            width: 350px;
            display: block;
        }
    </style>
</head>
<body>
<br/>
<c:if test="${fn:length(images) > 0}">
    <ul class="imgs">
        <c:forEach items="${images}" var="image">
            <li>
                <div align="center"><img class="img" iid="${image.id}"
                         src="<%=cp%>/image/${image.id}"
                         title="${image.filename}"/>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>

<hr/>

<form method="post" enctype="multipart/form-data"
      action="<%=request.getContextPath()%>/image/upload">
    <input type="text" name="imageName">
    <input type="file" name="img">
    <input type="submit" class="button blue">
</form>

<script type="text/javascript">
    $(function () {
        $('.imgs').click(function (e) {
            if (e.target.nodeName.toLowerCase() != 'img') return;
            var iid = $(e.target).attr('iid');
            location.href = "<%=cp%>/image/" + iid + "/edit";
        });
    });
</script>
</body>
</html>
