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
</head>
<body>
<form method="post" action="login">
    <p>
        <label>Username</label>
        <br/>
        <input type="text" name="username">
    </p>

    <p>
        <label>Password</label>
        <br/>
        <input type="password" name="password">
    </p>

    <p>
        <input type="submit" value="Login" class="button">
    </p>

</form>
</body>
</html>
