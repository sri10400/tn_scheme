<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, org.scheme.FilterServlet.Scheme" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Scheme Results</title>
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
      background-color: #fff;
      border-left: 6px solid #007b5e;
      padding: 20px;
      margin-bottom: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
      transition: transform 0.2s ease;
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

    .scheme-card a {
      color: #0056b3;
      text-decoration: none;
      font-weight: bold;
    }

    .scheme-card a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

  <h2><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "Matching Schemes" %></h2>
  

  <%
  try{
    List<Scheme> schemes = (List<Scheme>) request.getAttribute("schemes");
    if (schemes != null && !schemes.isEmpty()) {
      for (Scheme s : schemes) {
  %>
    <div class="scheme-card">
      <h3><%= s.getName() %></h3>

      <%
        // Check if the object has getDescription() and getCategory()
        try {
          String description = s.getClass().getMethod("getDescription") != null ? s.getBenefits() : null;
          String category = s.getClass().getMethod("getCategory") != null ? s.getCategory() : null;
      %>
        <% if (description != null) { %>
          <p><strong>Description:</strong> <%= description %></p>
        <% } %>
        <% if (category != null) { %>
          <p><strong>Category:</strong> <%= category %></p>
        <% } %>
      <%
        } catch (NoSuchMethodException e) {
      %>
        <p><strong>Benefits:</strong> <%= s.getBenefits() %></p>
        <p><a href="<%= s.getOfficialLink() %>" target="_blank">For More Details</a></p>
      <%
        }
      %>
       <!-- ✅ Add Save Button if user is logged in -->
  <% if (session.getAttribute("username") != null) { %>
    <form action="SaveSchemeServlet" method="get" style="margin-top: 10px;">
      <input type="hidden" name="schemeId" value="<%= s.getId() %>"/>
      <button type="submit" style="background-color:#1e7e34; color:white; border:none; padding:8px 12px; border-radius:6px; cursor:pointer;">
        Save Scheme
      </button>
    </form>
  <% } %>
      
    </div>
  <%
      }
    } else {
  %>
    <p>No schemes found for your input. Please try different criteria.</p>
  <%
    }
  }catch (Exception e) {
	    out.println("<p>Error: " + e.getMessage() + "</p>");
  }
  %>

</body>
</html>
