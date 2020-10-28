package assignment8;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BorrowDB {
    private static BorrowDB borrowDB = new BorrowDB();
    private static Connection cn = LibraryDatabase.getInstance().getConnection();
    private static List<Borrow> borrows;

    private BorrowDB() {}

    public static BorrowDB getInstance() {
        borrows = new ArrayList<>();
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
    public List<Borrow> getBorrowsByIsbn(String isbn) {
        List<Borrow> userBorrow = new ArrayList<>();
        for (Borrow borrow: borrows) {
            if (borrow.getBook().getIsbn().equals(isbn)) {
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
            ps.executeUpdate();

            ps = cn.prepareStatement("UPDATE books SET count=? WHERE isbn=?");
            ps.setInt(1,book.getCount()-1);
            ps.setString(2, book.getIsbn());
            ps.executeUpdate();

            ps = cn.prepareStatement("SELECT currval('borrows_id_seq'::regclass)");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                id = rs.getInt(1);
            }
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        book.setCount(book.getCount()-1);
        borrows.add(new Borrow(id, book, user));
    }

    public void deleteBorrow(int id) {
        String isbn = "";
        int count = 0;
        for (Borrow b: borrows) {
            if (b.getId() == id) {
                isbn = b.book.getIsbn();
                count = b.book.getCount();
                borrows.remove(b);
                break;
            }
        }
        try {
            PreparedStatement ps = cn.prepareStatement("DELETE FROM borrows " +
                    "WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();

            ps = cn.prepareStatement("UPDATE books SET count=? WHERE isbn=?");
            ps.setInt(1, count+1);
            ps.setString(2, isbn);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
