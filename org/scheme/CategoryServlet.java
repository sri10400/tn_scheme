package org.scheme;

import org.scheme.FilterServlet.Scheme;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;


@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        List<Scheme> matchedCategorySchemes = new ArrayList<>();

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tn_schemes", "root", "rocky304");
            String sql = "SELECT * FROM schemes WHERE category = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                matchedCategorySchemes.add(new Scheme(rs.getInt("id"), rs.getString("name"), rs.getString("benefits"), rs.getString("category"),rs.getString("official_link")));
            }
            String pageTitle = "Schemes under '" + category + "' Category";
       
            request.setAttribute("schemes", matchedCategorySchemes);
            request.setAttribute("pageTitle", pageTitle);
            request.getRequestDispatcher("result.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().println("Error in servlet: " + e.getMessage());
        }
    }
}