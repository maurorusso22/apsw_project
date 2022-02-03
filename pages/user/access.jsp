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
  <jsp:include page="../../partials/header.jsp">
  	<jsp:param name="initPath" value="../../" />
  </jsp:include>
  
  <main id="main">

    <section id="appointment" class="appointment section-bg">
      <div class="container">

        <div class="section-title">
          <h2>Accesso utente</h2>
          <p>Inserire il codice fiscale</p>
        </div>

        <form action="http://localhost:8080/apsw_project/user" method="post" role="form" class="php-email-form">
          <div class="row justify-content-center">
            <div class="col-md-4 form-group mt-3 mt-md-0">
              <input type="text" class="form-control" name="fiscalCode" id="fiscalCode" placeholder="Codice Fiscale" data-rule="cf" data-msg="codice fiscale invalido">
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
  
  <script>
//   	$(document).ready(function () {
// 	  	$("#send-cf").click(function () {
	  	    
// 		  let cf = $("#cf").val();
	
// 	  	  if (!cf) {
// 	  	      alert("Dati mancanti.")
// 	  	  } else {
// 	  	    $.ajax({
// 	    	      url: "http://localhost:8080/apsw_project/user",
// 	    	      type: "post", 
// 	    	      data: {
// 	    	          fiscalCode: cf
// 	    	      },
// 	    	      success: function(response) {
// 	    	    	  console.log(response.fiscalCode)
// 	    	        $("#myFC").html("my FC: " + response.fiscalCode)
// 	    	        window.location.replace("./userhome.jsp?cf=" + response.fiscalCode);
// 	    	      },
// 	    	      error: function(err) {
// 	    	        console.log(err)
// 	    	      }
// 	    	    });
// 	  	  } 	 
// 	  	})
//   	});
  </script>

</body>
</html>