<%@ page import="assignment8.User" %>
<%@ page import="assignment8.UserDB" %>
<%@ page import="assignment8.Borrow" %>
<%@ page import="java.util.List" %>
<%@ page import="assignment8.Book" %><%--
  Created by IntelliJ IDEA.
  assignment8.User: Amiran
  Date: 27-Oct-20
  Time: 4:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    User user = (User) request.getAttribute("userById");
    User currentUser = (User) session.getAttribute("user");
    List<Borrow> borrows = (List<Borrow>) request.getAttribute("borrows");
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        function changeData() {
            var user = $('#user'),
                username = user.children('#username').val(),
                password = user.children('#password').val()
            $.ajax({
                url: 'profile',
                type: "POST",
                data: {
                    id: <%=user.getId()%>,
                    password: password,
                    username: username,
                    action: "update"
                }, accepts: "application/json; charset=utf-8",
                success: function (data) {
                    location.reload();
                }
            });
        }
        function deleteUser() {
            $.ajax({
                url: 'profile',
                type: "POST",
                data: {
                    id: <%=user.getId()%>,
                    action: "delete"
                }, accepts: "application/json; charset=utf-8",
                success: function (data) {
                    location.reload();
                }
            });
        }
        function deleteBorrow(isbn, borrow) {
            $.ajax({
                url: 'profile',
                type: "POST",
                data: {
                    id: <%=user.getId()%>,
                    isbn: isbn,
                    borrow: borrow,
                    action: "deleteBorrow"
                }, accepts: "application/json; charset=utf-8",
                success: function (data) {
                    location.reload();
                }
            });
        }
    </script>
</head>
<body class="container">
<div id="user">
    <form class="form3">
    <h2>Profile</h2>
    <%
        if (currentUser.getAccess() < 2) {
            %>
        <h3>User: <%=user.getUsername()%>
    <%
        }
        else {
            %>
                <input type="text" name="username" class="form-control" value="<%=user.getUsername()%>" id="username"><br>
                <input type="password" name="password" class="form-control" value="<%=user.getPassword()%>" id="password"><br>
                <button onclick="changeData()" class="btn btn-primary">Change Data</button><br><br>
                <button onclick="deleteUser()" class="btn btn-primary">Delete User</button>
                <%
        }
    %>
            <div id="borrows">
                <h3>Borrows:</h3>
                <ul class="list-group">
                    <%
                        for (Borrow borrow:
                             borrows) {
                            Book book = borrow.getBook();
                            %>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <a href="book?isbn=<%=book.getIsbn()%>"><%=book.getTitle()%></a>
                        <%
                        if (currentUser.getAccess() >= 2) {
                            %>
                        <button class="btn btn-primary" onclick="deleteBorrow('<%=book.getIsbn()%>', <%=borrow.getId()%>)">Delete Borrow</button>
                        <%
                        }
                        %>
                        <hr>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
    </form>
</div>
</body>
</html>
