<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.List"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="jakarta.servlet.ServletException"%>
<%@ page import="jakarta.servlet.annotation.WebServlet"%>
<%@ page import="jakarta.servlet.http.HttpServlet"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>

<%@ page import="db.Database"%>
<%@ page import="db.SQLQuery"%>

<%@ page import="utilities.HashedPassword"%>
<%@ page import="utilities.RandomString8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
  <jsp:include page="../../partials/head.jsp">
  	<jsp:param value="../../" name="initPath"/>
  </jsp:include>
</head>
<body>
	<% 
		String fiscalCode = request.getParameter("fiscalCode").toUpperCase();
		String name = request.getParameter("name");
		String surname = request.getParameter("surname");
		String city = request.getParameter("city");
		String birthdate = request.getParameter("birthdate");
		int gender = Integer.parseInt(request.getParameter("gender"));
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String category = request.getParameter("category");
	
		String vac_date = request.getParameter("vac_date");
		int dose_number = Integer.parseInt(request.getParameter("dose"));
		
		RandomString8 randomString = new RandomString8(8);
		String password = randomString.getRandomString().toUpperCase();
		HashedPassword hashPsw = new HashedPassword(password);
		String hashedPassword = hashPsw.getHashedPassword();
				
		String insertUser = "INSERT INTO Vac_User VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?); ";
		String insertBooking = "INSERT INTO Vaccination VALUES (UUID(), ?, null, null, ?, ?); ";
		String insertCredentials = "INSERT INTO User_Credentials VALUES(?, ?); ";
				
		List<Object> paramsUser = Arrays.asList(fiscalCode, name, surname, city, birthdate, gender, email, phone, category);
		List<Object> paramsBooking = Arrays.asList(fiscalCode, vac_date, dose_number);
		List<Object> paramsCredentials = Arrays.asList(fiscalCode, hashedPassword);
	
		SQLQuery query1 = new SQLQuery(insertUser, paramsUser);
		SQLQuery query2 = new SQLQuery(insertBooking, paramsBooking);
		SQLQuery query3 = new SQLQuery(insertCredentials, paramsCredentials);
	
		Database.execute(query1, query2, query3);
		
		// control if some error happen on db execution. DO ONLY ONE QUERY
	%>
	
  <jsp:include page="../../partials/header.jsp">
  	<jsp:param name="initPath" value="../../" />
  </jsp:include>
  
  <main id="main">

    <section id="appointment" class="appointment section-bg">
      <div class="container">

        <div class="section-title">
          <h2>Accesso utente</h2>
          <p>Benvenuto, <%= name + " " + surname + "!" %></p>
          <p>Questa sarà la tua password: <%= password %></p>
          <p>MEMORIZZALA e accedi</p>
        </div>

        <form action="http://localhost:8080/apsw_project/pages/user/userhome.jsp" method="post" role="form" class="php-email-form">
        
        	<input hidden="true" type="text" name="fiscalCode" id="fiscalCode" value=<%= fiscalCode %>>
        
          <div class="row justify-content-center">
            <div class="col-md-4 form-group mt-3 mt-md-0">
              <input type="password" class="form-control" name="password" id="password" placeholder="password">
              <div class="validate"></div>
            </div>
          </div>

          <div class="mb-3">
            <div class="loading">Loading</div>
            <div class="error-message"></div>
            <div class="sent-message">Your appointment request has been sent successfully. Thank you!</div>
          </div>
          <div class="text-center">
	          <button type="submit" id="send-cf">Invia</button>
	        </div>
        </form>

      </div>
    </section>

  </main>
  
  <jsp:include page="../../partials/footer.jsp">
  	<jsp:param value="../../" name="initPath"/>
  </jsp:include>

</body>
</html>