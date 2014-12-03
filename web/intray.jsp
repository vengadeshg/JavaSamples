<%-- 
    Document   : intray
    Created on : 16/04/2013, 02:22:14 AM
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
        <title>Bandeja de entrada</title>
    </head>
    <body>
        <% if (request.getSession().getAttribute("userName") != null) {%>
        <h1>Bandeja de entrada</h1>
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
        <table>
            <tr>
                <td>Remitente:</td>
                <td>Asunto:</td>
                <td>Enviado:</td>
            </tr>
            <%
            int i = 0;
            MysqlWizard mw = new MysqlWizard();
            if (mw.connect()) {
                try {
                int beginIn;
                if (request.getParameter("beginIn") != null) {
                    beginIn = Integer.parseInt(request.getParameter("beginIn"));
                } else {
                    beginIn = 0;
                }
                ResultSet rs = mw.query("select * from message m where m.idTo =(select idUser from user u where u.userName = '" +(String) request.getSession().getAttribute("userName") + "') limit " + beginIn + "," + (beginIn + 50));
                ResultSet rs2 = mw.query("select count(*) from message m where m.idTo =(select idUser from user u where u.userName = '" +(String) request.getSession().getAttribute("userName") + "')");
                rs.first();
                rs2.first();
                i = rs2.getInt(1);
                mw.closeResultSet(rs2);
                System.out.println("registros: " + i);
                do {
                    //From:
                    out.println("<tr onclick=\"view(" + rs.getInt("idMessage") + ")\">");
                        out.println("<td>");
                        rs2 = mw.query("select realName from user u where idUser = " + rs.getInt("idFrom"));
                        rs2.first();
                        out.print(rs2.getString("realName"));
                        out.print("</td>");
                    mw.closeResultSet(rs2);
                    //subjec:
                        out.println("<td>");
                        out.print(rs.getString("subject"));
                        out.print("</td>");
                    //time:
                        out.println("<td>");
                        out.print(rs.getString("sentDate"));
                        out.print("</td>");
                    out.println("</tr>");
                    out.println("<form name=\"f" + rs.getString("idMessage") +"\" action=\"view.jsp\" method=\"post\">");
                    out.println("<input type=\"hidden\" value=\"" + rs.getString("idMessage") + "\" name=\"idMessage\">");
                    out.println("</form>");
                } while (rs.next());
                out.println("</table>");
                int first, last, range;
                rs.first();
                first = rs.getInt("idMessage");
                rs.last();
                last = rs.getInt("idMessage");
                range = last - first;
                out.println("<script>");
                out.println("function view(id) {");
                for (int x = first; x <= last; x++) {
                    out.println("if (id == " + x +") {");
                    out.println("document.f" + x + ".submit();");
                    out.println("}");
                }
                out.println("}");
                out.println("</script>");
                mw.closeResultSet(rs);
                mw.disconnect();
                %>

                <div name="navigation" >
                    <form method="post" name="next" action="intray.jsp">
                        <input type="hidden" value="<%out.print(beginIn + 50);%>" name="beginIn">
                        <input type="submit" value="Adelante" <%out.print(((beginIn + 50) > i)? "disabled": "");%>>
                    </form>
                    <form method="post" name="previous" action="intray.jsp">
                        <input type="hidden" value="<%out.print(beginIn - 50);%>" name="beginIn" >
                        <input type="submit" value="Atrás" <%out.print((beginIn <= 0)? "disabled": "");%>>
                    </form>
                </div>
                <%
                } catch (Exception e){
                    System.out.println("error en i = "+ i + " :" + e.getMessage());
                    e.printStackTrace();
                }
            }
            }else {%>
            <jsp:forward page="login.jsp">
                <jsp:param name="error" value="No ha iniciado sesión.<br> Acceda aquí:"/>
            </jsp:forward>
            <%
            }
            %>
        </table>
    </body>
</html>
