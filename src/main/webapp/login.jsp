<%--
  Created by IntelliJ IDEA.
  User: Sungat Kaparov
  Date: 27.10.2020
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login page</title>
</head>
<body>
<%--    <%--%>
<%--        if (request.getSession().getAttribute("count") != null) {--%>
<%--            int count = (int) request.getSession().getAttribute("count") + 1;--%>
<%--            request.getSession().setAttribute("count", count);--%>
<%--        }--%>
<%--        Cookie[] ck = request.getCookies();--%>
<%--        Boolean here = false;--%>
<%--        for (Cookie c:ck) {--%>
<%--            if (c.getName().equals("loggedIn") && c.getValue().equals("true")){--%>
<%--                here = true;--%>
<%--            }--%>
<%--        }--%>
<%--        if (here){--%>
<%--            response.sendRedirect("dashboard.jsp");--%>
<%--        }--%>
<%--    %>--%>
    <h1>Login Form</h1>
    <form method="post" action="Auth">
        <label>Username:</label><br>
        <input type="text" name="username"><br>
        <label>Password:</label><br>
        <input type="password" name="password"><br>
        <input type="submit">
    </form>
    <h6>If you want to be a guest, type "guest" in Username field and press Submit</h6>
</body>
</html>
