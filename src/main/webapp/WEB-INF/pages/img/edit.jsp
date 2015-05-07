<%@ page import="java.util.Calendar" %>
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
    long ts = Calendar.getInstance().getTimeInMillis();
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


<button id="cut" class="button">
    <i class="fa fa-cut"></i>
    Cut
</button>

<button id="del" class="button red"
   href="<%=cp%>/image/${image.id}/del"
   onclick="return confirm('delete this image?')">
    <i class="fa fa-times"></i>
    Delete
</button>

<hr/>

<input type="checkbox" id="fix_ratio">
<label for="fix_ratio">
    <b>Fixed Cut Ratio</b>,
</label>
X: <input type="text" class="val" id="rx" value="1" disabled>,
Y: <input type="text" class="val" id="ry" value="1" disabled>;
<hr>

<input type="checkbox" id="scale">
<label for="scale">
    <b>Scale</b>,
</label>
W: <input type="text" class="val" id="sw" value="200" disabled>px,
H: <input type="text" class="val" id="sh" value="200" disabled>px;
<hr/>


<br/>
<br/>

<img id="img" style="max-width: 100%" iid="${image.id}"
     src="<%=request.getContextPath()%>/image/${image.id}?t=<%=ts%>}">


<script type="text/javascript">
    $(function () {
        var jcrop_api = null;

        $('#img').load(function () {
            $('#img').Jcrop({
                setSelect: [0, 0, 100, 100],
                onSelect: crop
            }, function () {
                jcrop_api = this;
            });
        });

        $('#fix_ratio').change(_changeRatio);
        $('#rx').change(_changeRatio);
        $('#ry').change(_changeRatio);

        $('#scale').change(function () {
            if ($(this).is(':checked')) {
                $('#sw').prop('disabled', false);
                $('#sh').prop('disabled', false);
            } else {
                $('#sw').prop('disabled', true);
                $('#sh').prop('disabled', true);
            }
        });

        function _changeRatio() {
            if ($('#fix_ratio').is(':checked')) {
                $('#rx').prop('disabled', false);
                $('#ry').prop('disabled', false);
                var x = parseInt($('#rx').val());
                var y = parseInt($('#ry').val());
                jcrop_api.setOptions({
                    aspectRatio: x / y
                });
            } else {
                $('#rx').prop('disabled', true);
                $('#ry').prop('disabled', true);
                jcrop_api.setOptions({
                    aspectRatio: null
                });
            }
        }

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
                s_w: $('#scale').is(':checked') ? $('#sw').val() || 0 : 0,
                s_h: $('#scale').is(':checked') ? $('#sh').val() || 0 : 0
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
            xhr.fail(function(data) {
                console.log(data);
            })
        });
    });

    var coords = null;
    function crop(c) {
        coords = c;
    }


</script>
</body>
</html>
