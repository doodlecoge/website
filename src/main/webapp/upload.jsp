<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/4/9
  Time: 22:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<iframe id="ifrm" name="ifrm"></iframe>
<form action="/upload" method="post" enctype="multipart/form-data"
      target="ifrm">
    <input type="text" name="huaichao">
    <input type="file" name="file">
    <input type="submit" onclick="checkProgress()">
</form>
<div id="rst">sssssssssssss</div>
<script type="text/javascript">

    var t;

    function checkProgress() {
        clearTimeout(t);
        setTimeout(updateProgress, 300);
    }

    function updateProgress() {
        t = setTimeout(updateProgress, 500);

        var xhr = $.ajax({
            url: "<%=request.getContextPath()%>/progress",
            dataType: "json"
        });

        xhr.done(function (data) {
            var percent = Math.round(data.uploaded / data.total * 10000) / 100;
            $('#rst').html(percent + '%');
            if (data.total > 0 && data.uploaded == data.total) {
                clearTimeout(t);
            }
        });
    }
</script>
</body>
</html>
