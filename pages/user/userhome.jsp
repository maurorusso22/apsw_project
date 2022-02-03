<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
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
<%@ page import="utilities.DateUtilities"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
  <jsp:include page="../../partials/head.jsp">
  	<jsp:param value="../../" name="initPath"/>
  </jsp:include>
  <style>
		button {
		  background: #1977cc;
		  border: 0;
		  padding: 10px 35px;
		  color: #fff;
		  transition: 0.4s;
		  border-radius: 50px;
		}
		button:hover {
		  background: #1c84e3;
		}
		#changeDate {
			margin-top: 16px;
		  background: #1c84e3;
		  border: 0;
		  padding: 10px 35px;
		  color: #fff;
		  transition: 0.4s;
		  border-radius: 50px;
		}
		#changeDate:hover {
		  background: #fff;
		  color: #000;
		}
	</style>
</head>
<body>

	<% 
	
		Boolean access;
		String fiscalCode = request.getParameter("fiscalCode").toUpperCase();
		String password = request.getParameter("password");
		
		String selectCredentials = "SELECT * FROM User_Credentials WHERE fiscal_code = ? ;";
		String selectUserInfo = "SELECT * FROM Vac_User WHERE fiscal_code = ? ; ";
		String selectVacInfo = "SELECT * FROM Vaccination WHERE id_user = ? ; ";
				
		List<Object> params = Arrays.asList(fiscalCode);
	
		SQLQuery query1 = new SQLQuery(selectCredentials, params);
		SQLQuery query2 = new SQLQuery(selectUserInfo, params);
		SQLQuery query3 = new SQLQuery(selectVacInfo, params);
	
		Database.execute(query1, query2, query3);
		// get the data all together to not call db twice
		
		List<List<String>> result = query1.getResult();
		List<List<String>> userInfo = query2.getResult();
		List<List<String>> vaccinations = query3.getResult();

		
		if (query1.getStatus() == Database.RESULT && !result.isEmpty()) {
			String dbHashedPsw = result.get(0).get(1);
			
			HashedPassword hashPsw = new HashedPassword(password);
			String hashedPassword = hashPsw.getHashedPassword();
			
			if (dbHashedPsw.equals(hashedPassword)) {
				access = true;
			} else {
				access = false;
			}
		} else {
			access = false;
		}
		
		List<String> lastVaccination = vaccinations.get(vaccinations.size()-1);
		Date now = new Date();
		Date yesterday = new Date(new Date().getTime() - 86400000);
		Date lastVaccinationDate = new DateUtilities(lastVaccination.get(4)).getDate();
		Boolean canUserBook = lastVaccinationDate.before(yesterday);
		
	%>
	
	<jsp:include page="../../partials/header.jsp">
  	<jsp:param name="initPath" value="../../" />
  </jsp:include>
	
	  <main id="main">

    <!-- ======= Services Section ======= -->
    <section id="services" class="services">
      <div class="container">

				<% if (access) { %>
	        <div class="section-title">
	          <h2>Le tue prenotazioni</h2>
	          <h3><%= fiscalCode %></h3>
	          <p>Qui puoi prenotare nuove vaccinazioni e gestire quelle già prenotate e/o avvenute.</p>
	          <% if (canUserBook) { %>
		         	<div style="margin-top: 20px;" class="text-center">
		          	<button>Prenota</button>
		        	</div>
		        <% } %>
	        </div>
	
	        <div class="row">
	          <%
							for(int i=1; i < vaccinations.size(); i++) {
								List<String> vac = vaccinations.get(i);
						%>
							<div class="col-lg-4 col-md-6 align-items mt-4">
<!-- 		            <a href="#"> -->
		              <div class="icon-box">
		                <div class="icon"><i class="fas fa-syringe"></i></div>
		                <h4><%= vac.get(4).split(" ")[0] %></h4>
		                <p>Dettagli vaccinazione</p>
		                <p>ID: <%= vac.get(0) %></p>
		                <p>DOSE: <%= vac.get(5) %></p>
		                <br />
				           	<button>Scarica / Failed</button>
		              </div>
<!-- 		            </a> -->
		          </div>
						<% } %>

						<div class="col-lg-4 col-md-6 align-items mt-4">
	              <div class="icon-box">
	                <div class="icon"><i class="fas fa-syringe"></i></div>
	                <h4 id="last_vac_date"><%= vaccinations.get(0).get(4).split(" ")[0] %></h4>
	                <p>Dettagli vaccinazione</p>
	                <p>ID:</p>
	                <p id="last_vac_id"><%= vaccinations.get(0).get(0) %></p>
	                <p><%= vaccinations.get(0).get(5) %>a dose</p>
	                <br />
	                <p>Cambia data</p>
	                <div style="margin-top: 5px;" class="text-center">
			              <input type="date" name="edit_date" id="edit_date">
			            </div>
			           	<button id="changeDate">Salva</button>
	              </div>
	          </div>
	
	        </div>
	      <% } else { %>
	      	<div class="section-title">
	          <h2>Le tue prenotazioni</h2>
	          <h3>Accesso negato</h3>
	          <p>Hai inserito una password sbagliata.</p>
	        </div>
	
	        <div class="text-center">
	          <button onclick="history.back()" >Torna indietro</button>
	        </div>
				<% } %>
      </div>
    </section><!-- End Services Section -->

  </main><!-- End #main -->
  
  <jsp:include page="../../partials/footer.jsp">
  	<jsp:param value="../../" name="initPath"/>
  </jsp:include>
  
  <script>
  	function httpPost(newDate, vacId) {
  		$.ajax({
   	      url: "http://localhost:8080/apsw_project/edit",
   	      type: "post", 
   	      data: {
   	    	  	newDate: newDate,
   	          vacId: vacId
   	      },
   	      success: function() {
   	        $("#last_vac_date").html(newDate)
   	        $("#edit_date").val(null)
   	        alert("Data della prenotazione cambiata correttamente")
   	      },
   	      error: function() {
   	        // console.log(err)
   	        alert("qualcosa è andato storto")
   	      }
   	    });
  	}
  	
   	$(document).ready(function () {
 	  	$("#changeDate").click(function () {
	  	    
	 		  let newDate = $("#edit_date").val()
	 		  let oldDate = $("#last_vac_date").html()
	 		  let vacId = $("#last_vac_id").html()
	
 	  	  if (!newDate) {
 	  	    alert("Errore: Selezionare una data.")
 	  	  } else {
 	  		  let nDate = new Date(newDate)
 	  		  let oDate = new Date(oldDate)
 	  		  if (nDate > oDate) {
 	  	        httpPost(newDate, vacId)
 	  		  } else {
 	  			  alert("Errore: La nuova data non può essere antecedente quella vecchia")
 	  		  }
 	        
 	  	  } 	 
 	  	})
   	});
  </script>
  
</body>
</html>