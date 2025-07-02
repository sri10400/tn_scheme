
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    String currentUser = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>TN_Scheme</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f5f5f5;
      overflow-x: hidden;
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #004d40;
      color: white;
      padding: 10px 20px;
    }
	.login-buttons {
		  display: flex;
		  gap: 10px;
		  margin-left: 15px;
		}
		
		.nav-btn {
		  background-color: #1e7e34;
		  color: white;
		  padding: 6px 14px;
		  border-radius: 6px;
		  text-decoration: none;
		  font-size: 0.9em;
		}
		
		.nav-btn:hover {
		  background-color: #155d27;
		}
			
    .brand {
      display: flex;
      align-items: center;
    }

    .brand img {
      height: 80px;
      margin-right: 10px;
    }

    .brand span {
      font-size: 1.5em;
      font-weight: bold;
    }

    .navbar .right {
      display: flex;
      align-items: center;
    }

    .search-box input {
      padding: 6px 10px;
      border-radius: 20px;
      border: none;
      outline: none;
    }

    .menu {
      position: relative;
      margin-left: 15px;
      cursor: pointer;
    }

    .menu-icon {
      font-size: 1.5em;
      background-color: #00796b;
      padding: 6px 12px;
      border-radius: 6px;
      color: white;
    }

    .dropdown {
      display: none;
      position: absolute;
      right: 0;
      top: 40px;
      background-color: white;
      color: black;
      box-shadow: 0 4px 10px rgba(0,0,0,0.2);
      border-radius: 6px;
      overflow: hidden;
      min-width: 200px;
      z-index: 10;
    }

    .dropdown a {
      padding: 10px 15px;
      display: block;
      text-decoration: none;
      color: #004d40;
      border-bottom: 1px solid #eee;
    }

    .dropdown a:hover {
      background-color: #f2f2f2;
    }

    .menu:hover .dropdown {
      display: block;
    }

    .hero {
      text-align: center;
      margin: 50px 20px;
    }

    .hero h1 {
      font-size: 2.5em;
      margin-bottom: 10px;
      color: #004d40;
    }

    .hero p {
      font-size: 1.1em;
      color: #004d40;
      background-color: #fff;
      border-radius:12px;
      padding:40px;
      text-align:left;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }

    .stats {
      display: flex;
      justify-content: center;
      gap: 30px;
      margin: 40px 20px;
      flex-wrap: wrap;
    }

    .stat{
      background-color: #e0f2f1;
      padding: 30px 20px;
      border-radius: 12px;
      text-align: center;
      width: 200px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }

    .stat h3 {
      font-size: 2em;
      color: #00695c;
      margin: 0;
    }
     .stat p {
      margin: 10px 0 0;
      color: #004d40;
      font-size: 1rem;
    }

    .categories {
      text-align: center;
      margin: 50px 20px;
    }

    .categories h2 {
      color: #004d40;
      margin-bottom: 20px;
    }

    .category-icons {
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      gap: 40px;
    }

    .icon-box {
      background-color: #fff;
      padding: 20px;
      border-radius: 12px;
      width: 130px;
      text-align: center;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      transition: transform 0.2s;
    }

    .icon-box:hover {
      transform: translateY(-5px);
    }

    .icon-box i {
      font-size: 2em;
      color: #00796b;
    }

    .icon-box p {
      margin-top: 10px;
      font-size: 1em;
      color: #004d40;
    }
    .get-started-button {
    background-color: #1e7e34;
    color: white;
    padding: 10px 20px;
    font-size: 1rem;
    text-decoration: none;
    border: none;
    border-radius: 6px;
    cursor: pointer;
	}
	
	.get-started-button:hover {
	    background-color: #155d27;
	}
	
	
	.hero-banner {
	  width: 100vw; 
	  height: 900px;
	  aspect-ratio: 3 / 1; 
	  background-image: url('assets/tn_scheme banner.png');
	  background-repeat: no-repeat;
	  background-size: contain;  
	  background-position: center center;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  box-sizing: border-box;
	  padding: 2rem 0;
	}
	
	
	
  </style>
</head>
<body>

  <div class="navbar">
    <div class="brand">
      <img src="assets/logo.PNG" alt="Logo"/>
      <span>TN_Schemes</span>
    </div>
    <div class="right">
      <div class="search-box">
        <form action="SearchServlet" method="get">
          <input type="text" name="query" placeholder="Search schemes..." />
          <button type="submit">Search</button>
        </form>
      </div>
	    <% 
		    String user = (String) session.getAttribute("username");
		    if (user != null) {
		  %>
		    <span style="color:white; margin-left:15px;">Welcome, <%= user %></span>
		  <% } %>
      <div class="login-buttons">
        <% if (currentUser == null) { %>
            <a href="register.html" class="nav-btn">Register</a>
            <a href="login.html" class="nav-btn">Login</a>
        <% } else { %>
            <a href="LogoutServlet" class="nav-btn">Logout</a>
            <a href="saved_schemes.jsp" class="nav-btn">Saved Schemes</a>
            
        <% } %>
      </div>

      <div class="menu">
        <div class="menu-icon">☰</div>
        <div class="dropdown">
          <a href="#hero">What Are We</a>
          <a href="#stats">What We Have<br><small>53+ schemes, 18 categories, 100+ users</small></a>
          <a href="#categories">Categories</a>
          <a href="form.html" class="get-started-button">Get Started</a>
        </div>
      </div>
    </div>
  </div>

  <div class="hero-banner"></div>

  <div class="hero" id="hero">
    <h1>Welcome to TN_Schemes</h1>
    <p>&#11088; Welcome to TN_Schemes_Web – a simple, user-friendly platform made to help you easily discover Tamil Nadu government schemes that actually apply to your life.<br>

