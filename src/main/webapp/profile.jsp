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

                }
            });
        }
    </script>
</head>
<body>
<div id="user">
    <h2>Profile</h2>
    <%
        if (currentUser.getAccess() < 2) {
            %>
        <h3>User: <%=user.getUsername()%>
    <%
        }
        else {
            %>
                <input type="text" name="username" value="<%=user.getUsername()%>" id="username"><br>
                <input type="password" name="password" value="<%=user.getPassword()%>" id="password"><br>
                <button onclick="changeData()">Change Data</button><br>
                <button onclick="deleteUser()">Delete User</button>
                <%
        }
    %>
            <div id="borrows">
                <h3>Borrows:</h3>
                <ul>
                    <%
                        for (Borrow borrow:
                             borrows) {
                            Book book = borrow.getBook();
                            %>
                    <li>
                        <a href="book?isbn=<%=book.getIsbn()%>"><%=book.getTitle()%></a><br>
                        <button onclick="deleteBorrow('<%=book.getIsbn()%>', <%=borrow.getId()%>)">Delete Borrow</button>
                        <hr>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
</div>
</body>
</html>
