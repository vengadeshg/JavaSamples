<%-- 
    Document   : checkLogin
    Created on : 15/04/2013, 08:29:55 PM
    Author     : diego
--%>

<%@page import="database.ConnectionException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="connection" class="database.MysqlWizard"/>
<%@page session="true"%>
<%
    String user, password, realName ="", email = "";
    boolean isAdmin = false;
    int registers = 0;
    int idUser = -1;
    user = request.getParameter("userName");
    password = request.getParameter("password");
    
    if (!user.equals("") &&  !password.equals("")) {
        try {
            ResultSet rs = connection.query("select * from user where userName = '" + user + "' and password = aes_encrypt('" + password + "','1q2w3e4r')");
            if (rs != null){
                rs.last();
                registers = rs.getRow();
                idUser = rs.getInt("idUser");
                realName = rs.getString("realName");
                email = rs.getString("email");
                isAdmin = rs.getBoolean("isAdmin");
            }
            connection.closeResultSet(rs);
            connection.disconnect();
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + " " + e.getMessage());
        %>
        <jsp:forward page="login.jsp">
            <jsp:param name="error" value="Usuario y/o contraseña incorrectos.<br>Vuelve a intentar"/>
        </jsp:forward>
        <%} catch (ConnectionException e) {%>
        <jsp:forward page="login.jsp">
            <jsp:param name="error" value="El servicio no está disponible actualmente.<br>Sentimos las molestias."/>
        </jsp:forward>
        <%}
        
        if (registers > 0) {
            HttpSession newSession = request.getSession();
            newSession.setAttribute("userName", user);
            newSession.setAttribute("realName", realName);
            newSession.setAttribute("email", email);
            newSession.setAttribute("idUser", new Integer(idUser));
            newSession.setAttribute("isAdmin", new Boolean(isAdmin));
            %>
            <jsp:forward page="user.jsp"/>
            <%
        } else {%>
        <jsp:forward page="login.jsp">
            <jsp:param name="error" value="Usuario y/o contraseña incorrectos.<br>Vuelve a intentar"/>
        </jsp:forward>
        <%}
    } else {%>
    <jsp:forward page="login.jsp">
        <jsp:param name="error" value="Debes escribir un nombre y una contraseña.<br>Intentalo de nuevo"/>
    </jsp:forward>
    <%}
%>