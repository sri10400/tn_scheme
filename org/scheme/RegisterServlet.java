package org.scheme;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tn_schemes", "root", "rocky304");

            // 1️⃣ Check if email already exists
            PreparedStatement checkUser = con.prepareStatement("SELECT * FROM users WHERE email = ?");
            checkUser.setString(1, email);
            ResultSet rs = checkUser.executeQuery();

            if (rs.next()) {
                // Email already exists
            	PrintWriter out = response.getWriter();
            	response.setContentType("text/html");
            	out.println("<!DOCTYPE html>");
            	out.println("<html><head><title>Already Registered</title>");
            	out.println("<style>");
            	out.println("body { font-family: 'Segoe UI', sans-serif; background-color: #f9f9f9; margin: 0; padding: 0; display: flex; align-items: center; justify-content: center; height: 100vh; }");
            	out.println(".message-box { background: white; padding: 40px 60px; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.2); text-align: center; }");
            	out.println(".message-box h2 { color: #d32f2f; margin-bottom: 10px; }");
            	out.println(".message-box p { color: #555; font-size: 1.1em; margin-bottom: 20px; }");
            	out.println(".message-box a { background-color: #1e7e34; color: white; padding: 10px 20px; border-radius: 6px; text-decoration: none; font-weight: bold; }");
            	out.println(".message-box a:hover { background-color: #155d27; }");
            	out.println("</style></head><body>");
            	out.println("<div class='message-box'>");
            	out.println("<h2>You're already registered!</h2>");
            	out.println("<p>The email <strong>" + email + "</strong> is already in our system.</p>");
            	out.println("<a href='login.html'>Go to Login</a>");
            	out.println("</div></body></html>");

            } else {
                // 2️⃣ Insert new user
                PreparedStatement insertUser = con.prepareStatement("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
                insertUser.setString(1, username);
                insertUser.setString(2, email);
                insertUser.setString(3, password);
                insertUser.executeUpdate();

                response.sendRedirect("login.html");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
