<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.io.IOException"%>
<%@ page import="jakarta.servlet.ServletException"%>
<%@ page import="jakarta.servlet.annotation.WebServlet"%>
<%@ page import="jakarta.servlet.http.HttpServlet"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>

<%@ page import="db.Database"%>
<%@ page import="db.SQLQuery"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Certificato vaccinazione</title>
</head>
<body>
	<%
		Boolean access;
		HttpSession userSession = request.getSession();
		String sessionType = (String) userSession.getAttribute("type");
		
	%>
	<%
		if (sessionType != null && sessionType.equals("user")) {
			
			access = true;
			
			String fiscalCode = (String) userSession.getAttribute("id_user");
			String vaccinationId = request.getParameter("vid");
			
			String sql = "SELECT * "
					+ "FROM Vaccination V, Doctor D, Vac_User U "
					+ "WHERE V.id_vaccination = ? "
					+ "AND V.id_user = ? "
					+ "AND V.id_doctor = D.fiscal_code "
					+ "AND V.id_user = U.fiscal_code; ";
			
			// V.id_user = fiscalCode to check the vaccination really belongs to that user
			
			List<Object> params = Arrays.asList(vaccinationId, fiscalCode);
			SQLQuery query = new SQLQuery(sql, params);
	
			try {
				Database.execute(query);
			} catch (Exception e) {
				response.sendError(500);
			}
						
			List<List<String>> result = query.getResult();
			List<String> vaccination = result.get(0);
	%>
			<div id="content">
				<h2>ID Vaccinazione: <%= vaccination.get(0) %></h2>
	      <h3>Dati Utente: </h3>
	      <div>Codice Fiscale: <%= vaccination.get(11) %></div>
	      <div>Nome: <%= vaccination.get(12) %></div>
	      <div>Cognome: <%= vaccination.get(13) %></div>
	      <div>Data di nascita: <%= vaccination.get(15) %></div>
	     	<div>Città di nascita: <%= vaccination.get(14) %></div>
	      <h3>Dati Dottore: </h3>
	      <div>Nome: <%= vaccination.get(7) %></div>
	      <div>Cognome: <%= vaccination.get(8) %></div>
	      <h3>Vaccinazione: </h3>
	      <div>ID: <%= vaccination.get(0) %></div>
	      <div>Vaccino: <%= vaccination.get(3) %></div>
	      <div>Dose: <%= vaccination.get(5) %></div>
	      <div>Data: <%= vaccination.get(4) %></div>
	      <div style="margin-top: 40px;">Rilasciato da ASP di Palermo</div>
	    </div>
	    <button style="margin-top: 40px;" id="save">stampa PDF</button>
	    
		
	<% } else { %>
			<h2>Sessione scaduta: rieffettua l'accesso per scaricare il tuo certificato</h2>
	<% } %>
	
	<script type="text/javascript" src="../../assets/js/jquery.min.js"></script>

	<script type="text/javascript">
		 $(document).ready(function () {
	 	  	$("#save").click(function () {
					$("#save").remove()
				 	window.print()
	 	  	});
   	});
	</script>

</body>
</html>