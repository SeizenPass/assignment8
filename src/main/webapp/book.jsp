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
                    location.reload();
                }
            });
        }
        function borrow() {
            //TODO implement borrow as a student
            $.ajax({
                url: 'book',
                type: "POST",
                data: {
                    action: "borrow",
                    isbn: '<%=book.getIsbn()%>'
                }, accepts: "application/json; charset=utf-8",
                success: function (data) {
                    location.reload();
                }
            });
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
        if (currentUser.getAccess() == 1 && book.getCount() > 0) {
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
    <h4>Stock: <%=book.getCount()%></h4>
    <h3>Debtors:</h3>
    <ul>
    <%
        for (Borrow borrow:
             borrows) {
            User user = borrow.getUser();
            %>
        <li>
            <a href="profile?id=<%=user.getId()%>"><%=user.getUsername()%></a>
        </li>
    <%
        }
    %>
    </ul>
</div>
</body>
</html>
