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
              <input type="text" class="form-control" name="fiscalCode" id="fiscalCode" placeholder="Codice Fiscale" required="required" pattern="[A-Za-z0-9]{10,20}">
              <div class="validate"></div>
            </div>
          </div>

          <div class="mb-3">
            <div class="loading">Loading</div>
            <div class="error-message">Error</div>
            <div class="sent-message">Sent!</div>
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