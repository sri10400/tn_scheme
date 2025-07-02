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
 * Servlet implementation class SaveSchemeServlet
 */
@WebServlet("/SaveSchemeServlet")
public class SaveSchemeServlet extends HttpServlet {
	  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession(false);
	    String username = (String) session.getAttribute("username");
	    String schemeId = request.getParameter("schemeId");

	    if (username == null || schemeId == null) {
	      response.sendRedirect("login.html");
	      return;
	    }

	    try (Connection con = DbUtil.getConnection()) {
	      PreparedStatement ps = con.prepareStatement("INSERT INTO saved_schemes (username, scheme_id) VALUES (?, ?)");
	      ps.setString(1, username);
	      ps.setInt(2, Integer.parseInt(schemeId));
	      ps.executeUpdate();
	    } catch (Exception e) {
	      e.printStackTrace();
	    }

	    response.sendRedirect("SavedSchemesServlet"); // maybe scheme_results.jsp
	  }
	}