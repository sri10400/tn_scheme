package org.scheme;
import org.scheme.FilterServlet.Scheme;


import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;


@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String cleanedQuery = query.replaceAll("\\s+", "").toLowerCase();
        List<Scheme> searchResults = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tn_schemes", "root", "rocky304");

            String sql = "SELECT * FROM schemes WHERE LOWER(REPLACE(name, ' ', '')) LIKE ? OR LOWER(REPLACE(benefits, ' ', '')) LIKE ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + cleanedQuery + "%");
            ps.setString(2, "%" + cleanedQuery + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                searchResults.add(new Scheme(rs.getInt("id"), rs.getString("name"), rs.getString("benefits"), rs.getString("category"),rs.getString("official_link")));
            }

            request.setAttribute("schemes", searchResults);
            request.getRequestDispatcher("result.jsp").forward(request, response);


        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().println("Error in servlet: " + e.getMessage());
        }
    }
}
