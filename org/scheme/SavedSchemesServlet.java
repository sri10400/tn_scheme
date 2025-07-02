package org.scheme;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.scheme.FilterServlet.Scheme;


/**
 * Servlet implementation class SavedSchemesServlet
 */
@WebServlet("/SavedSchemesServlet")
public class SavedSchemesServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    String username = (String) session.getAttribute("username");

    if (username == null) {
      response.sendRedirect("login.html");
      return;
    }

    List<Scheme> savedSchemes = new ArrayList<>();

    try (Connection con = DbUtil.getConnection()) {
      PreparedStatement ps = con.prepareStatement(
        "SELECT s.* FROM schemes s JOIN saved_schemes ss ON s.id = ss.scheme_id WHERE ss.username = ?"
      );
      ps.setString(1, username);
      ResultSet rs = ps.executeQuery();

      while (rs.next()) {
        Scheme scheme = new Scheme(
          rs.getInt("id"),
          rs.getString("name"),
          rs.getString("benefits"),      // Make sure these match your DB columns
          rs.getString("category"),
          rs.getString("official_link")
        );
        savedSchemes.add(scheme);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    request.setAttribute("savedSchemes", savedSchemes);
    request.getRequestDispatcher("saved_schemes.jsp").forward(request, response);
  }
}
