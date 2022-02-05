<%
	String path = request.getParameter("initPath");
%>
  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top">
    <div class="container d-flex align-items-center">

      <h1 class="logo me-auto"><a href="http://localhost:8080/apsw_project/index.jsp">Portale Vaccini</a></h1>

      <nav id="navbar" class="navbar order-last order-lg-0">
        <ul>
          <li><a class="nav-link scrollto active" href="http://localhost:8080/apsw_project/index.jsp">Home</a></li>
          <li><a class="nav-link scrollto" href="<%= path + "/pages/about.jsp" %>">About</a></li>
          <li><a class="nav-link scrollto" href="<%= path + "/pages/services.jsp" %>">Services</a></li>

        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav>

    </div>
  </header>
  <!-- End Header -->