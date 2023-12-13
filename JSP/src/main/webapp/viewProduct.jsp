<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // JDBC variables
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        // Establish a database connection
        String jdbcUrl = "jdbc:mariadb://mariadb.vamk.fi/e2102970_JSP"; // Update the database name
        String dbUser = "e2102970"; // Update your database username
        String dbPassword = "UMTwybd2hWn"; // Update your database password

        // Load the JDBC driver
        Class.forName("org.mariadb.jdbc.Driver");

        // Prepare and execute the SQL query
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // SQL query to retrieve all products
        String sql = "SELECT * FROM products"; // Update the table name
        st = conn.createStatement();
        rs = st.executeQuery(sql);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Products</title>
</head>
<body>
    <h2>Product List</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
			<th>Price</th>
            
            
        </tr>
        <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getFloat("price") %></td>
            </tr>
        <% } %>
    </table>
    <br>
    <a href="addProduct.html">Add Product</a>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close the ResultSet
        try {
            if (rs != null) rs.close();
            if (st != null) st.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            // Handle exceptions and print stack trace
            e.printStackTrace();
        }
    }
%>
