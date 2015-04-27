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
            width: 112px;
            border: 1px solid #ccc;
            padding: 5px;
            vertical-align: top;
            margin-bottom: 10px;
        }

        ul.imgs li div {
            height: 100px;
            width: 100px;
            background: #ccc;
            font-size: 0;
        }

        ul.imgs span.helper {
            vertical-align: middle;
            display: inline-block;
            height: 100%;
            vertical-align: middle;
        }

        ul.img img {
            vertical-align: middle;
        }

        ul.imgs li a {
            line-height: 25px;
            display: block;
            text-align: center;
        }

        form input[type="text"] {
            width: 100%;
            display: block;
        }

        form table td {
            height: 35px;
        }

        @media screen and (max-device-width: 600px) {
            form .button {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<h2>Add Image:</h2>

<form method="post" enctype="multipart/form-data"
      action="<%=request.getContextPath()%>/image/upload">
    <table style="width: 100%">
        <tr>
            <td>Description:</td>
        </tr>
        <tr>
            <td><input type="text" name="imageName"></td>
        </tr>

        <tr>
            <td>Choose Image:</td>
        </tr>
        <tr>
            <td><input type="file" name="img"></td>
        </tr>

        <tr>
            <td><input type="submit" class="button blue"></td>
        </tr>
    </table>
</form>

<h2>Images:</h2>
<c:if test="${fn:length(images) > 0}">
    <ul class="imgs">
        <c:forEach items="${images}" var="image">
            <li>
                <div align="center">
                    <span class="helper"></span>
                    <img class="img" iid="${image.id}"
                         src="<%=cp%>/image/${image.id}"
                         title="${image.filename}"/>
                </div>
                <a class="del" href="<%=cp%>/image/${image.id}/del"
                   onclick="return confirm('delete this image?')">
                    delete
                </a>
            </li>
        </c:forEach>
    </ul>
</c:if>


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
