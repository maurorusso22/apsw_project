<!doctype html>
<html lang="it">
<meta http-equiv="content-type" content="text/html;charset=utf-8" />

<head>
    <!-- Metadati della pagina -->
    <meta charset="utf-8">
    <title>Portale vaccini COVID-19</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Piattaforma web per la gestione della prenotazione dei vaccini anti COVID-19">

    <!-- Riferimenti agli assets principali -->
    <link href="assets/css/theme.min.css" rel="stylesheet" type="text/css" media="all" />
    <link rel="preload" as="font" href="assets/fonts/Inter-UI-upright.var.woff2" type="font/woff2" crossorigin="anonymous" />
    <link rel="preload" as="font" href="assets/fonts/Inter-UI.var.woff2" type="font/woff2" crossorigin="anonymous" />

	<!-- Verifica del caricamento del markup -->
    <script type="text/javascript">
      window.addEventListener("load", function () {document.querySelector('body').classList.add('loaded');});
    </script>
    
    <!-- Regole di stile interne -->
    <style>
      @keyframes hideLoader{0%{ width: 100%; height: 100%; }100%{ width: 0; height: 0; }  }  body > div.loader{ position: fixed; background: white; width: 100%; height: 100%; z-index: 1071; opacity: 0; transition: opacity .5s ease; overflow: hidden; pointer-events: none; display: flex; align-items: center; justify-content: center;}body:not(.loaded) > div.loader{ opacity: 1;}body:not(.loaded){ overflow: hidden;}  body.loaded > div.loader{animation: hideLoader .5s linear .5s forwards;  } /* Typing Animation */.loading-animation {width: 6px;height: 6px;border-radius: 50%;animation: typing 1s linear infinite alternate;position: relative;left: -12px;}@keyframes typing {0% {background-color: rgba(100,100,100, 1);box-shadow: 12px 0px 0px 0px rgba(100,100,100, 0.2),24px 0px 0px 0px rgba(100,100,100, 0.2);}25% {background-color: rgba(100,100,100, 0.4);box-shadow: 12px 0px 0px 0px rgba(100,100,100, 2),24px 0px 0px 0px rgba(100,100,100, 0.2);}75% {background-color: rgba(100,100,100, 0.4);box-shadow: 12px 0px 0px 0px rgba(100,100,100, 0.2),24px 0px 0px 0px rgba(100,100,100, 1);}}
    </style>
</head>

