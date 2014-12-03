<%-- 
    Document   : insert
    Created on : 17/04/2013, 01:35:33 AM
    Author     : diego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" href = "./style.css" type = "text/css" />
        <title>Panel de Administración</title>
    </head>
    <body>
        <h1>Panel de Administración</h1>
         <%
            if (request.getParameter("error") != null) {
                out.println("<div style=\"width: 500px; border: 2px solid red\">");
                out.println("<p style=\"margin: 0; padding: 10px\">Error: " + request.getParameter("error") + "</p>");
                out.println("</div>");
            }
        %>
        
        <%
            if (request.getParameter("success") != null) {
                out.println("<div style=\"width: 500px; border: 2px solid blue\">");
                out.println("<p style=\"margin: 0; padding: 10px\">" + request.getParameter("success") + "</p>");
                out.println("</div>");
            }
        %>
        <%if (request.getSession().getAttribute("userName") != null) {%>
        <div class="menu">
            <ul class="menu">
                <%
                Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
                if (isAdmin.booleanValue()) {%>
                    <li><a class="menu" href="admin.jsp">Panel Administrativo</a></li>
                <%}%>
                <li><a class="menu" href="intray.jsp" >Bandeja de Entrada</a></li>
                <li><a class ="menu" href="write.jsp">Redactar nuevo mensaje</a></li>
                <li><a class="menu" href="checkLogout.jsp">Cerrar sesión</a></li>
            </ul>
        </div>
        <% if (isAdmin.booleanValue()) {%>
        <div class="menu">
            <ul class="menu">
                <li><a class="menu" href="insert.jsp" >Altas</a></li>
                <li><a class ="menu" href="delete.jsp">Bajas</a></li>
                <li><a class="menu" href="update.jsp">Cambios</a></li>
            </ul>
        </div>
        <form name="data" method="post" action="validateinsert.jsp">
            <div>
                <table>
                    <tr>
                        <td>Nombre De Usuario: </td>
                        <td><input type="text" name="newUserName"></td>
                    </tr>
                    <tr>
                        <td>Nombre Real: </td>
                        <td><input type="text" name="newRealName"></td>
                    </tr>
                    <tr>
                        <td>Contraseña: </td>
                        <td><input type="password" name="newPassword"></td>
                    </tr>
                    <tr>
                        <td>Email: </td>
                        <td><input type="text" name="newEmail"></td>
                    </tr>
                    <tr>
                        <td>Permisos Administrativos: </td>
                        <td><input type="checkbox" name="newIsAdmin" value="666"></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Insertar"></td>
                    </tr>
                </table>
                
            </div>
        </form>
        <%} else {
            out.println("Usted no tiene permisos para ver ésta información.");
        }%>
        <%} else {%>
            <jsp:forward page="login.jsp">
                <jsp:param name="error" value="No ha iniciado sesión.<br> Acceda aquí:"/>
            </jsp:forward>
        <%
        }
        %>
    </body>
</html>

