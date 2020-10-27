<%@ page import="assignment8.Book" %>
<%@ page import="assignment8.User" %><%--
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
%>
<html>
<head>
    <title>Book: <%=book.getTitle()%></title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        function updateBook() {
            book = $('#book')
            title = $('#title').val()
            description = $('#description').val()
            $.ajax({
                url: 'book',
                type: "POST",
                data: {
                    isbn: '<%=book.getIsbn()%>',
                    title: title,
                    description: description
                }, accepts: "application/json; charset=utf-8",
                success: function (data) {

                }
            });
        }
        function borrow() {

        }
    </script>
</head>
<body>
<div id="book">
    <h3>Book</h3><br>
    <h6>ISBN: <%=book.getIsbn()%></h6><br>
    <%
    if (currentUser.getAccess() < 2) {
        %>
    <h4>Title: <%=book.getTitle()%></h4><br>
    <h4>Description: </h4><br>
    <p><%=book.getDescription()%></p>
    <%
        if (currentUser.getAccess() == 1) {
            %>
    <button onclick="borrow()">Borrow</button>
    <%
        }
    }
    else {
        %>
    <h4>Title: <input type="text" name="title" id="title" value="<%=book.getTitle()%>"></h4><br>
    <h4>Description: </h4><br>
    <textarea id="description"><%=book.getDescription()%></textarea>
    <button onclick="updateBook()">Change Data</button>
    <%
    }
    %>
    <h4>Stock: <%=book.getCount()%>></h4>
</div>
</body>
</html>
