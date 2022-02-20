<%
	String path = request.getParameter("initPath");
%>
  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top">
    <div class="container d-flex align-items-center">

      <h1 class="logo me-auto"><a href="http://localhost:8080/apsw_project/index.jsp">Portale Vaccini</a></h1>

      <nav id="navbar" class="navbar order-last order-lg-0">
        <ul>
          <li><a class="nav-link scrollto" href="http://localhost:8080/apsw_project/pages/user/access.jsp">Utente</a></li>
          <li><a class="nav-link scrollto" href="http://localhost:8080/apsw_project/pages/doctor/access.jsp">Dottore</a></li>
          <li><a class="nav-link scrollto" href="http://localhost:8080/apsw_project/pages/asp/access.jsp">ASP</a></li>

        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav>

    </div>
  </header>
  <!-- End Header -->