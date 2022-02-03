<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
  <jsp:include page="../partials/head.jsp">
  	<jsp:param value="../" name="initPath"/>
  </jsp:include>
</head>
<body>

  <jsp:include page="../partials/header.jsp">
  	<jsp:param name="initPath" value="../../" />
  </jsp:include>
  
    <main id="main">

    <section id="appointment" class="appointment section-bg">
      <div class="container">

        <div class="section-title">
          <h2>Errore di sistema</h2>
          <p>Si è verificato un errore interno. Ci scusiamo per l'inconveniente.</p>
        </div>

      </div>
    </section>

  </main>
  
  <jsp:include page="../partials/footer.jsp">
  	<jsp:param value="../" name="initPath"/>
  </jsp:include>

</body>
</html>