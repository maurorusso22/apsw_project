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
  	<jsp:param value="../.." name="initPath"/>
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
	</style>
</head>
<body>

	<% 
	
		Boolean access;

		String asp_name = request.getParameter("asp_name").toUpperCase();
		String asp_password = request.getParameter("asp_password");
		
		String selectCredentials = "SELECT * FROM ASP_Credentials WHERE asp_name = ? ;";
		String selectDoctors = "SELECT * FROM Doctor WHERE asp = ? ORDER BY surname; ";
				
		List<Object> params = Arrays.asList(asp_name);
	
		SQLQuery query1 = new SQLQuery(selectCredentials, params);
		SQLQuery query2 = new SQLQuery(selectDoctors, params);
	
		try {
			Database.execute(query1, query2);
			// get the data all together to not call db twice
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(500);
		}
		
		List<List<String>> result = query1.getResult();
		List<List<String>> doctors = query2.getResult();

		
		if (query1.getStatus() == Database.RESULT && !result.isEmpty()) {
			String dbHashedPsw = result.get(0).get(1);
			
			HashedPassword hashPsw = new HashedPassword(asp_password);
			String hashedPassword = hashPsw.getHashedPassword();
			
			if (dbHashedPsw.equals(hashedPassword)) {
				access = true;
				HttpSession aspSession = request.getSession();
				aspSession.setAttribute("type", "asp");
				aspSession.setAttribute("id_asp", asp_name);
				aspSession.setMaxInactiveInterval(60*60*24);
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

    <!-- ======= Services Section ======= -->
    <section id="services" class="services">
      <div class="container">

				<% if (access) { %>
	        <div class="section-title">
	          <h2><%= asp_name %></h2>
	          <h4>Dashboard per la gestione dell' ASP.</h4>
	          <p style="margin-top: 20px;">Premere il tasto sottostante per avere un resoconto dei vaccini effettuati</p>
       			<div style="margin-top: 20px;" class="text-center">
						  <button type="button" id="downloadReport">Scarica</button>
						</div>
	        </div>
	
	      <% } else { %>
	      	<div class="section-title">
	          <h2><%= asp_name %></h2>
	          <h3>Accesso negato</h3>
	          <p>Hai inserito una password sbagliata.</p>
	        </div>
	
	        <div class="text-center">
	          <button onclick="history.back()">Torna indietro</button>
	        </div>
				<% } %>
      </div>
    </section><!-- End Services Section -->
    
    <% if (access) { %>
	    <section id="faq" class="faq section-bg">
	      <div class="container">
	
	        <div class="section-title">
	          <h2>Dottori</h2>
	        </div>
	        
	        <div class="faq-list">
		        <ul>
			       	<li data-aos="fade-up" style="background-color: #C2C2C2;">
		             <a data-bs-toggle="collapse" class="collapse" data-bs-target="#newdoc">New doctor<i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>
		             <div id="newdoc" class="collapse" data-bs-parent=".faq-list">
									<form action="" role="form" class="php-email-form">

					          <div class="row mt-3">
					            <div class="col-md-4 form-group">
					              <input type="text" name="name" class="form-control" id="name" placeholder="Nome" data-rule="minlen:2" data-msg="Please enter at least 2 chars">
					              <div class="validate"></div>
					            </div>
					            <div class="col-md-4 form-group">
					              <input type="text" name="surname" class="form-control" id="surname" placeholder="Cognome" data-rule="minlen:2" data-msg="Please enter at least 2 chars">
					              <div class="validate"></div>
					            </div>
					          </div>
					
					          <div class="row">
					            <div class="col-md-4 form-group mt-3">
					              <input type="date" name="birthdate" class="form-control datepicker" id="birthdate" placeholder="Data di nascita">
					              <div class="validate"></div>
<!-- 					              <p style="font-size: 12px; padding-left: 10px;">data di nascita</p> -->
					            </div>
					            <div class="col-md-4 form-group mt-3">
					              <input type="text" name="fiscalCode" class="form-control" id="fiscalCode" placeholder="Codice fiscale" data-rule="minlen:2" data-msg="Please enter at least 2 chars">
					              <div class="validate"></div>
					            </div>
					          </div>
					
					
					          <div class="mb-3">
					            <div class="loading">Data di nascita</div>
					          </div>
					          
										<div class="text-center">
										  <button type="button" id="newDocButton">Aggiungi nuovo</button>
										</div>	
					        </form>	               
		             </div>
		           </li>
		        </ul>
		      </div>
	   	
	
	        <div class="faq-list">
	          <ul id="doctors_list">
	          	<%
								for(int i=0; i < doctors.size(); i++) {
									List<String> doc = doctors.get(i);
							%>
		            <li data-aos="fade-up">
		              <a data-bs-toggle="collapse" class="collapse" data-bs-target="#faq-list-<%= i %>"><%= doc.get(2) + " " + doc.get(1) %><i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>
		              <div id="faq-list-<%= i %>" class="collapse" data-bs-parent=".faq-list">
		                <p>Cognome: <%= doc.get(2) %></p>
		                <p>Nome: <%= doc.get(1) %></p>
		                <p>Data di nascita: <%= doc.get(3) %></p>
		                <p>Codice Fiscale: <%= doc.get(0) %></p>
		              </div>
		            </li>
	            <% } %>
	
	          </ul>
	        </div>
	
	      </div>
	    </section>
   	<% } %>

  </main><!-- End #main -->
  
  <jsp:include page="../../partials/footer.jsp">
  	<jsp:param value="../../" name="initPath"/>
  </jsp:include>
  
  <script>
  	function httpPost(name, surname, birthdate, fiscalCode) {
  		$.ajax({
   	      url: "http://localhost:8080/apsw_project/newdoctor",
   	      type: "post", 
   	      data: {
   	    	  	name: name,
   	    	  	surname: surname,
   	    	  	birthdate: birthdate,
   	    	  	fiscalCode: fiscalCode,
   	    	  	aspName: "ASP_PALERMO"
   	      },
   	      success: function(res) {
	   	  	  $("#newdoc").removeClass("collapse show")
	 	  	    $("#newdoc").addClass("collapse")
	 	  	    appendNewDoctor(name, surname, birthdate, fiscalCode)
	 	  	    alert("il dottore " + surname + " " + name + " è stato aggiunto con successo.\nIMPORTANTE: comunica al dottore la sua password: " + res.doc_password)
   	      },
   	      error: function(err) {
   	    	  if (err.status === 408) {
   	    		  alert("Sessione scaduta. Accedi nuovamente.")
   	   	      window.location.replace("http://localhost:8080/apsw_project/pages/asp/access.jsp")
   	    	  } else {
   	        	alert("Qualcosa è andato storto.")
   	    	  }
   	      }
   	    });
  	}
  	
  	function appendNewDoctor(name, surname, birthdate, fiscalCode) {
  		$("#doctors_list").prepend(
	            '<li data-aos="fade-up">' + 
	             '<a data-bs-toggle="collapse" class="collapse" data-bs-target="#faq-list-999">' + surname + ' ' + name + '<i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>' +
	             '<div id="faq-list-999" class="collapse" data-bs-parent=".faq-list">' +
	                '<p>Cognome: ' + surname + ' </p>' +
	                '<p>Nome: ' + name + '</p>' +
	                '<p>Data di nascita: ' + birthdate + '</p>' + 
	                '<p>Codice Fiscale: ' + fiscalCode + '</p>' +
	              '</div>' +
	            '</li>'
  				)
  	}
  	
   	$(document).ready(function () {
 	  	$("#newDocButton").click(function () {
	  	    
	 		  let name = $("#name").val()
	 		  let surname = $("#surname").val()
	 		  let birthdate = $("#birthdate").val()
	 		  let fiscalCode = $("#fiscalCode").val()

	
 	  	  if (!name || !surname || !birthdate || !fiscalCode) {
 	  	    alert("Errore: riempire tutti i campi richiesti.")
 	  	  } else {
 	  	    httpPost(name, surname, birthdate, fiscalCode)
 	  	  } 	 
 	  	})
 	  	
 	  	$("#downloadReport").click(function () {
 	  		window.location.replace("http://localhost:8080/apsw_project/report")
 	  	})
   	});
  </script>
  
</body>
</html>