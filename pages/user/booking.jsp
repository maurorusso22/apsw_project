<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
		String fiscalCode = request.getParameter("fc");
	%>

  <jsp:include page="../../partials/header.jsp">
  	<jsp:param name="initPath" value="../../" />
  </jsp:include>
  
    <main id="main">

    <!-- ======= Appointment Section ======= -->
    <section id="appointment" class="appointment section-bg">
      <div class="container">

        <div class="section-title">
          <h2>Benvenuto</h2>
          <h3><%= fiscalCode %></h3>
          <p>Risulta che tu non abbia mai prenotato un vaccino. Inserisci i tuoi dati e procedi con la prenotazione.</p>
        </div>

<!--         <form action="http://localhost:8080/apsw_project/book" method="post" role="form" class="php-email-form"> -->
				<form action="http://localhost:8080/apsw_project/pages/user/firstaccess.jsp" method="post" role="form" class="php-email-form">
        
        	<input hidden="true" type="text" name="fiscalCode" id="fiscalCode" value=<%= fiscalCode %>>
        	<input hidden="true" type="text" name="dose" id="dose" value="1">
        
          <div class="row">
            <div class="col-md-4 form-group">
              <input type="text" name="name" class="form-control" id="name" placeholder="Nome" data-rule="minlen:2" data-msg="Please enter at least 2 chars">
              <div class="validate"></div>
            </div>
            <div class="col-md-4 form-group">
              <input type="text" name="surname" class="form-control" id="surname" placeholder="Cognome" data-rule="minlen:2" data-msg="Please enter at least 2 chars">
              <div class="validate"></div>
            </div>
            <div class="col-md-4 form-group">
              <input type="date" name="birthdate" class="form-control datepicker" id="birthdate" placeholder="Data di nascita" data-rule="minlen:4" data-msg="Please enter at least 4 chars">
              <div class="validate"></div>
            </div>
          </div>

          <div class="row">
            <div class="col-md-4 form-group mt-3">
              <select name="gender" id="gender" class="form-select">
                <option value="1">Uomo</option>
                <option value="2">Donna</option>
                <option value="3">Altro</option>
              </select>
              <div class="validate"></div>
            </div>
            <div class="col-md-4 form-group mt-3">
              <input type="text" name="city" class="form-control" id="city" placeholder="Città di nascita" data-rule="minlen:2" data-msg="Please enter at least 2 chars">
              <div class="validate"></div>
            </div>
            <div class="col-md-4 form-group mt-3">
              <select name="category" id="category" class="form-select">
                <option value="none">No categoria speciale</option>
                <option value="fragile">Soggetto fragile</option>
                <option value="over65">Over 65</option>
              </select>
              <div class="validate"></div>
            </div>
          </div>

          <div class="row">
            <div class="col-md-4 form-group mt-3">
              <input type="email" class="form-control" name="email" id="email" placeholder="Email" data-rule="email" data-msg="Please enter a valid email">
              <div class="validate"></div>
            </div>
            <div class="col-md-4 form-group mt-3">
              <input type="tel" class="form-control" name="phone" id="phone" placeholder="Telefono" data-rule="minlen:4" data-msg="Please enter at least 4 chars">
              <div class="validate"></div>
            </div>
            <div class="col-md-4 form-group mt-3">
              <input type="date" name="vac_date" class="form-control datepicker" id="vac_date" placeholder="Data prenotazione" data-rule="minlen:4" data-msg="Please enter at least 4 chars">
              <div class="validate"></div>
            </div>
          </div>

          <div class="mb-3">
            <div class="loading">Loading</div>
            <div class="error-message"></div>
            <div class="sent-message">Your appointment request has been sent successfully. Thank you!</div>
          </div>
          
          <div class="text-center"><button type="submit">Prenota</button></div>
        </form>

      </div>
    </section><!-- End Appointment Section -->

  </main><!-- End #main -->
  
  <jsp:include page="../../partials/footer.jsp">
  	<jsp:param value="../../" name="initPath"/>
  </jsp:include>

</body>
</html>