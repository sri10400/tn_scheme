<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="org.scheme.DbUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.html");
        return;
    }

    List<String[]> savedSchemes = new ArrayList<>();

    try (Connection con = DbUtil.getConnection()) {
    	PreparedStatement ps = con.prepareStatement(
    		    "SELECT s.id, s.name, s.benefits, s.official_link FROM schemes s JOIN saved_schemes ss ON s.id = ss.scheme_id WHERE ss.username = ?"
    		);
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            savedSchemes.add(new String[]{
                rs.getString("id"),
                rs.getString("name"),
                rs.getString("benefits"),
                rs.getString("official_link")
            });
        }
    } catch (Exception e) {
        out.println("<p>Error loading saved schemes: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Saved Schemes</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      padding: 30px;
      background: #f4f9f6;
      color: #333;
    }

    h2 {
      color: #007b5e;
      margin-bottom: 20px;
    }

    .scheme-card {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	  background-color: #fff;
	  border-left: 6px solid #007b5e;
	  padding: 20px;
	  margin-bottom: 20px;
	  border-radius: 10px;
	  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	  transition: transform 0.2s ease;
	}
	.scheme-info {
	  flex: 1;
	}
    

    .scheme-card:hover {
      transform: translateY(-3px);
    }

    .scheme-card h3 {
      margin: 0 0 10px;
      font-size: 1.5rem;
      color: #2c3e50;
    }

    .scheme-card p {
      margin: 6px 0;
    }

    .scheme-card a.button {
      background-color: #dc3545;
      color: white;
      padding: 6px 14px;
      border-radius: 6px;
      text-decoration: none;
      font-size: 0.9em;
      display: inline-block;
      margin-top: 10px;
    }

    .scheme-card a.button:hover {
      background-color: #b02a37;
    }
  </style>
</head>
<body>

<h2>Your Saved Schemes</h2>
<div style="margin-bottom: 20px;">
  <form action="CategoryLoaderServlet" method="get">
    <button type="submit" style="
      background-color: #007b5e;
      color: white;
      border: none;
      padding: 10px 16px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 1rem;">
      ⬅️ Back to Homepage
    </button>
  </form>
</div>

<%
    if (savedSchemes.isEmpty()) {
%>
    <p>No schemes saved yet.</p>
<%
    } else {
        for (String[] scheme : savedSchemes) {
%>
    <div class="scheme-card">
  <div class="scheme-info">
    <h3><%= scheme[1] %></h3>
    <p><%= scheme[2] %></p>
    <a href="<%= scheme[3] %>" target="_blank" style="color:#007bff; text-decoration:none; display:inline-block; margin-top:5px;">
      For More Details
    </a>
  </div>
  <div>
    <a href="UnsaveSchemeServlet?schemeId=<%= scheme[0] %>" class="button">Remove</a>
  </div>
</div>
    
<%
        }
    }
%>

</body>
</html>
