<%-- 
    Document   : write
    Created on : 16/04/2013, 02:22:43 AM
    Author     : diego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" href = "./style.css" type = "text/css" >
        <title>Nuevo Mensaje</title>
    </head>
    <body>
        <h1>Nuevo</h1>
        <%
            if (request.getParameter("error") != null) {
                out.println("<div style=\"width: 500px; border: 2px solid red\">");
                out.println("<p style=\"margin: 0; padding: 10px\">Error: " + request.getParameter("error") + "</p>");
                out.println("</div>");
            }
        %>
        <% if (request.getSession().getAttribute("userName") != null) {%>
        
        <div class="menu">
            <ul class ="menu">
                <%
                Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
                if (isAdmin.booleanValue()) {%>
                    <li><a class="menu" href="admin.jsp">Panel Administrativo</a></li>
                <%}%>
                <li><a class="menu" href="intray.jsp" >Bandeja de Entrada</a></li>
                <li><a class="menu" href="write.jsp">Redactar nuevo mensaje</a></li>
                <li><a class="menu" href="checkLogout.jsp">Cerrar sesión</a></li>
            </ul>
        </div>
        <form action="checksubmit.jsp" method="post">
            <table>
                <tr>
                    <td>Destinatario: </td>
                    <td><input type="text" name="userNameTo" <%out.println((request.getParameter("userNameTo") != null)? "value=\"" + request.getParameter("userNameTo") +"\"":"");%></td>
                </tr>
                <tr>
                    <td>Asunto: </td>
                    <td><input type="text" name="subject" <%out.println((request.getParameter("subject") != null)? "value=\"" + request.getParameter("subject") +"\"":"");%>></td>
                </tr>
                <tr>
                    <td>Mensaje: </td>
                    <%System.out.println(request.getParameter("message"));%>
                    <td><textarea name="message" cols="100" rows="25"><%out.println((request.getParameter("message") != null)? request.getParameter("message") : "");%></textarea></td>
                </tr>
            </table>
            <input type="submit" value="Enviar">
        </form>
        <%}else {%>
            <jsp:forward page="login.jsp">
                <jsp:param name="error" value="No ha iniciado sesión.<br> Acceda aquí:"/>
            </jsp:forward>
        <%
        }
        %>
    </body>
</html>
