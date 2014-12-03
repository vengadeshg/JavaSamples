<%-- 
    Document   : checksubmit
    Created on : 16/04/2013, 10:38:36 PM
    Author     : diego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.MysqlWizard"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" href = "./style.css" type = "text/css" />
        <script>
        function sendError(){
            document.error.submit();
        }
        </script>
        <title>Nuevo Mensaje</title>
    </head>
    <body>
        <h1>Nuevo Mensaje</h1>
        <%if (request.getSession().getAttribute("userName") != null) {
            String message = request.getParameter("message");
            String subject = request.getParameter("subject");
            String userTo = request.getParameter("userNameTo");
            int idUser;
            MysqlWizard mw = new MysqlWizard();
            ResultSet rs;
            try {
                mw.connect();
                rs = mw.query("select idUser from user where userName='" + userTo + "'");
                rs.first();
                idUser = rs.getInt("idUser");
                
                mw.update("insert into message (message, subject, idTo, idFrom) values"
                        + " ('" + message + "','" + subject + "'," + idUser + "," +
                        request.getSession().getAttribute("idUser")  + ")");
                mw.closeResultSet(rs);
                mw.disconnect();
                out.print("<h2>El mensaje se ha enviado con éxito.</h2>");
                out.println("<a href=\"user.jsp\">Regresar a la página principal de usuario</a>");
            } catch (SQLException e){%>
            <h1>Se ha producido un error.</h1>
            <a onclick="sendError();">Regresar</a>
            <form action="write.jsp" name="error" method="post">
                <input type="hidden" name="message" value=<%out.println("\"" + message + "\"");%>>
                <input type="hidden" name="subject" value=<%out.println("\"" + subject + "\"");%>>
                <input type="hidden" name="userNameTo" value=<%out.println("\"" + userTo + "\"");%>>
                <input type="hidden" name="error" value=<%out.println("\"El usuario " + userTo + " no existe.\"");%>>
            </form>
            <%}
        } else {%>
            <jsp:forward page="login.jsp">
                <jsp:param name="error" value="No ha iniciado sesión.<br> Acceda aquí:"/>
            </jsp:forward>
            <%
            }
            %>

    </body>
</html>
