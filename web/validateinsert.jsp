<%-- 
    Document   : validateinsert
    Created on : 17/04/2013, 01:56:28 AM
    Author     : diego
--%>

<%@page import="database.MysqlWizard"%>
<%if (request.getSession().getAttribute("userName") != null) {
    if ((Boolean)request.getSession().getAttribute("isAdmin")) {
        String userName, realName, email, password, isAdmin;
        userName = request.getParameter("newUserName");
        realName = request.getParameter("newRealName");
        password = request.getParameter("newPassword");
        email = request.getParameter("newEmail");
        isAdmin = request.getParameter("newIsAdmin");
        MysqlWizard mw = new MysqlWizard();
        if (!userName.equals("") && !realName.equals("") && !email.equals("") && !password.equals("")) {
            try{
            mw.connect();
            mw.update("insert into user(userName, realName, email, isAdmin, password)"
                    + " values ('" + userName + "','" + realName + "','" + email + "'," + 
                    ((isAdmin == null)?"false,":"true,") + "aes_encrypt('"+ password + "','1q2w3e4r')"  + ")");
            mw.disconnect();%>
            <jsp:forward page="insert.jsp">
                <jsp:param name="success" value="Usuario Agregado correctamente."/>
            </jsp:forward>
            <%
            } catch(Exception e) { e.printStackTrace();%>
        <jsp:forward page="insert.jsp">
            <jsp:param name="error" value="El nombre de usuario ya existe."/>
        </jsp:forward>
    <%
            }
        } else { %>
    <jsp:forward page="insert.jsp">
        <jsp:param name="error" value="Debe ingresar todos los campos."/>
    </jsp:forward>
    <%
            
        }
    } else {
        %>
    <jsp:forward page="admin.jsp">
        <jsp:param name="error" value="Usted no tiene permisos para ver ésta información"/>
    </jsp:forward>
<%
    }
} else {%>
    <jsp:forward page="login.jsp">
        <jsp:param name="error" value="No ha iniciado sesión.<br> Acceda aquí:"/>
    </jsp:forward>
<%
}
%>
