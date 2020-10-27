package assignment8;

import jdk.internal.net.http.common.Pair;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class BorrowDB {
    private static BorrowDB borrowDB = new BorrowDB();
    private static Connection cn = LibraryDatabase.getInstance().getConnection();
    private static List<Borrow> borrows = new ArrayList<>();

    private BorrowDB() {}

    public static BorrowDB getInstance() {
        init();
        return borrowDB;
    }

    private static void init() {
        try {
            Statement s = cn.createStatement();
            ResultSet rs = s.executeQuery("SELECT * FROM borrows");
            Book book;
            User user;
            Borrow borrow;
            UserDB udb = UserDB.getInstance();
            BookDB bdb = BookDB.getInstance();
            while(rs.next()) {
                user = udb.getUserById(rs.getInt(2));
                book = bdb.getBookByIsbn(rs.getString(3));
                borrow = new Borrow(rs.getInt(1), book, user);
                borrows.add(borrow);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Borrow> getBorrows() {
        return borrows;
    }

    public List<Borrow> getBorrowsByUserId(int id) {
        List<Borrow> userBorrow = new ArrayList<>();
        for (Borrow borrow: borrows) {
            if (borrow.getUser().getId() == id) {
                userBorrow.add(borrow);
            }
        }
        return userBorrow;
    }

    public void addBorrow(User user, Book book) {
        int id = -1;
        try {
            PreparedStatement ps = cn.prepareStatement("INSERT INTO borrows(user_id, isbn)" +
                    "VALUES (?, ?)");
            ps.setInt(1, user.getId());
            ps.setString(2, book.getIsbn());
            ps.executeQuery();

            ps = cn.prepareStatement("SELECT currval('borrows_id_seq'::regclass)");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                id = rs.getInt(1);
            }
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        borrows.add(new Borrow(id, book, user));
    }

    public void deleteBorrow(int id) {
        borrows.removeIf(b -> b.getId() == id);
        try {
            PreparedStatement ps = cn.prepareStatement("DELETE FROM borrows" +
                    "WHERE id=?");
            ps.setInt(1, id);
            ps.executeQuery();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
