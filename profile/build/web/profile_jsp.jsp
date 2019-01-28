<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Save Page</title>
    </head>
    <body>
        <h1> Welcome <%=request.getParameter("Name")%></h1>

        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/test", "root", "root");

                String query = "insert into `test`.`profile_details` values (?,?,?,?,?,?,?)";
                PreparedStatement pstmt = con.prepareCall(query);
                pstmt.setString(1, request.getParameter("Name"));
                pstmt.setString(2, request.getParameter("Gender"));
                pstmt.setString(3, request.getParameter("Dob"));
                pstmt.setString(4, request.getParameter("Mobile"));
                pstmt.setString(5, request.getParameter("Email"));
                pstmt.setString(6, request.getParameter("Street")+','+request.getParameter("Area")+','+request.getParameter("City")+','+request.getParameter("Pin")+','+request.getParameter("State"));
                
                if(request.getParameter("Qualification").equals("pg"))
                {
                     pstmt.setString(7, "pg,ug");
                }
                else if(request.getParameter("Qualification").equals("ug"))
                {
                     pstmt.setString(7,"ug,others");
                }
                else
                {
                     pstmt.setString(7,"others");
                }
                int insCount = 0;
                insCount = pstmt.executeUpdate();
                if (insCount > 0) {
                    System.out.println("One Record Inserted Successfully!!!");
                    out.println("One Record Inserted Successfully!!!"+" "+request.getParameter("Qualification"));
                    
                } else {
                    System.out.println("Unable to Insert data. Pls Check!!!");
                    out.println("Unable to Insert data. Pls Check!!!");
                }

                con.close();
            } catch (Exception e) {
                System.out.println(e);
                out.println(e.getMessage());
            }

        %>
    </body>
</html>
