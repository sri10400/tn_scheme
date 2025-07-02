package org.scheme;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/FilterServlet")
public class FilterServlet extends HttpServlet {

	 public static class Scheme {
	        private int id;
		 	private String name;
	        private String benefits;
	        private String category;
	        private String official_link;

	        public Scheme(int id,String name, String benefits,String category, String official_link) {
	        	this.id=id;
	            this.name = name;
	            this.benefits = benefits;
	            this.official_link = official_link;
	        }
	        public int getId() {
	        	return id;
	        }
	        public String getName() {
	            return name;
	        }

	        public String getBenefits() {
	            return benefits;
	        }
	        public String getCategory() {
	        	return category;
	        }
	        public String getOfficialLink() {
	            return official_link;
	        }
	    
	 }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String gender = request.getParameter("gender");
        int age = Integer.parseInt(request.getParameter("age"));
        String occupation = request.getParameter("occupation");
        int income = Integer.parseInt(request.getParameter("income"));
        boolean isDisabled = request.getParameter("disability").equalsIgnoreCase("yes");
        boolean isTribal = request.getParameter("tribal").equalsIgnoreCase("yes");
        String caste = request.getParameter("caste");
        String marital = request.getParameter("marital");
        String education = request.getParameter("education");

        List<Scheme> matchedSchemes = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/tn_schemes", "root", "rocky304");

            String query = "SELECT * FROM schemes WHERE " +
                "(gender = ? OR gender = 'any') AND ? BETWEEN age_min AND age_max AND " +
                "(occupation = ? OR occupation = 'any') AND ? <= income_limit AND " +
                "(disability_required = FALSE OR disability_required = ?) AND " +
                "(tribal_required = FALSE OR tribal_required = ?) AND " +
                "(caste_category = 'any' OR caste_category = ?) AND " +
                "(marital_status = 'any' OR marital_status = ?) AND " +
                "(education_level = 'any' OR education_level = ?)";

            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, gender);
            stmt.setInt(2, age);
            stmt.setString(3, occupation);
            stmt.setInt(4, income);
            stmt.setBoolean(5, isDisabled);
            stmt.setBoolean(6, isTribal);
            stmt.setString(7, caste);
            stmt.setString(8, marital);
            stmt.setString(9, education);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Scheme s = new Scheme(
                	rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("benefits"),
                    rs.getString("category"),
                    rs.getString("official_link")
                );
                matchedSchemes.add(s);
            }

            conn.close();
        } catch (Exception e) {
            throw new ServletException("DB Error", e);
        }

        request.setAttribute("schemes", matchedSchemes);
        RequestDispatcher rd = request.getRequestDispatcher("result.jsp");
        rd.forward(request, response);
    }
}
