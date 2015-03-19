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
            width: 350px;
        }
    </style>
</head>
<body>
<form method="post" action="login">
    <table>
        <tr>
            <td>Username</td>
            <td><input type="text" name="username"></td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input type="password" name="password"></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <input type="submit" value="Submit" class="button">
                <input type="button" value="Cancel" class="button blue">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
