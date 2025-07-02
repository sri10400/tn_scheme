package org.scheme;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tn_schemes", "root", "rocky304");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
            	String name = rs.getString("username");
                HttpSession session = request.getSession();
                session.setAttribute("username", name);
                session.setAttribute("user", email);
                response.sendRedirect("CategoryLoaderServlet"); 
            } else {
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("<p style='color:red;text-align:center;'>Invalid credentials</p>");
                out.println("<a href='login.html'>Try Again</a>");
                out.println("</body></html>");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
