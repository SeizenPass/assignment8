package assignment8;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BookServlet", value = "/book")
public class BookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User cur = (User)request.getSession().getAttribute("user");
        if (cur != null && cur.getAccess() == 1) {
            String action = request.getParameter("action").toUpperCase();
            switch (action) {
                case "BORROW":
                    Book borrowBook = BookDB.getInstance().getBookByIsbn(request.getParameter("isbn"));
                    BorrowDB db = BorrowDB.getInstance();
                    db.addBorrow(cur, borrowBook);
                    break;
            }
        }
        if (cur != null && cur.getAccess() >= 2) {
            String action = request.getParameter("action").toUpperCase();
            BookDB db = BookDB.getInstance();
            switch (action) {
                case "UPDATE":
                    Book book = db.getBookByIsbn(request.getParameter("isbn"));
                    book.setTitle(request.getParameter("title"));
                    book.setDescription(request.getParameter("description"));
                    db.modifyBook(book);
                    break;
                case "ADD":
                    String isbn = request.getParameter("isbn"),
                            title = request.getParameter("title"),
                            description = request.getParameter("description");
                    int count = Integer.parseInt(request.getParameter("count"));
                    Book newBook = new Book(isbn, title, description, count);
                    db.addBook(newBook);
                    response.sendRedirect("dashboard");
                    break;
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String isbn = request.getParameter("isbn");
        Book book = BookDB.getInstance().getBookByIsbn(isbn);
        List<Borrow> borrows = BorrowDB.getInstance().getBorrowsByIsbn(isbn);
        request.setAttribute("book", book);
        request.setAttribute("borrows", borrows);
        request.getRequestDispatcher("book.jsp").forward(request, response);
    }
}
