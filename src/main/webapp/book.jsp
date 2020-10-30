<%@ page import="assignment8.Book" %>
<%@ page import="assignment8.User" %>
<%@ page import="assignment8.Borrow" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Amiran
  Date: 27-Oct-20
  Time: 9:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Book book = (Book)request.getAttribute("book");
    User currentUser = (User) session.getAttribute("user");
    List<Borrow> borrows = (List<Borrow>)request.getAttribute("borrows");
%>
<html>
<head>
    <title>Book: <%=book.getTitle()%></title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        $( document ).ready(function () {
            $('#updateBookButton').click(function () {
                book = $('#book')
                title = $('#title').val()
                description = $('#description').val()
                $.ajax({
                    url: 'book',
                    type: "POST",
                    data: {
                        isbn: '<%=book.getIsbn()%>',
                        title: title,
                        description: description,
                        action: 'update'
                    }, accepts: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function (data) {
                        location.reload()
                    }
                });
            });
            $('#borrowButton').click(function () {
                $.ajax({
                    url: 'book',
                    type: "POST",
                    data: {
                        action: "borrow",
                        isbn: '<%=book.getIsbn()%>'
                    }, accepts: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function (data) {
                        location.reload()
                    }
                });
            });
        });

    </script>
</head>
<body class="container">
<div id="book">
    <form class="form3">
    <h3>Book</h3>
    <h6>ISBN: <%=book.getIsbn()%></h6>
    <%
    if (currentUser.getAccess() < 2) {
        %>
    <h4>Title: <%=book.getTitle()%></h4>
    <h4>Description: </h4>
    <p><%=book.getDescription()%></p>
    <%
        if (currentUser.getAccess() == 1 && book.getCount() > 0) {
            %>
    <input type="button" id="borrowButton" value="Borrow">
    <%
        }
    }
    else {
        %>
    <h4>Title: <input type="text" class="form-control" name="title" id="title" value="<%=book.getTitle()%>"></h4>
    <h4>Description: </h4>
    <textarea id="description" class="form-control"><%=book.getDescription()%></textarea><br>
    <input type="button" class="btn btn-primary" id="updateBookButton" value="Change Data">
    <%
    }
    %>
    <h4>Stock: <%=book.getCount()%></h4>
    <h3>Debtors:</h3>
    <ul class="list-group">
    <%
        for (Borrow borrow:
             borrows) {
            User user = borrow.getUser();
            %>
        <li class="list-group-item d-flex justify-content-between align-items-center">
            <a href="profile?id=<%=user.getId()%>"><%=user.getUsername()%></a>
        </li>
    <%
        }
    %>
    </ul>
    </form>
</div>
</body>
</html>
