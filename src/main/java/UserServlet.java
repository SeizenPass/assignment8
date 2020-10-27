import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/api/v1.0/users/*")
public class UserServlet extends HttpServlet {

    // GET/api/v1.0/users/
    // GET/api/v1.0/users/{id}
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDB uDB = UserDB.getInstance();
        String pathInfo = req.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            req.setAttribute("users", uDB.getUsers());
            return;
        } else {
            String[] splits = pathInfo.split("/");
            int id = Integer.parseInt(splits[1]);
            req.setAttribute("userById", uDB.getUserById(id));
        }
        req.getRequestDispatcher(req.getParameter("url")).forward(req, resp);
    }

    // POST/api/v1.0/users/
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDB uDB = UserDB.getInstance();
        int id = Integer.parseInt(req.getParameter("id"));
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        int access = Integer.parseInt(req.getParameter("access"));
        User user = new User(id, username, password, access);
        uDB.addUser(user);
        req.getRequestDispatcher(req.getParameter("Auth")).forward(req, resp);
    }

    // PUT/api/v1.0/users/
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDB uDB = UserDB.getInstance();
        int id = Integer.parseInt(req.getParameter("id"));
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        int access = Integer.parseInt(req.getParameter("access"));
        User user = new User(id, username, password, access);
        uDB.modifyUser(user);
        req.getRequestDispatcher(req.getParameter("url")).forward(req, resp);
    }

    // DELETE/api/v1.0/users/{id}
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDB uDB = UserDB.getInstance();
        String pathInfo = req.getPathInfo();
        String[] splits = pathInfo.split("/");
        int id = Integer.parseInt(splits[1]);
        uDB.deleteUser(id);
        req.getRequestDispatcher(req.getParameter("url")).forward(req, resp);
    }
}
