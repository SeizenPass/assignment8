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
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
</head>
<body class="container">
<div class="book">
    <h1>Book List:</h1>
    <ol class="list-group">
        <%
            User cur = (User)request.getSession().getAttribute("user");
            List<Book> books = (ArrayList<Book>)request.getAttribute("books");
            for (Book book: books) {
                if (book.getCount() <= 0 && cur.getAccess() < 2) continue;
                %>
        <li class="list-group-item d-flex justify-content-between align-items-center"> <a href="book?isbn=<%=book.getIsbn()%>"> <%= book.getTitle() %></a> <span class="badge badge-primary badge-pill"><%=book.getCount()%></span></li><hr>
        <%
            }
        %>
    </ol>
</div>
<div class="user">
    <h1>User List:</h1>
    <ol class="list-group">
        <%
            List<User> users = (ArrayList<User>)request.getAttribute("users");
            for (User user: users) {
        %>
        <li class="list-group-item d-flex justify-content-between align-items-center"><a href="profile?id=<%=user.getId()%>"><%= user.getUsername() %></a></li><hr>
        <%
            }
        %>
    </ol>
</div>
<br>
<div class="form2">
    <%
        if (cur.getAccess() == 2) {
    %>
    <div class="form1">
        <h3>Add Book</h3>
        <form method="post" action="book">
            <div class="form-group">
                <input type="hidden" value="add" name="action">
                <label for="exampleInputEmail1">ISBN: <input type="text" name="isbn" class="form-control" id="exampleInputEmail1"></label><br>
                <label for="exampleInputEmail2">Title: <input type="text" name="title" class="form-control" id="exampleInputEmail2"></label><br>
                <label for="exampleFormControlTextarea1">Description: <textarea name="description" rows="3" class="form-control" id="exampleFormControlTextarea1"></textarea></label><br>
                <label>Count:<br> <input type="number" name="count" class="form-group"></label><br>
            </div>
            <input type="submit" class="btn btn-primary" value="Save">
        </form>
    </div>
    <% }  %>
    <%
    if (cur.getAccess() == 2) {
    %>
    <div class="form1">
        <h3>Add User</h3>
    <form method="post" action="profile">
        <div class="form-group">
        <input type="hidden" value="add" name="action">
        <label for="exampleInputEmail3">Username: <input type="text" name="username" class="form-control" id="exampleInputEmail3"></label><br>
        <label for="exampleInputPassword1">Password: <input type="password" name="password" class="form-control" id="exampleInputPassword1"></label><br>
        <label>Access: <br><input type="number" name="access"></label><br>
        <input type="submit" class="btn btn-primary" value="Save">
        </div>
    </form>
    </div>
    <% }  %>
</div>
</body>
</html>
