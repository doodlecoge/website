<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/1/17
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style type="text/css">
        form input[type=text], form input[type=password] {
            font-size: 18px;
            border: 1px solid #ccc;
            width: 350px;
            height: 35px;
            padding-left: 10px;
        }
        table.login_tbl {
            width: 350px;
        }
        @media screen and (max-device-width: 600px) {
            table.login_tbl {
                width: 100%;
            }
            input {
                width: 100%;
                height: 35px;
                box-sizing: border-box;
                padding: 0;
            }
        }
    </style>
</head>
<body>
<form method="post" action="login">
    <table class="login_tbl">
        <tr>
            <td>Username</td>
        </tr>
        <tr>
            <td><input type="text" name="username"></td>
        </tr>
        <tr>
            <td>Password</td>
        </tr>
        <tr>
            <td><input type="password" name="password"></td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
            <td>
                <input type="submit" value="Login"
                       class="button blue"
                        style="font-size: 18px; font-weight: bold; height: 45px;">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
