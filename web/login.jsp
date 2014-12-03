<%-- 
    Document   : login
    Created on : 15/04/2013, 08:39:03 PM
    Author     : diego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" href = "./style.css" type = "text/css" />
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Login</h1>
        
        <%
            if (request.getParameter("error") != null) {
                out.println("<div style=\"width: 500px; border: 2px solid red\">");
                out.println("<p style=\"margin: 0; padding: 10px\">Error al accesar: " + request.getParameter("error") + "</p>");
                out.println("</div>");
            }
        %>
        
        <form action="checkLogin.jsp" method="post">
            <table>
                <tr>
                    <td>Nombre De Usuario: </td>
                    <td><input type="text" name="userName"></td>
                </tr>
                <tr>
                    <td>Contraseña: </td>
                    <td><input type="password" name="password"></td>
                </tr>
            </table>
            <input type="submit" value="Login">
        </form>
    </body>
</html>
