package assignment8;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDB {
    private static UserDB userDB = new UserDB();
    private static Connection cn = LibraryDatabase.getInstance().getConnection();
    private static List<User> users = new ArrayList<>();

    private UserDB() {}

    public static UserDB getInstance() {
        init();
        return userDB;
    }

    private static void init() {
        try {
            Statement s = cn.createStatement();
            ResultSet rs = s.executeQuery("SELECT * FROM users");
            User user;
            int id;
            String username;
            String password;
            int access;
            while(rs.next()) {
                id = rs.getInt(1);
                username = rs.getString(2);
                password = rs.getString(3);
                access = rs.getInt(4);
                user = new User(id, username, password, access);
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<User> getUsers() {
        return users;
    }

    public User getUserById(int id) {
        for (User u : users) {
            if (u.getId() == id) {
                return u;
            }
        }
        return new User(-1, "Guest", "", 0);
    }

    public void addUser(User user) {
        users.add(user);
        try {
            PreparedStatement ps = cn.prepareStatement("INSERT INTO users(id, username, password, access)" +
                    "VALUES (?, ?, ?, ?)");
            ps.setInt(1, user.getId());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setInt(4, user.getAccess());
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void modifyUser(User user) {
        for (User u : users) {
            if (u.getId() == user.getId()) {
                u.setUsername(user.getUsername());
                u.setPassword(user.getPassword());
                u.setAccess(user.getAccess());
                break;
            }
        }
        try {
            PreparedStatement ps = cn.prepareStatement("UPDATE users " +
                    "SET username=?, password=?, access=?" +
                    "WHERE id=?");
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setInt(3, user.getAccess());
            ps.setInt(4, user.getId());
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(int id) {
        users.removeIf(u -> u.getId() == id);
        try {
            PreparedStatement ps = cn.prepareStatement("DELETE FROM users" +
                    "WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
