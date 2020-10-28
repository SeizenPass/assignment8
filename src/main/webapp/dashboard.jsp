<%@ page import="assignment8.User" %>
<%@ page import="assignment8.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
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
    <h1>Book List:</h1>
    <ol>
        <%
            User cur = (User)request.getSession().getAttribute("user");
            List<Book> books = (ArrayList<Book>)request.getAttribute("books");
            for (Book book: books) {
                if (book.getCount() <= 0 && cur.getAccess() < 2) continue;
                %>
        <li> <a href="book?isbn=<%=book.getIsbn()%>"> <%= book.getTitle() %></a> <br> <%=book.getCount()%></li><hr>
        <%
            }
        %>
    </ol>
    <%
        if (cur.getAccess() == 2) {
    %>
    <form method="post" action="book">
        <input type="hidden" value="add" name="action">
        <label>ISBN: <input type="text" name="isbn"></label><br>
        <label>Title: <input type="text" name="title"></label><br>
        <label>Description: <textarea name="description" rows="5"></textarea></label><br>
        <label>Count: <input type="number" name="count"></label><br>
        <input type="submit">
    </form>
     <% }  %>
    <h1>User List:</h1>
    <ol>
        <%
            List<User> users = (ArrayList<User>)request.getAttribute("users");
            for (User user: users) {
        %>
        <li><a href="profile?id=<%=user.getId()%>"><%= user.getUsername() %></a></li><hr>
        <%
            }
        %>
    </ol>
    <%
    if (cur.getAccess() == 2) {
    %>
    <form method="post" action="profile">
        <input type="hidden" value="add" name="action">
        <label>Username: <input type="text" name="username"></label><br>
        <label>Password: <input type="password" name="password"></label><br>
        <label>Access: <input type="number" name="access"></label><br>
        <input type="submit">
    </form>
    <% }  %>

</body>
</html>
