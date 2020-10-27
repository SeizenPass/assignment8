import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.List;

@WebServlet("/Auth")
public class Auth extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserDB uDB = UserDB.getInstance();
        List<User> users = uDB.getUsers();

        for (User userList:users){
            if (userList.getUsername().equals(username) && userList.getPassword().equals(password)){
                response.sendRedirect("dashboard.jsp");
                Cookie usernamec = new Cookie("username", username);
                Cookie passwordc = new Cookie("password", password);
                usernamec.setMaxAge(60*30);
                passwordc.setMaxAge(60*30);
                response.addCookie(usernamec);
                response.addCookie(passwordc);
            }else {
                PrintWriter out = response.getWriter();
                out.println("Such user does not exist");
            }
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