<body data-smooth-scroll-offset="73">

  <!-- Animazione del caricamento iniziale -->
  <div class="loader">
    <div class="loading-animation"></div>
  </div>

  <!-- ------------------------------------------------ DIV INIZIALE ------------------------------------------------ -->
  <div data-overlay class="bg-primary text-light o-hidden position-relative">

    <section class="min-vh-70 o-hidden d-flex flex-column justify-content-center">
      <div class="container">
        <div class="row justify-content-center text-center align-items-center">
          <div class="col-xl-8 col-lg-9 col-md-10 layer-3" data-aos="fade-up" data-aos-delay="500">
            <h1 class="display-3">Prenota la tua vaccinazione</h1>
            <div class="mb-4">
              <p class="lead px-xl-5">
             	 Verifica che la prenotazione per la categoria a cui appartieni sia <b>disponibile</b>. Diversamente, dovrai aspettare il tuo turno per effettuare la prenotazione.  
              </p>
            </div>
            <a href="#categories" class="btn btn-lg btn-white mx-1" data-smooth-scroll>Scegli categoria</a>
          </div>
        </div>
      </div>
    </section>
    <div class="divider flip-x">
      <img src="assets/img/dividers/divider-2.svg" alt="graphical divider" data-inject-svg />
    </div>
  </div>
  
  <!-- ------------------------------------------------ CATEGORIE ------------------------------------------------ -->
  <section class="text-center" id="categories">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-xl-9">
          <h2 class="h1">Seleziona la categoria a cui appartieni <br/>e inizia la prenotazione.</h2>
        </div>
      </div>
    </div>
  </section>
  
  <!-- OPERATORI SANITARI -->
  <section class="pt-0">
    <div class="container" >
      <div class="row" data-aos="fade-up">
        <div class="col-md-6">
          <a class="fade-page" href="booking/insert-data.jsp?category=operatori_sanitari">
            <img src="assets/img/demos/operatori_sanitari_4.jpg" alt="Operatori sanitari" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
          </a>
        </div>
        <div class="col">
          <div class="row justify-content-center">
            <div class="col-xl-9 col-lg-10">
              <a class="fade-up" href="booking/insert-data.jsp?category=operatori_sanitari">
                <h3 class="h2">Operatori sanitari</h3>
              </a>
              <p class="lead">
                Tutti i soggetti dipendenti da ospedali pubblici, policlinici universitari, RSA, poliambulatori ASP, studi medici, USCA e postazioni del 118, strutture private e farmacie.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <!-- SOGGETTI VULNERABILI -->
  <section class="pt-0">
    <div class="container">
      <div class="row" data-aos="fade-up">
        <div class="col-md-6">
          <a class="fade-page" href="booking/insert-data.jsp?category=vulnerabili">
            <img src="assets/img/demos/vulnerabili_2.jpg" alt="Soggetti vulnerabili" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
          </a>
        </div>
        <div class="col">
          <div class="row justify-content-center">
            <div class="col-xl-9 col-lg-10">
              <a href="booking/insert-data.jsp?category=vulnerabili" class="fade-up">
                <h3 class="h2">Vulnerabili</h3>
              </a>
              <p class="lead">
                Soggetti altamente vulnerabili, a rischio per obesit&agrave;, et&agrave; o affetti da patologie croniche.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <!-- SCUOLE E UNIVERSITÃ€ -->
  <section class="pt-0">
    <div class="container">
      <div class="row" data-aos="fade-up">
        <div class="col-md-6">
          <a class="fade-page" href="booking/insert-data.jsp?category=scuole_universita">
            <img src="assets/img/demos/scuole_universita_2.jpg" alt="Scuole e universitÃ " class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
          </a>
        </div>
        <div class="col">
          <div class="row justify-content-center">
            <div class="col-xl-9 col-lg-10">
              <a href="booking/insert-data.jsp?category=scuole_universita" class="fade-up">
                <h3 class="h2">Scuole e universit&agrave;</h3>
              </a>
              <p class="lead">
                Per le scuole: dirigenti, insegnanti, alunni delle scuole secondarie di primo e secondo grado e personale ATA. Per le universit&agrave;: professori, assistenti e studenti fino ai 20 anni.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <!-- FORZE ARMATE E DI SICUREZZA -->
  <section class="pt-0">
    <div class="container">
      <div class="row" data-aos="fade-up">
        <div class="col-md-6">
          <a class="fade-page" href="booking/insert-data.jsp?category=forze_armate">
            <img src="assets/img/demos/polizia.jpg" alt="Forze armate e di sicurezza" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
          </a>
        </div>
        <div class="col">
          <div class="row justify-content-center">
            <div class="col-xl-9 col-lg-10">
              <a href="booking/insert-data.jsp?category=forze_armate" class="fade-up">
                <h3 class="h2">Forze armate e di sicurezza</h3>
              </a>
              <p class="lead">
                Forze armate, Polizia di Stato, Guardia di Finanza, Capitaneria di Porto, Vigili del Fuoco, Corpo dei Vigili Urbani, Personale amministrativo, Polizia Penitenziaria, Personale Carcerario dai 20 ai 60 anni.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <!-- DA 69 A 12 ANNI -->
  <section class="pt-0">
    <div class="container">
      <div class="row" data-aos="fade-up">
        <div class="col-md-6">
          <a class="fade-page">
            <img id="notavailable_img" src="assets/img/demos/persone_generico.jpg" alt="69-12 anni" data-toggle="modal" data-target="#notavailable-modal" style="opacity:0.4;filter: alpha(opacity=40);" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0" >
          </a>
        </div>
        <div class="col">
          <div class="row justify-content-center">
            <div class="col-xl-9 col-lg-10">
              <a class="fade-up">
                <h3 class="h2">Et&agrave; da 69 a 12 anni<span class="badge badge-primary ml-2">Non ancora disponibile</span></h3>
              </a>
              <p class="lead">
                Tutti i cittadini di et&agrave; compresa tra i 69 e i 12 anni.
              </p>
              
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <!-- DIVIDER -->
  <section class="has-divider bg-primary text-light">
    <div class="container"></div>
    <div class="divider">
      <img class="bg-white" src="assets/img/dividers/divider-1.svg" alt="divider graphic" data-inject-svg />
    </div>
  </section>

  <!-- ------------------------------------------------ FAQs ------------------------------------------------ -->
  <section class="pt-0" style="margin-top: 5%" id="faqs">
    <div class="container"  >
      <div class="row justify-content-center">
        <div class="col-xl-8 col-lg-9">
          <h3 class="h2">Domande pi&ugrave; comuni</h3>
          <div class="my-4">
            <div class="card mb-2 card-sm card-body hover-shadow-sm" data-aos="fade-up" data-aos-delay="100">
              <div data-target="#panel-1" class="accordion-panel-title" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="panel-1">
                <span class="h6 mb-0">Quali passaggi devo seguire per effettuare una prenotazione?</span>
                <img class="icon" src="assets/img/icons/interface/plus.svg" alt="plus interface icon" data-inject-svg />
              </div>
              <div class="collapse" id="panel-1">
                <div class="pt-3">
                  <p>Non appena selezionata una categoria, ti verr&agrave; presentata una roadmap 
                     con i vari passi dell'intero processo di prenotazione.</p>
                </div>
              </div>
            </div>
            <div class="card mb-2 card-sm card-body hover-shadow-sm" data-aos="fade-up" data-aos-delay="200">
              <div data-target="#panel-2" class="accordion-panel-title" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="panel-2">
                <span class="h6 mb-0">Quali documenti devo portare con me il giorno della vaccinazione?</span>
 	            <img class="icon" src="assets/img/icons/interface/plus.svg" alt="plus interface icon" data-inject-svg />
              </div>
              <div class="collapse" id="panel-2">
                <div class="pt-3">
                  <p>Bisogna avere con se il documento di identit&agrave; e la tessera sanitaria, 
                  	 mentre i documenti necessari da portare gi&agrave; precompilati sono il consenso 
                     al trattametno dei dati e il modulo di autocertificazione.</p>
                </div>
              </div>
            </div>
            <div class="card mb-2 card-sm card-body hover-shadow-sm" data-aos="fade-up" data-aos-delay="300">
              <div data-target="#panel-3" class="accordion-panel-title" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="panel-3">
                <span class="h6 mb-0">Come faccio a modificare i dettagli di una prenotazione?</span>
                <img class="icon" src="assets/img/icons/interface/plus.svg" alt="plus interface icon" data-inject-svg />
              </div>
              <div class="collapse" id="panel-3">
                <div class="pt-3">
                  <p>Nella sezione <b>Le mi prenotazioni</b> potrai accedere alle informazioni sulle prenotazioni effettuate, modificarle ed eventualmente cancellarle.</p>

                </div>
              </div>
            </div>
            <div class="card mb-2 card-sm card-body hover-shadow-sm" data-aos="fade-up" data-aos-delay="400">
              <div data-target="#panel-4" class="accordion-panel-title" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="panel-4">
                <span class="h6 mb-0">Come verr&agrave;  effettuata la verifica della mia appartenenza alla categoria specificata?</span>
                <img class="icon" src="assets/img/icons/interface/plus.svg" alt="plus interface icon" data-inject-svg />
              </div>
              <div class="collapse" id="panel-4">
                <div class="pt-3">
                  <p>Le credenziali inserite in fase di prenotazione verranno verificate in sede, prima della somministrazione del vaccino.</p>
                </div>
              </div>
            </div>
            <div class="card mb-2 card-sm card-body hover-shadow-sm" data-aos="fade-up" data-aos-delay="500">
              <div data-target="#panel-5" class="accordion-panel-title" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="panel-5">
                <span class="h6 mb-0">Come posso richiedere un ulteriore supporto?</span>
                <img class="icon" src="assets/img/icons/interface/plus.svg" alt="plus interface icon" data-inject-svg />
              </div>
              <div class="collapse" id="panel-5">
                <div class="pt-3">
                  <p>Puoi scrivere ai nostri specialisti attraverso questa piattaforma oppure contattare direttamente gli uffici ASP.</p>
                </div>
              </div>
            </div>
          </div>
          
          <!-- Modal del supporto diretto -->
          <span>Hai ancora qualche dubbio? <a href="#" class="hover-arrow" data-toggle="modal" data-target="#ask-modal">Contattaci</a>
          </span>
          <div class="modal fade" id="ask-modal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
              <div class="modal-content">
                <div class="modal-body">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <img class="icon bg-dark" src="assets/img/icons/interface/cross.svg" alt="cross interface icon" data-inject-svg />
                  </button>
                  <div class="m-3">
                    <ul class="avatars justify-content-center">
                      <li>
                        <img src="assets/img/avatars/team-1.jpg" alt="Avatar" class="avatar avatar-lg">
                      </li>
                      <li>
                        <img src="assets/img/avatars/team-2.jpg" alt="Avatar" class="avatar avatar-lg">
                      </li>
                      <li>
                        <img src="assets/img/avatars/team-3.jpg" alt="Avatar" class="avatar avatar-lg">
                      </li>
                    </ul>
                    <div class="text-center my-3">
                      <h4 class="h3 mb-1">Domande sul processo di prenotazione</h4>
                      <p>
                        Contatta i nostri specialisti per qualsiasi altra domanda. Di solito rispondiamo entro 24 ore.
                      </p>
                    </div>
                    <form action="https://mailform.mediumra.re/leap/smtp.php" data-form-email novalidate>
                      <div class="form-group">
                        <input type="text" class="form-control" name="contact-name" placeholder="Il tuo nome" required>
                      </div>
                      <div class="form-group">
                        <input type="email" class="form-control" name="contact-email" placeholder="Indirizzo email" required>
                      </div>
                      <div class="form-group">
                        <textarea name="contact-box-message" rows="5" class="form-control" placeholder="Scrivi il tuo messagio qui..." required></textarea>
                      </div>
                      <div class="d-none alert alert-danger" role="alert" data-error-message>
                        Riempi tutti i campi correttamente.
                      </div>
                      <div class="d-none alert alert-success" role="alert" data-success-message>
                        Grazie, un membro del nostro team ti contatter&agrave;  il prima possibile.
                      </div>
                      <button type="submit" class="btn btn-block btn-primary btn-loading" data-loading-text="Sending">
                        <img class="icon" src="assets/img/icons/theme/code/loading.svg" alt="loading icon" data-inject-svg />
                        <span>Invia</span>
                      </button>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

</body> 
  
</html>