&#11088; We know how confusing and time-consuming it can be to go through long government websites, trying to figure out what benefits you're eligible for. Whether you're a student looking for scholarships, a farmer in need of support, a woman entrepreneur chasing your dreams, or a senior citizen seeking assistance – there are so many schemes out there. But how do you know which ones are for you?<br>

&#11088; That's where we come in.<br>

&#11088; With TN_Schemes_Web, all you have to do is enter a few details about yourself, or browse by category – and we’ll take care of the rest. Our system matches you with relevant government schemes based on your profile, saving you hours of confusion and searching.<br>

&#11088; This project was built with one goal in mind: to make government benefits more accessible to the people who need them most. It’s designed to be clean, easy to use, and helpful – because we believe technology should make life simpler, not harder.<br>

&#11088; We’re just getting started, and we’re always working on adding more features and improving the experience.<br> 

&#11088; Thanks for dropping by – and we hope TN_Schemes_Web helps you find the support you deserve!</p>
  </div>

  <div class="stats" id="stats">
    <div class="stat"><h3 class="count" data-target="53">0</h3><p>Schemes</p></div>
    <div class="stat"><h3 class="count" data-target="18">0</h3><p>Categories</p></div>
    <div class="stat"><h3 class="count" data-target="100">0</h3><p>Users</p></div>
  </div>

  <script>
    const counters = document.querySelectorAll('.count');
    counters.forEach(counter => {
      const target = +counter.getAttribute('data-target');
      const speed = 200;
      const updateCount = () => {
        const current = +counter.innerText;
        const increment = Math.ceil(target / speed);
        if (current < target) {
          counter.innerText = current + increment;
          setTimeout(updateCount, 10);
        } else {
          counter.innerText = target;
        }
      };
      updateCount();
    });
  </script>

  <div class="categories" id="categories">
  <h2>Find Schemes Based on Categories</h2>


  <div class="category-icons">
    <%
      java.util.List<String> categories = (java.util.List<String>) request.getAttribute("categories");
      if (categories != null && !categories.isEmpty()) {
        for (String category : categories) {
          String icon = "fas fa-tag"; // default icon

          // Assign specific icons based on keywords
          String lower = category.toLowerCase();
          if (lower.contains("education")) icon = "fas fa-graduation-cap";
          else if (lower.contains("employment") || lower.contains("job")) icon = "fas fa-briefcase";
          else if (lower.contains("health") || lower.contains("hospital")) icon = "fas fa-heartbeat";
          else if (lower.contains("finance") || lower.contains("poverty")) icon = "fas fa-hand-holding-usd";
          else if (lower.contains("women")) icon = "fas fa-female";
          else if (lower.contains("agriculture") || lower.contains("farmer")) icon = "fas fa-tractor";
          else if (lower.contains("social") || lower.contains("welfare")) icon = "fas fa-users";
          else if (lower.contains("transport")) icon = "fas fa-bus";
          else if (lower.contains("energy") || lower.contains("electricity")) icon = "fas fa-bolt";
          else if (lower.contains("housing") || lower.contains("home")) icon = "fas fa-home";
          else if (lower.contains("food")) icon = "fas fa-utensils";
          else if (lower.contains("festival")) icon = "fas fa-gift";
          else if (lower.contains("sports")) icon = "fas fa-football-ball";
          else if (lower.contains("labor")) icon = "fas fa-hard-hat";
          else if (lower.contains("business")) icon = "fas fa-briefcase";
          else if (lower.contains("marriage")) icon = "fas fa-ring";
          else if (lower.contains("environment")) icon = "fas fa-leaf";
          else if (lower.contains("security")) icon = "fas fa-shield-alt";
    %>
      <div class="icon-box">
        <a href="CategoryServlet?category=<%= category %>">
          <i class="<%= icon %>"></i>
          <p><%= category %></p>
        </a>
      </div>
    <%
        }
      } else {
    %>
      <p>No categories found. Please check your database or servlet.</p>
    <%
      }
    %>
  </div>

  <br><br><br><br>
  <div>
    <button onclick="location.href='form.html'" class="get-started-button">Get Started</button>
  </div>
</div>
  
</body>
</html>
    