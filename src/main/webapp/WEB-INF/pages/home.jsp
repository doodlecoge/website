<%--
  Created by IntelliJ IDEA.
  User: huaiwang
  Date: 6/25/14
  Time: 9:13 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>Home Page</title>
    <style type="text/css">
        #stage {
            margin: 50px auto;
            width: 1000px;
            height: 300px;
            -webkit-perspective: 2000px;
            -webkit-perspective-origin: 50% -100%;
        }

        .ring {
            margin: 0 auto;
            height: 100px;
            width: 600px;
            -webkit-transform-style: preserve-3d;
            -webkit-animation: y-spin 10s linear 0s infinite;
        }

        .ring .card {
            position: absolute;
            left: 275px;
            width: 50px;
            height: 60px;
            text-align: center;
            line-height: 60px;
            font-size: 60px;
            font-family: "Courier New";
            font-weight: bold;
            -webkit-transition: all 1s;
            -moz-transition: all 1s;
            -ms-transition: all 1s;
            -o-transition: all 1s;
            transition: all 1s;
        }

        @-webkit-keyframes y-spin {
            0% {
                -webkit-transform: rotateY(0deg) translateY(100px)
            }
            50% {
                -webkit-transform: rotateY(-180deg) translateY(100px)
            }
            100% {
                -webkit-transform: rotateY(-360deg) translateY(100px)
            }
        }
    </style>
</head>
<body>
<div id="stage">
    <div class="ring part-nine-aniamtion"></div>
</div>
<script type="text/javascript">
    var chars = "WELCOME TO HUAICHAO.WANG<<<<<<<<<<<<".split('');
    var n = chars.length;
    $.fn.foo = function (i) {
        var deg = i * 360 / n;
        var x = Math.sin(i * 2 * Math.PI / n) * 600 + 100;
        var y = Math.sin(i * 2 * Math.PI / n) * 100;
        var transform = 'rotateY({ry}deg) translateX(0px) ' +
                'translate(0px) translateZ(300px)';
        transform = transform.replace(/\{ry\}/g, deg);
        this.css('-webkit-transform', transform);
        return this;
    };
    $(function () {
        for (var i = 0; i < n; i++) {
            var c = $('<div>').addClass('card').html(chars[i])
                    .appendTo($('.ring')).foo(i);
            if (chars[i] != '<') c.css('color', '#f33');
        }
    });
</script>
</body>
</html>
