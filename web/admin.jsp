<%-- 
    Document   : admin
    Created on : 16/04/2013, 11:20:17 PM
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
