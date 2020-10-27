package assignment8;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "BookServlet", value = "/book")
public class BookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User cur = (User)request.getSession().getAttribute("user");
        if (cur != null && cur.getAccess() >= 2) {
            BookDB db = BookDB.getInstance();
            Book book = db.getBookByIsbn(request.getParameter("isbn"));
            book.setTitle(request.getParameter("title"));
            book.setDescription(request.getParameter("description"));
            db.modifyBook(book);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Book book = BookDB.getInstance().getBookByIsbn(request.getParameter("isbn"));
        request.setAttribute("book", book);
        request.getRequestDispatcher("book.jsp").forward(request, response);
    }
}
