package org.scheme;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.Connection;


/**
 * Servlet implementation class UnsaveSchemeServlet
 */
@WebServlet("/UnsaveSchemeServlet")
public class UnsaveSchemeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        String schemeId = request.getParameter("schemeId");

        if (username != null && schemeId != null) {
            try (Connection con = DbUtil.getConnection()) {
                PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM saved_schemes WHERE username = ? AND scheme_id = ?"
                );
                ps.setString(1, username);
                ps.setInt(2, Integer.parseInt(schemeId));
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("saved_schemes.jsp");
    }
}