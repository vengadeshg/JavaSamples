/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.*;

/**
 *
 * @author diego
 */
public class MysqlWizard {
    
    Connection connection;
    Statement statement;
    
    
    
    public boolean connect() {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance(); 
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/messages", "root", "root");
            if (connection.isClosed()) {
                return false;
            } else {
                return true;
            }
        } catch (Exception e) {
            return false;
        }
    }
    
    public ResultSet query(String query) throws Exception {
        if (connection == null) {
            if (!connect()) {
                throw new ConnectionException("Connection refused");
            }
        } else {
                if (connection.isClosed()) {
                    if (!connect()) {
                    throw new ConnectionException("Connection refused");
                }
            }
        }
        statement = connection.createStatement();
        ResultSet result = statement.executeQuery(query);
        return result;
    }
    
    public int update(String query) throws Exception {
        if (connection == null) {
            if (!connect()) {
                throw new ConnectionException("Connection refused");
            }
        } else {
                if (connection.isClosed()) {
                    if (!connect()) {
                    throw new ConnectionException("Connection refused");
                }
            }
        }
        statement = connection.createStatement();
        return statement.executeUpdate(query);
    }
    
    
    public boolean closeResultSet(ResultSet result) {
        try {
            result.close();
            if (statement != null) {
                statement.close();
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    public boolean disconnect(){
        try {
            connection.close();
            statement.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    /*Class usage example:
     *<%
            MysqlWizard mw = new MysqlWizard();
            mw.connect();
            ResultSet rs = mw.query("select * from user");
            rs.first();
            out.println(rs.getInt("id"));
        %>
     */
    
}
