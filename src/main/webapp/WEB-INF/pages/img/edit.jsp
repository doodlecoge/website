<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/4/18
  Time: 7:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cp = request.getContextPath();
%>
<html>
<head>
    <title>Editing Image</title>
    <link rel="stylesheet" href="<%=cp%>/css/jquery.Jcrop.min.css">
    <script type="text/javascript"
            src="<%=cp%>/js/jquery.Jcrop.min.js"></script>
    <style type="text/css">
        .val {
            width: 50px;
        }

        @media screen and (max-device-width: 600px) {
            .button {
                width: 100%;
                display: block;
                text-align: center;
                margin-top: 10px;
                padding: 0.5em 0;
                box-sizing: border-box;
            }
        }


    </style>
</head>
<body>

<br/>
<br/>



<b>Scale</b>,
W: <input type="text" class="val" id="sw" value="200">px,
H: <input type="text" class="val" id="sh" value="200">px

<a id="cut" class="button blue">
    <i class="fa fa-cut"></i>
    Cut
</a>

<br/>
<br/>

<img id="img" style="max-width: 100%" iid="${image.id}"
     src="<%=request.getContextPath()%>/image/${image.id}">


<script type="text/javascript">
    $(function () {
        $('#img').load(function () {
            $('#img').Jcrop({
                aspectRatio: 1,
                setSelect: [0, 0, 100, 100],
                onSelect: crop
            });
        });

        $('#cut').click(function () {
            var img = $('#img');
            var iid = img.attr('iid');
            var data = {
                id: iid,
                img_w: img.width(),
                img_h: img.height(),
                cut_w: coords.w,
                cut_h: coords.h,
                cut_x: coords.x,
                cut_y: coords.y,
                s_w: $('#sw').val(),
                s_h: $('#sh').val()
            };
            console.log(data);
            var xhr = $.ajax({
                method: 'post',
                url: '<%=cp%>/image/' + iid + '/cut',
                data: data,
                dataType: 'json'
            });
            xhr.done(function (data) {
                if (data.error == false)
                    location.href = "<%=cp%>/image";
            });
        });
    });

    var coords = null;
    function crop(c) {
        coords = c;
    }


</script>
</body>
</html>
