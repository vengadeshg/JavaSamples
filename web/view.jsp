<%-- 
    Document   : view
    Created on : 16/04/2013, 07:51:21 PM
    Author     : diego
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.MysqlWizard"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" href = "./style.css" type = "text/css" />
        <title>Leer correo</title>
    </head>
    <body>
        <% if (request.getSession().getAttribute("userName") != null) {%>
        <h1>Leer correo</h1>
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
        <%
        try {
            MysqlWizard mw = new MysqlWizard();
            ResultSet rs, rs2;
            mw.connect();
            rs = mw.query("select * from message where idMessage=" + request.getParameter("idMessage"));
            rs.first();
            rs2 = mw.query("select userName, realName from user where idUser = (select idFrom from message where idMessage = " + request.getParameter("idMessage") + ")");
            rs2.first();
            out.println("<div>");
            out.println("<h2>De: " + rs2.getString("realName") + " (" + rs2.getString("userName") + ")</h2>");
            out.println("<h3>Recibido: " + rs.getString("sentDate") + "</h3>");
            out.println("</div>");
            out.println("<div>");
            out.println("<p>" + rs.getString("message") + "</p>");
            out.println("</div>");
        } catch(Exception e) {
            out.println("<h2>El servicio no se encuentra disponible actualmente.</h2>");
            System.out.println("asdjfhaskdjfh" + e.getMessage());
            e.printStackTrace();
        }
        %>
        
        <%}else {%>
            <jsp:forward page="login.jsp">
                <jsp:param name="error" value="No ha iniciado sesión.<br> Acceda aquí:"/>
            </jsp:forward>
        <%
        }
        %>
    </body>
</html>
