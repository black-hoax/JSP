<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<%!
//Initialize method for establishing database connection and preparing statement
	Connection conn;
	PreparedStatement ps;
	
	public void jspInit(){
		try{
			
			// Load the JDBC driver and establish a database connection
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://mariadb.vamk.fi:3306/e2102970_JSP","e2102970","UMTwybd2hWn");
			ps = conn.prepareStatement("INSERT INTO products (id,name, price) VALUES (?, ?, ?)");
			// SQL query to insert a new product
	       
		} catch(Exception e){
			e.printStackTrace();
		}
	} // Destroy method for closing resources when the JSP is no longer in use
	public void jspDestroy(){
		try{
			// Close PreparedStatement and Connection
			ps.close();
			conn.close();
		}catch (Exception e){
			e.printStackTrace();
		}
	}
%>

<%
try {
    // Extract data from request parameters
    String name = request.getParameter("name");
    int id = Integer.parseInt(request.getParameter("id"));
    float price = Float.parseFloat(request.getParameter("price"));
    // Set parameters for the prepared statement
    ps.setString(1, name);
    ps.setInt(2, id);
    ps.setFloat(3, price);
    // Execute the update (insert) query
    ps.executeUpdate();
} catch (NumberFormatException e) {
    // Handle the case where "id" is not a valid integer
    // You can redirect the user to an error page or display an error message
    e.printStackTrace(); // or log the exception
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Product Result</title>
</head>
<body>
	<h2>Product Added Successfully!</h2>
    <a href="addProduct.html">Add Another Product</a>
    <br>
    <a href="viewProduct.jsp">View Products</a>

</body>
</html>