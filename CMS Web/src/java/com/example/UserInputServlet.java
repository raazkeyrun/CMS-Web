package com.example;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UserInputServlet", urlPatterns = {"/UserInputServlet"})
public class UserInputServlet extends HttpServlet {

    // JDBC URL, username, and password of MySQL server
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/sms";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve user input
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Database operations
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean isValidUser = false;

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // SQL query to check if username and password exist in the database
            String sql = "SELECT * FROM pass WHERE username = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            // If the result set has a row, the user exists
            if (rs.next()) {
                isValidUser = true;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            throw new ServletException("Database access error", ex);
        } finally {
            // Close all resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
                throw new ServletException("Error in closing database resources", ex);
            }
        }

        // Check if the user is valid
        if (isValidUser) {
            // Forward the request to the result.jsp page
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        } else {
            // Redirect back to login page or show an error
            response.sendRedirect(request.getContextPath() + "/login.html");
        }
    }
}
