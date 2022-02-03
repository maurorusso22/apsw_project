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

    <section id="appointment" class="appointment section-bg">
      <div class="container">

        <div class="section-title">
          <h2>Accesso utente</h2>
          <h3 id="user-fc"><%= fiscalCode %></h3>
          <p>Inserire password</p>
        </div>

        <form action="http://localhost:8080/apsw_project/pages/user/userhome.jsp" method="post" role="form" class="php-email-form">
        	<input hidden="true" type="text" name="fiscalCode" id="fiscalCode" value=<%= fiscalCode %>>
        	
          <div class="row justify-content-center">
            <div class="col-md-4 form-group mt-3 mt-md-0">
              <input type="password" class="form-control" name="password" id="password" placeholder="Password">
              <div class="validate"></div>
            </div>
          </div>

          <div class="mb-3">
            <div class="loading">Loading</div>
            <div class="error-message"></div>
            <div class="sent-message">Your appointment request has been sent successfully. Thank you!</div>
          </div>
          
          <div class="text-center">
	          <button type="submit">Entra</button>
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