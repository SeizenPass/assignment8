package assignment8;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDB {
    private static BookDB bookDB = new BookDB();
    private static Connection cn = LibraryDatabase.getInstance().getConnection();
    private static List<Book> books = new ArrayList<>();

    private BookDB() {}

    public static BookDB getInstance() {
        init();
        return bookDB;
    }

    private static void init() {
        try {
            Statement s = cn.createStatement();
            ResultSet rs = s.executeQuery("SELECT * FROM books");
            Book book;
            String isbn;
            String title;
            String description;
            int count;
            while(rs.next()) {
                isbn = rs.getString(1);
                title = rs.getString(2);
                description = rs.getString(3);
                count = rs.getInt(4);
                book = new Book(isbn, title, description, count);
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Book> getBooks() {
        return books;
    }

    public Book getBookByIsbn(String isbn) {
        for (Book b : books) {
            if (b.getIsbn().equals(isbn)) {
                return b;
            }
        }
        return new Book("-1", "Unknown", "", 0);
    }

    public void addBook(Book book) {
        books.add(book);
        try {
            PreparedStatement ps = cn.prepareStatement("INSERT INTO books(isbn, title, description, count)" +
                    "VALUES (?, ?, ?, ?)");
            ps.setString(1, book.getIsbn());
            ps.setString(2, book.getTitle());
            ps.setString(3, book.getDescription());
            ps.setInt(4, book.getCount());
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void modifyBook(Book book) {
        for (Book b : books) {
            if (b.getIsbn().equals(book.getIsbn())) {
                b.setTitle(book.getTitle());
                b.setDescription(book.getDescription());
                b.setCount(book.getCount());
                break;
            }
        }
        try {
            PreparedStatement ps = cn.prepareStatement("UPDATE books " +
                    "SET title=?, description=?, count=?" +
                    "WHERE isbn=?");
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getDescription());
            ps.setInt(3, book.getCount());
            ps.setString(4, book.getIsbn());
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteBook(String isbn) {
        books.removeIf(b -> b.getIsbn().equals(isbn));
        try {
            PreparedStatement ps = cn.prepareStatement("DELETE FROM books" +
                    "WHERE isbn=?");
            ps.setString(1, isbn);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
