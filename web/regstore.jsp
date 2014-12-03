<%@ page import ="java.sql.*" %>
<%
    String user = request.getParameter("username");    
    String fname = request.getParameter("firstname");
    String lname = request.getParameter("lastname");
    String email = request.getParameter("email");
    Class.forName("org.postgresql.Driver");
    Connection con = DriverManager.getConnection("jdbc:postgresql://ec2-54-204-39-187.compute-1.amazonaws.com:5432/dbsmk5o5q2po2t?ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory",
		    	            "vsaruomebqzqeg", "ko7q_QOXnPQyMK0GK-cw6I50cH");
    Statement st = con.createStatement();
    int i=0;
    try
    {
    i = st.executeUpdate("INSERT INTO salesforce.PATIENTREG__c(Name,FirstName__c,LastName__c,Email__c) values ('" + user + "','" + fname + "','" + lname + "','" + email + "')");
    if (i > 0)
    {        
        out.print("Patient Details are registered successfully! "+"<a href='register.jsp'>Go to Register Page</a>");
    }
    else
    {       
         out.print("Patient Details are not registered successfully! "+"<a href='register.jsp'>Go to Register Page</a>");
    }    
    }
    catch(Exception e)
    {
        out.print("Patient Details are not registered successfully! "+"<a href='register.jsp'>Go to Register Page</a>");
    }
    st.close();
    con.close();
    %>
