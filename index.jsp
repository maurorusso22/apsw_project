<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<jsp:include page="./partials/head.jsp">
    <jsp:param value="." name="initPath"/>
  </jsp:include>
</head>
<body>
  
  <jsp:include page="/partials/header.jsp">
  	<jsp:param name="initPath" value="." />
  </jsp:include>

  <!-- ======= Hero Section ======= -->
  <section id="hero" class="d-flex align-items-center">
    <div class="container">
      <h1>Benvenuto</h1>
      <h2>Vaccinati, per te e per chi ti sta intorno.</h2>
    </div>
  </section><!-- End Hero -->

  <main id="main">

    <!-- ======= Why Us Section ======= -->
    <section id="why-us" class="why-us">
      <div class="container">

        <div class="row">
          <div class="col-lg-8 d-flex align-items-stretch">
            <div class="icon-boxes d-flex flex-column justify-content-center">
              <div class="row">
              
                <div class="col-xl-4 d-flex align-items-stretch">
	                <div class="icon-box mt-4 mt-xl-0">
	                  <a href="./pages/user/access.jsp">
	                    <i class="bx bx-receipt"></i>
	                    <h4>Utente</h4>
	                    <p>Sezione dedicata a chi deve vaccinarsi o è già stato vaccinato</p>
	                  </a>   
	                </div>
              	</div>

	              <div class="col-xl-4 d-flex align-items-stretch">
	                <div class="icon-box mt-4 mt-xl-0">
	                	<a href="./pages/doctor/access.jsp">
		                  <i class="bx bx-cube-alt"></i>
		                  <h4>Dottore</h4>
		                  <p>Sezione dedicata ai dottori coinvolti nella campagna di vaccinazione</p>
		                </a>
	                </div>
	              </div>
              
	              <div class="col-xl-4 d-flex align-items-stretch">
	                <div class="icon-box mt-4 mt-xl-0">
	                  <a href="./pages/asp/access.jsp">
		                  <i class="bx bx-images"></i>
		                  <h4>ASP</h4>
		                  <p>Sezione dedicata alle ASP di riferimento</p>
		                </a>
	                </div>
	              </div>
              
              </div>
            </div><!-- End .content-->
          </div>
        </div>

      </div>
    </section><!-- End Why Us Section -->

  </main><!-- End #main -->

  <div id="preloader"></div>
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  
  <jsp:include page="./partials/footer.jsp">
  	<jsp:param value="." name="initPath"/>
  </jsp:include>

</body>
</html>