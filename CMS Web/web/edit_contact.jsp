<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.example.Contact" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Contact</title>
</head>
<body>
    <h1>Edit Contact</h1>
    <%
        Contact contact = (Contact) request.getAttribute("contact");
        if (contact != null) {
    %>
        <form action="ContactServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= contact.getId() %>">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%= contact.getName() %>" required>
            <br>
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="<%= contact.getAddress() %>" required>
            <br>
            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" value="<%= contact.getPhone() %>" required>
            <br>
            <input type="submit" value="Update Contact">
        </form>
    <%
        } else {
    %>
        <p>No contact found.</p>
    <%
        }
    %>
    <br>
    <a href="ContactServlet">Back to Contacts List</a>
</body>
</html>
