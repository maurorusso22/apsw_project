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
<%@ page import="jakarta.servlet.http.HttpSession"%>
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
		
		String selectCredentials = "SELECT * FROM Doctor_Credentials WHERE fiscal_code = ? ;";
		String selectDoctorInfo = "SELECT * FROM Doctor WHERE fiscal_code = ? ; ";
		String selectVacInfo = "SELECT * FROM Vaccination WHERE id_doctor = ? ; ";
				
		List<Object> params = Arrays.asList(fiscalCode);
	
		SQLQuery query1 = new SQLQuery(selectCredentials, params);
		SQLQuery query2 = new SQLQuery(selectDoctorInfo, params);
		SQLQuery query3 = new SQLQuery(selectVacInfo, params);
	
		try {
			Database.execute(query1, query2, query3);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(500);
		}
		
		List<List<String>> result = query1.getResult();
		List<List<String>> doctorInfo = query2.getResult();
		List<List<String>> vaccinations = query3.getResult();

		if (query1.getStatus() == Database.RESULT && !result.isEmpty()) {
			String dbHashedPsw = result.get(0).get(1);
			
			HashedPassword hashPsw = new HashedPassword(password);
			String hashedPassword = hashPsw.getHashedPassword();
			
			if (dbHashedPsw.equals(hashedPassword)) {
				access = true;
				HttpSession doctorSession = request.getSession();
				doctorSession.setAttribute("type", "doctor");
				doctorSession.setAttribute("id_doctor", fiscalCode);
				doctorSession.setMaxInactiveInterval(60*60*24);
			} else {
				access = false;
			}
		} else {
			access = false;
		}
		
	%>
	
	<jsp:include page="../../partials/header.jsp">
  	<jsp:param name="initPath" value="../../" />
  </jsp:include>
	
	  <main id="main">

				<% if (access) { %>
					<section id="services" class="services">
		      	<div class="container">
			        <div class="section-title">
			          <h2>Dashboard Dottore</h2>
			          <h3><%= fiscalCode %></h3>
			          <p>Qui puoi vedere e caricare le vaccinazioni effettuate.</p>
			        </div>
			        
			        <section id="faq" class="faq section">
					      <div class="container">
					        
					        <div class="faq-list">
						        <ul>
							       	<li data-aos="fade-up" style="background-color: #C2C2C2;">
						             <a data-bs-toggle="collapse" class="collapse" data-bs-target="#newvac">Aggiungi vaccinazione<i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>
						             <div id="newvac" class="collapse" data-bs-parent=".faq-list">
													<form action="" role="form" class="php-email-form">
																	
									          <div class="row mb-3 mt-3">
									            <div class="col-md-4 form-group">
									              <input type="text" name="vaccinationId" class="form-control" id="vaccinationId" placeholder="ID vaccinazione">
									              <div class="validate"></div>
									            </div>
									            <div class="col-md-4 form-group">
									              <select name="product" id="product" class="form-select">
									              	<option value="none">Seleziona vaccino</option>
									                <option value="pfizer">Pfizer</option>
									                <option value="moderna">Moderna</option>
									                <option value="janssen">Janssen</option>
		 							                <option value="astrazeneca">Astrazeneca</option>
		 							                <option value="novavax">Novavax</option>
									              </select>
									              <div class="validate"></div>
									            </div>
									          </div>
									          
														<div class="text-center">
														  <button type="button" id="newVacButton">Aggiungi</button>
														</div>	
									        </form>	               
						             </div>
						           </li>
						        </ul>
						      </div>
					      </div>
					    </section>
					  </div>
	    		</section>
	    		
			    <section id="counts" class="counts">
			      <div class="container">
			
			        <div class="row">
			
			          <div class="col-lg-3 col-md-6">
			            <div class="count-box">
			              <i class="fas fa-user-md"></i>
			              <span data-purecounter-start="0" data-purecounter-end=<%= vaccinations.size() %> data-purecounter-duration="1" class="purecounter"></span>
			              <p>Vaccinazioni effettuate</p>
			            </div>
			          </div>
			
								<div class="col-lg-3 col-md-6 mt-5 mt-lg-0">
									<a href="http://localhost:8080/apsw_project/doc-report">
				            <div class="count-box">
				              <i class="fas fa-flask"></i>
				              <span>Scarica</span>
				              <p>Resoconto vaccini effettuati</p>
				            </div>
				          </a>
			          </div>
			        </div>
			
			      </div>
			    </section>
	      <% } else { %>
		      <section id="services" class="services">
		      	<div class="container">
			      	<div class="section-title">
			          <h2>Dashboard dottore</h2>
			          <h3>Accesso negato</h3>
			          <p>Hai inserito delle credenziali errate.</p>
			        </div>
			
			        <div class="text-center">
			          <button onclick="history.back()" >Torna indietro</button>
			        </div>
			      </div>
	    		</section>
				<% } %>

  </main><!-- End #main -->
  
  <jsp:include page="../../partials/footer.jsp">
  	<jsp:param value="../../" name="initPath"/>
  </jsp:include>
  
  <script>
  	function httpPost(vaccinationId, product) {
  		$.ajax({
   	      url: "http://localhost:8080/apsw_project/addvac",
   	      type: "post", 
   	      data: {
   	    			vaccinationId: vaccinationId,
   	    			product: product
   	      },
   	      success: function() {
   	        $("#vaccinationId").val(null)
   	        $("#product").val(null)
   	        alert("Vaccinazione aggiunta correttamente")
   	        window.location.reload()
   	      },
   	      error: function(err) {
   	    	  if (err.status === 408) {
   	    		  alert("Sessione scaduta. Accedi nuovamente.")
   	   	      window.location.replace("http://localhost:8080/apsw_project/pages/doctor/access.jsp")
   	    	  } else if (err.status === 404) {
   	    		  alert("Errore: La vaccinazione inserita non esiste. Controllare la correttezza dell'identificativo.")
   	    	  } else {
   	        	alert("Qualcosa è andato storto.")
   	    	  }
   	      }
   	    });
  	}
  	
   	$(document).ready(function () {
 	  	$("#newVacButton").click(function () {
	  	    
	 		  let vaccinationId = $("#vaccinationId").val()
	 		  let product = $("#product").val()
	
 	  	  if (!vaccinationId || !product) {
 	  	    alert("Errore: Inserire tutti i dati richiesti.")
 	  	  } else {
 	  	  	httpPost(vaccinationId, product)
 	  	  } 	 
 	  	})
   	});
  </script>
  
</body>
</html>