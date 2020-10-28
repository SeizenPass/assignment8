package assignment8;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet(name = "ProfileServlet", value = "/profile")
public class ProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User cur = (User)request.getSession().getAttribute("user");
        if (cur != null && cur.getAccess() >= 2) {
            String val = request.getParameter("action").toUpperCase();
            UserDB db = UserDB.getInstance();
            switch (val) {
                case "UPDATE":
                    User user = db.getUserById(Integer.parseInt(request.getParameter("id")));
                    user.setPassword(request.getParameter("password"));
                    user.setUsername(request.getParameter("username"));
                    db.modifyUser(user);
                    break;
                case "DELETE":
                    db.deleteUser(Integer.parseInt(request.getParameter("id")));
                    break;
                case "DELETEBORROW":
                    BorrowDB.getInstance().deleteBorrow(Integer.parseInt(request.getParameter("borrow")));
                    //TODO count++ in books table using transaction
                default:
                    break;
            }

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = UserDB.getInstance().getUserById(id);
        List<Borrow> borrows = BorrowDB.getInstance().getBorrowsByUserId(id);
        request.setAttribute("userById", user);
        request.setAttribute("borrows", borrows);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
