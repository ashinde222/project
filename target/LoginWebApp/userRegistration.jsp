<%@ page import="java.sql.*" %>
<%
String userName = request.getParameter("userName");
String password = request.getParameter("password");
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
String email = request.getParameter("email");

Connection con = null;
PreparedStatement ps = null;

try {
    // Load MySQL Driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Read from environment variables (set via Docker)
    String dbHost = System.getenv("DB_HOST");
    String dbName = System.getenv("DB_NAME");
    String dbUser = System.getenv("DB_USER");
    String dbPass = System.getenv("DB_PASS");

    // Fallback (optional, for safety)
    if (dbHost == null) dbHost = "mysql";
    if (dbName == null) dbName = "mydb";
    if (dbUser == null) dbUser = "appuser";
    if (dbPass == null) dbPass = "apppass";

    String url = "jdbc:mysql://" + dbHost + ":3306/" + dbName;

    // Create connection
    con = DriverManager.getConnection(url, dbUser, dbPass);

    // Use PreparedStatement (prevents SQL injection)
    String query = "INSERT INTO USER(first_name, last_name, email, username, password, regdate) VALUES (?, ?, ?, ?, ?, CURDATE())";

    ps = con.prepareStatement(query);
    ps.setString(1, firstName);
    ps.setString(2, lastName);
    ps.setString(3, email);
    ps.setString(4, userName);
    ps.setString(5, password);

    int i = ps.executeUpdate();

    if (i > 0) {
        response.sendRedirect("welcome.jsp");
    } else {
        response.sendRedirect("index.jsp");
    }

} catch (Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    try { if (ps != null) ps.close(); } catch (Exception e) {}
    try { if (con != null) con.close(); } catch (Exception e) {}
}
%>
