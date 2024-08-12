<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Contact" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contacts List</title>
</head>
<body>
    <h1>Contacts List</h1>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Address</th>
                <th>Phone</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Contact> contacts = (List<Contact>) request.getAttribute("contacts");
                if (contacts == null || contacts.isEmpty()) {
            %>
                <tr>
                    <td colspan="5">No contacts found.</td>
                </tr>
            <%
                } else {
                    for (Contact contact : contacts) {
            %>
                <tr>
                    <td><%= contact.getId() %></td>
                    <td><%= contact.getName() %></td>
                    <td><%= contact.getAddress() %></td>
                    <td><%= contact.getPhone() %></td>
                    <td>
                        <form action="ContactServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="<%= contact.getId() %>">
                            <input type="submit" value="Edit">
                        </form>
                        <form action="ContactServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= contact.getId() %>">
                            <input type="submit" value="Delete">
                        </form>
                    </td>
                </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
    <br>
    <a href="dashboard.jsp">Back to Dashboard</a>
</body>
</html>
