package assignment8;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "ProfileServlet", value = "/profile")
public class ProfileServlet extends HttpServlet {

    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User cur = (User)request.getSession().getAttribute("user");
        if (cur != null && cur.getAccess() >= 2) {
            UserDB db = UserDB.getInstance();
            User user = db.getUserById(Integer.parseInt(request.getParameter("id")));
            user.setPassword(request.getParameter("password"));
            user.setUsername(request.getParameter("username"));
            db.modifyUser(user);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = UserDB.getInstance().getUserById(Integer.parseInt(request.getParameter("id")));
        request.setAttribute("userById", user);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
