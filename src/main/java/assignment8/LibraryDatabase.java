package assignment8;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;

public class LibraryDatabase {
    private static LibraryDatabase instance = new LibraryDatabase();

    public static LibraryDatabase getInstance() {
        return instance;
    }

    private LibraryDatabase() {}

    public Connection getConnection()
    {
        Context initialContext;
        Connection connection = null;
        try
        {
            initialContext = new InitialContext();
            Context envCtx = (Context)initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/library");
            connection = ds.getConnection();
        }
        catch (NamingException | SQLException e)
        {
            e.printStackTrace();
        }
        return connection;
    }

    /*public assignment8.LibraryDatabase create(assignment8.LibraryDatabase rodo ) {
        String sql = "INSERT INTO rODO ( task) VALUES ( ?)";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, rodo.getTask());
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rodo;
    }*/
}
