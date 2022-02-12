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
              <p style="font-size: 12px; padding-left: 10px;">data di nascita</p>
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
          </div>
          
          <div class="row">
            <div class="col-md-4 form-group mt-3">
              <input min="2022-02-13" max="2022-03-13" type="date" name="vac_date" class="form-control datepicker" id="vac_date">
              <div class="validate"></div>
              <p style="font-size: 12px; padding-left: 10px;">data vaccinazione</p>
            </div>
            <div class="col-md-4 form-group mt-3">
              <select name="vac_time" id="vac_time" class="form-select">
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
  
  <script>
  	function search(searchDate) {
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
   	 	  			$("#vac_date").val(null)
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
 	  	$("#vac_date").change(function () {
 	  		let d = $("#vac_date").val()
 	  		console.log(d)
 	  		search(d);
 	  	});
   	});
  </script>

</body>
</html>