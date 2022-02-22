<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
		.bluebutton {
			margin-top: 16px;
		  background: #1c84e3;
		  border: 0;
		  padding: 10px 35px;
		  color: #fff;
		  transition: 0.4s;
		  border-radius: 50px;
		}
		.bluebutton:hover {
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
		String selectVacInfo = "SELECT * FROM Vaccination WHERE id_user = ? ORDER BY vac_date DESC; ";
				
		List<Object> params = Arrays.asList(fiscalCode);
	
		SQLQuery query1 = new SQLQuery(selectCredentials, params);
		SQLQuery query2 = new SQLQuery(selectUserInfo, params);
		SQLQuery query3 = new SQLQuery(selectVacInfo, params);
	
		try {
			Database.execute(query1, query2, query3);
		} catch (Exception e) {
			response.sendError(500);
		}
		
		List<List<String>> result = query1.getResult();
		List<List<String>> userInfo = query2.getResult();
		List<List<String>> vaccinations = query3.getResult();

		// access
		if (query1.getStatus() == Database.RESULT && !result.isEmpty()) {
			String dbHashedPsw = result.get(0).get(1);
			
			HashedPassword hashPsw = new HashedPassword(password);
			String hashedPassword = hashPsw.getHashedPassword();
			
			if (dbHashedPsw.equals(hashedPassword)) {
				access = true;
				HttpSession userSession = request.getSession();
				userSession.setAttribute("type", "user");
				userSession.setAttribute("id_user", fiscalCode);
				userSession.setMaxInactiveInterval(60*30);
			} else {
				access = false;
			}
		} else {
			access = false;
		}
		
		// check if the user can book another vaccine
		List<String> lastVaccination = vaccinations.get(0);
		Date now = new Date();
		Date yesterday = new Date(new Date().getTime() - 86400000);
		Date lastVaccinationDate = new DateUtilities(lastVaccination.get(4)).getDate();
		Boolean canUserBook;
		int lastDose = Integer.parseInt(lastVaccination.get(5));

		if (lastDose == 4 && lastVaccination.get(3) != null) {
			// if product is not null, it means the vaccination has been done successfully
			canUserBook = false; // max 4 doses at the moment
		} else {
			canUserBook = lastVaccinationDate.before(yesterday); // no vaccination if one is still "on going"
		}
		
		// data for booking	a new one	
		int nextDose;
		if (lastVaccination.get(3) != null) {
			nextDose = Integer.parseInt(lastVaccination.get(5)) + 1;
		} else {
			nextDose = Integer.parseInt(lastVaccination.get(5));
		}
		
		int nextId = Integer.parseInt(lastVaccination.get(0).split("_")[1]) + 1;
		
		LocalDate today = LocalDate.now();
		LocalDate futureDate = LocalDate.now().plusMonths(1);
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
	        </div>
	
	        <div class="row">
	        
	        	<% if (canUserBook) { %>
							<div class="col-lg-4 col-md-6 align-items mt-4">
		              <div class="icon-box">
		                <div class="icon"><i class="fas fa-syringe"></i></div>
		                <h5 id="last_vac_id">Prenota la tua <%= nextDose %>a dose! </h5>
		                <br />
		                <p>Scegli data</p>
		                <div style="margin-top: 5px;" class="text-center">
				              <input type="date" name="newVacDate" id="newVacDate" min=<%= today %> max=<%= futureDate %>>
				              <input hidden="true" type="text" name="nextDose" id="nextDose" value="<%= nextDose %>">
				              <input hidden="true" type="text" name="nextId" id="nextId" value="<%= nextId %>">
				              <select name="newVacTime" id="newVacTime">
				              	<option value="null">--:--</option>
				                <option class="timeclass" id="9" value="09:00:00">09:00</option>
				                <option class="timeclass" id="10" value="10:00:00">10:00</option>
				                <option class="timeclass" id="11" value="11:00:00">11:00</option>
				                <option class="timeclass" id="12" value="12:00:00">12:00</option>
				                <option class="timeclass" id="13" value="13:00:00">13:00</option>              
				                <option class="timeclass" id="14" value="14:00:00">14:00</option>
				                <option class="timeclass" id="15" value="15:00:00">15:00</option>
				                <option class="timeclass" id="16" value="16:00:00">16:00</option>
				                <option class="timeclass" id="17" value="17:00:00">17:00</option>
				                <option class="timeclass" id="18" value="18:00:00">18:00</option>
				              </select>
				            </div>
				           	<button class="bluebutton" id="bookNewVaccine">Prenota</button>
		              </div>
		          </div>
		        <% } %>
		        
	          <%
							for(int i=0; i < vaccinations.size(); i++) {
								List<String> vac = vaccinations.get(i);
						%>
							<% if (i == 0) { %>
								<div class="col-lg-4 col-md-6 align-items mt-4">
		              <div class="icon-box">
		                <div class="icon"><i class="fas fa-syringe"></i></div>
		                <h5 id="last_vac_id"><%= vac.get(0) %></h5>
		                <p id="last_vac_date"><%= vac.get(4).split(" ")[0] %></p>
		                <p id="last_vac_time"><%= "alle " + vac.get(4).split(" ")[1] %></p>
		                <p><%= vac.get(5) %>a dose</p>
		                <br />
		                <% 
		                	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		                	Date vd = formatter.parse(vac.get(4).split(" ")[0]);
		                	if (vd.after(new Date())) { 
		                %>
			                <p>Cambia data</p>
			                <div style="margin-top: 5px;" class="text-center">
					              <input type="date" name="editDate" id="editDate" min=<%= vac.get(4).split(" ")[0] %>>
					              <select name="editVacTime" id="editVacTime">
					              	<option value="null">--:--</option>
					                <option class="timeclass" id="9" value="09:00:00">09:00</option>
					                <option class="timeclass" id="10" value="10:00:00">10:00</option>
					                <option class="timeclass" id="11" value="11:00:00">11:00</option>
					                <option class="timeclass" id="12" value="12:00:00">12:00</option>
					                <option class="timeclass" id="13" value="13:00:00">13:00</option>              
					                <option class="timeclass" id="14" value="14:00:00">14:00</option>
					                <option class="timeclass" id="15" value="15:00:00">15:00</option>
					                <option class="timeclass" id="16" value="16:00:00">16:00</option>
					                <option class="timeclass" id="17" value="17:00:00">17:00</option>
					                <option class="timeclass" id="18" value="18:00:00">18:00</option>
					              </select>
					            </div>
					           	<button class="bluebutton" id="changeDate">Salva</button>
					          <% } else if (vd.before(new Date()) && vac.get(3) != null) { %>
							        <a href="http://localhost:8080/apsw_project/pages/user/certificate.jsp?vid=<%= vac.get(0) %>" target="_blank">
					          		<button>Scarica</button>
					          	</a>
					          <% } else { %>
					          	<p style="color: red;">vaccinazione non avvenuta</p>
					          <% } %>
		              </div>
		          	</div>
							
							<% } else { %>
								<div class="col-lg-4 col-md-6 align-items mt-4">
			              <div class="icon-box">
			                <div class="icon"><i class="fas fa-syringe"></i></div>
			                <h5><%= vac.get(0) %></h5>
			                <p><%= vac.get(4).split(" ")[0] %></p>
			                <p><%= "alle " + vac.get(4).split(" ")[1] %></p>
			                <p><%= vac.get(5) %>a dose</p>
			                <br />
			                <% if (vac.get(3) != null) { %>
							          <a href="http://localhost:8080/apsw_project/pages/user/certificate.jsp?vid=<%= vac.get(0) %>" target="_blank">
						          		<button>Scarica</button>
						          	</a>
						          <% } else { %>
					           		<p style="color: red;">vaccinazione non avvenuta</p>
					           	<% } %>
			              </div>
			          </div>
			        <% } %>
			      <% } %>					
	
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
  	function editDate(newDate, editVacTime, vacId) {
  		$.ajax({
   	      url: "http://localhost:8080/apsw_project/edit",
   	      type: "post", 
   	      data: {
   	    	  	newDate: newDate,
   	    	 		editVacTime: editVacTime,
   	          vacId: vacId
   	      },
   	      success: function() {
   	        $("#last_vac_date").html(newDate)
   	        $("#last_vac_time").html(editVacTime)
   	        $("#editDate").val(null)
   	        alert("Data della prenotazione cambiata correttamente")
   	      },
   	      error: function(err) {
   	    	  if (err.status === 408) {
   	    		  alert("Sessione scaduta. Accedi nuovamente.")
   	   	      window.location.replace("http://localhost:8080/apsw_project/pages/user/access.jsp")
   	    	  } else {
   	        	alert("Qualcosa è andato storto.")
   	    	  }
   	      }
   	    });
  	}
  	
  	function newVaccine(newVacDate, newVacTime, nextDose, nextId) {
  		$.ajax({
   	      url: "http://localhost:8080/apsw_project/book",
   	      type: "post", 
   	      data: {
   	    			newVacDate: newVacDate,
   	    			newVacTime: newVacTime,
   	          nextDose: nextDose,
   	          nextId: nextId
   	      },
   	      success: function() {
   	        alert("Nuova prenotazione effettuata correttamente")
   	        window.location.reload()
   	      },
   	      error: function(err) {
   	    	  if (err.status === 408) {
   	    		  alert("Sessione scaduta. Accedi nuovamente.")
   	   	      window.location.replace("http://localhost:8080/apsw_project/pages/user/access.jsp")
   	    	  } else {
   	        	alert("Qualcosa è andato storto (newVaccine).")
   	    	  }
   	      }
   	    });
  	}
  	
  	function search(searchDate) {
  		// check availability for that date
  		$.ajax({
   	      url: "http://localhost:8080/apsw_project/availability",
   	      type: "post", 
   	      data: {
   	    	  	searchDate: searchDate,
   	      },
   	      success: function(response) {
   	        console.log(response)
   	        const { result } = response
   	        $("#9").prop("disabled", !result[0])
   	        $("#10").prop("disabled", !result[1])
   	        $("#11").prop("disabled", !result[2])
   	        $("#12").prop("disabled", !result[3])
   	        $("#13").prop("disabled", !result[4])
   	        $("#14").prop("disabled", !result[5])
   	        $("#15").prop("disabled", !result[6])
   	        $("#16").prop("disabled", !result[7])
   	        $("#17").prop("disabled", !result[8])
   	        $("#18").prop("disabled", !result[9])
   	        if (result.every(el => !el)) {
   	 	  			$("#newVacDate").val(null)
   	        	alert("Il giorno selezionato è pieno. Selezionare un'altra data per favore");
   	        }
   	      },
   	      error: function(err) {
   	    	  if (err.status === 408) {
   	    		  alert("Sessione scaduta. Accedi nuovamente.")
   	   	      window.location.replace("http://localhost:8080/apsw_project/pages/user/access.jsp")
   	    	  } else {
   	        	alert("Qualcosa è andato storto.")
   	    	  }
   	      }
   	    });
  	}
  	
   	$(document).ready(function () {
 	  	$("#changeDate").click(function () {
	  	    
	 		  let newDate = $("#editDate").val()
	 		  let oldDate = $("#last_vac_date").html()
	 		  let editVacTime = $("#editVacTime").val()
	 		  let vacId = $("#last_vac_id").html()
	
 	  	  if (!newDate || !editVacTime || editVacTime == "null") {
 	  	    alert("Errore: Selezionare una data e un orario.")
 	  	  } else {
 	  		  let nDate = new Date(newDate)
 	  		  let oDate = new Date(oldDate)
 	  		  if (nDate > oDate) {
 	  	        editDate(newDate, editVacTime, vacId)
 	  		  } else {
 	  			  alert("Errore: La nuova data non può essere antecedente o uguale quella vecchia")
 	  		  }
 	        
 	  	  } 	 
 	  	});
 	  	$("#editDate").change(function () {
 	  		let d = $("#editDate").val()
 	  		$("#editVacTime").val("null")
 	  		search(d);
 	  	});
 	  	$("#newVacDate").change(function () {
 	  		let d = $("#newVacDate").val()
 	  		$("#newVacTime").val("null")
 	  		search(d);
 	  	});
 	  	$("#bookNewVaccine").click(function () {
	  	    
	 		  let newVacDate = $("#newVacDate").val()
	 		  let newVacTime = $("#newVacTime").val()
	 		  let nextDose = $("#nextDose").val()
	 		  let nextId = $("#nextId").val()
	
	  	  if (!newVacDate || !newVacTime || newVacTime == "null") {
	  	    alert("Errore: Selezionare una data e un orario.")
	  	  } else {
	  		  let now = new Date()
	  		  let date = new Date(newVacDate)
	  		  if (date > now) {
	  				newVaccine(newVacDate, newVacTime, nextDose, nextId)
	  		  } else {
	  			  alert("Errore: La nuova data non può essere passata")
	  		  }
	        
	  	  } 	 
	  	})
   	});
  </script>
  
</body>
</html>