<%@ page import="assignment8.User" %><%--
  Created by IntelliJ IDEA.
  assignment8.User: Sungat Kaparov
  Date: 27.10.2020
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h1>Hello World</h1>
<p>
    <%User user = (User) request.getSession().getAttribute("user");
    out.print(user.getUsername());
    %>
</p>
</body>
</html>
