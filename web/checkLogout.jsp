<%-- 
    Document   : checkLogout
    Created on : 16/04/2013, 02:15:30 AM
    Author     : diego
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
HttpSession endsession = request.getSession();
endsession.invalidate();
%>
<jsp:forward page="index.jsp"/>
