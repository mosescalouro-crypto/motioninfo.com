<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>MIS Marine Tracking Home Page </title>

    <!-- bootstrap css -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    
    <!-- mis custom css -->
    <link rel="stylesheet" href="css/mis-style.css">
    
    <!-- icon & font css -->
    <link rel="stylesheet" href="fonts/font-awesome/css/font-awesome.min.css">
	<link href="http://fonts.googleapis.com/css?family=Cookie" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Exo+2:400,700,500|Signika|Sorts+Mill+Goudy|Cardo' rel='stylesheet' type='text/css'>

  	<!-- hero scripts preloaded -->
	<script src="js/jbone.js"></script>
  	<script src="js/pureSlider.js"></script>

    
</head>

<body data-spy="scroll" data-target="#site-nav">

<!-- TOP NAV change 
==================================================== -->
<?php include("includes/mis_marine_top_nav.cfm"); ?>

    
<!-- HERO
==================================================== -->
  <div class="intro" id="marineHome">
  
        <container>
        
			<slide style="background-image: url('images/marine_v1_1920x1080.jpg')"></slide>
			<slide style="background-image: url('images/marine_v2_1920x1080.jpg')"></slide>
			<slide style="background-image: url('images/marine_v3_1920x1080.jpg')"></slide>
			<slide style="background-image: url('images/marine_v4_1920x1080.jpg')"></slide>
        	
            <div class="overlay"></div>
            
            <div class="headline">
            	
            	<h1><img src="images/mislogo_ship_450w.png" class="hidden-xs" width="250px"> Marine Tracking</h1>
      			<h3>Real-time <strong>Marine Vessels</strong> tracking and reporting<br><br></h3>
      			<a class="btn btn-blue mb10" data-scroll href="#marineProgram">About MIS Tracking</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      			<a class="btn btn-blue mb10" data-scroll href="#marineContact">Join&nbsp;Program</a>
            </div>
		</container>

		<script>
			$('container').pureSlider({
				slideNode: 'slide'
			});
		</script>

	</div>
        
<!-- Spacer -->
<div class="mt40" id="marineAbout">&nbsp;</div>


<!-- ABOUT: MARINE TRACKING
================================================== -->
	<div class="section-title text-center">
		<h2>Marine Tracking</h2>
    	<div class="section-underline">
    		<div class="section-title-icon section-title-icon-align marine-title-icon"><i class="fa fa-ship"></i></div>
   		</div>
	</div><!-- End Title -->
    
<div class="container" style="margin: 0px auto;">
    
    <!-- Title -->
	<!-- Two Column Row -->
 	<div class="row">
    
    	<!-- Left Column -->
        <div class="col-sm-6">
			<h3 class="text-center">About Marine Tracking</h3>
			<p>Web VTS is a highly sophisticated web-based marine traffic monitoring system for ports and other organizations interested in real-time and historic vessel traffic. WebVTS increases the safety, security and efficiency of operations within a port and provides data for accurate analysis and planning. <br><br>
            <img src="images/tracksample.png" width="95%"></p>
            

                  <!--<ul class="list-arrow-right">

                      <li>Track arrival and departures of all aircraft</li>
                      <li>Near-real-time tracking information</li>
                      <li>Customizable reporting</li>
                      <li>Online portal</li>
                  
                  </ul>-->

                  <!--<figure><img alt="" class="img-responsive" src="images/about-us.jpg"></figure>-->

              </div><!-- /.col-sm-6 -->

              <div class="col-sm-6">

                  <h3  class="text-center">MIS Marine Tracking Platform</h3>

                  <p>The MIS Marine Tracking Platform uses onsite recievers at ports, harbors, marinas and with port authorities to enable a comprehensive marine tracking and reporting system that benefits both individual facilities and the marine industry as a whole.</p>

                  <ul>

                      <li>Real-time tracking interface shows vessels in motion</li>
                      <li>Multiple views showing weather, depth, VFR, IFR, etc.</li>
                      <li>List of all ships underway over 21' in length</li>
                      <li>Complete vessel details as well as speed, heading, and more</li>
                  
                  </ul>

              </div><!-- /.col-sm-6 -->
          </div><!-- /.row -->
      </div><!-- /.container -->
    
    


<!-- Spacer -->
<div class="mt40" id="marineProgram">&nbsp;</div>
<div class="mt20 hidden-xs">&nbsp;</div>


<!-- Aero Tracking Host Program
================================== -->

<!-- Section Title -->
<div class="section">
	<div class="section-title text-center">
		<h2>MIS Marine Tracking Host Program</h2>
    	<div class="section-underline">
    		<div class="section-title-icon section-title-icon-align marine-title-icon"><i class="fa fa-ship"></i></div>
   		</div>
	</div>
</div><!-- End Section: Host Program



<!-- Section Panel Row -->
<div class="container mt20">
<div class="row text-center">

<!-- Panel Look -->
   <div class="col-md-4 col-sm-6 col-xs-12">
    <div class="pnlContainer">
    <div class="overlay-hover">
        <div class="pnlBody pnlBodyBottom">
        	<h3 class>About the Host Program</h3>
        	<p>Participating organizations around the globe contribute to the accuracy, redundancy and scope of marine tracking by hosting the equipment that adds data from their facility to the MIS network. Facilities in close proximity to the water are eligible for the hosting program.</p>
        </div>
        <div class="overlay-effect">
        	<h3>Become a Host</h3>
        	<p style="color: #fff;">Use the form below to join the network and setup and appointment to install your equipment.</p>
            <a class="btn btn-blue mb10" data-scroll href="#contact">Learn More</a>
        </div>
    </div><!-- End Overlay -->
         <div class="pnlIcon pnlIconBottom"><i class="fa fa-users"></i></div>
   </div><!-- End Container -->
  </div><!-- End Panel -->
 
 <!-- Panel Look -->
   <div class="col-md-4 col-sm-6 col-xs-12">
    <div class="pnlContainer">
    <div class="overlay-hover">
        <div class="pnlBody pnlBodyBottom">
        	<h3 class>Program Reguirements</h3>
        	<p>There is no cost for the equipment, installation or getting started with your complimentary access to the real-time tracker. You provide a high point at your facility to mount our 2 antennaes, a power outlet and internet access&mdash;we require a very small amount of your bandwidth.</p>
        </div>
        <div class="overlay-effect">
        	<h3>Become a Host</h3>
        	<p style="color: #fff;">Use the form below to join the network and setup and appointment to install your equipment.</p>
            <a class="btn btn-blue mb10" data-scroll href="#contact">Learn More</a>
        </div>
    </div><!-- End Overlay -->
         <div class="pnlIcon pnlIconBottom"><i class="fa fa-check-square-o"></i></div>
   </div><!-- End Container -->
  </div><!-- End Panel -->

<!-- Panel Look -->
   <div class="col-md-4 col-sm-6 col-xs-12">
    <div class="pnlContainer">
    <div class="overlay-hover">
        <div class="pnlBody pnlBodyBottom">
        	<h3 class>Benefits of Hosting</h3>
        	<p>In addition to free real-time tracking, you are eligible to purchase report access for <strong>highly accurate billing, planning, management and security</strong> data.  These analytics add efficiency, profitability and understanding to every aspect of your facility management.</p>
        </div>
        <div class="overlay-effect">
        	<h3>Become a Host</h3>
        	<p style="color: #fff;">Use the form below to join the network and setup and appointment to install your equipment.</p>
            <a class="btn btn-blue mb10" data-scroll href="#contact">Learn More</a>
        </div>
    </div><!-- End Overlay -->
         <div class="pnlIcon pnlIconBottom"><i class="fa fa-line-chart"></i></div>
   </div><!-- End Container -->
  </div><!-- End Panel -->
  
  <div class="text-center visible-md visible-sm visible-xs"><h2>Become a Host</h2>
        	<p style="color: #404040;">Use thee form below to join the network and setup and appointment to install your equipment.</p>
            <a class="btn btn-black mb10" data-scroll href="#contact">Learn More</a>
 	</div>
  
 
  </div>
  </div>

    
<!-- Spacer -->
<div class="mt40" id="marineFaqs">&nbsp;</div>
<div class="mt20 hidden-xs">&nbsp;</div>


<!-- FAQs
================================== -->

<!-- Section Title -->
<div class="section">
	<div class="section-title text-center">
		<h2>Marine Tracking FAQs</h2>
    	<div class="section-underline">
    		<div class="section-title-icon section-title-icon-align marine-title-icon"><i class="fa fa-ship"></i></div>
   		</div>
	</div>
    
    <?php include("includes/mis_marine_faqs.cfm"); ?>
    
</div><!-- End Section: Host Program


<!-- Spacer -->
<div class="mt40" id="marineContact">&nbsp;</div>


<!-- Contact Form
================================== -->

<!-- Section Title -->
<div class="section">
	<div class="section-title text-center">
		<h2>Contact MIS</h2>
    	<div class="section-underline">
    		<div class="section-title-icon section-title-icon-align marine-title-icon"><i class="fa fa-ship"></i></div>
   		</div>
	</div>
    
    <cfinclude template='mis_marine_form.cfm'>
    
</div><!-- End Section: Host Program



<!-- FOOTER
================================== -->    
<?php include("includes/mis_marine_footer.cfm"); ?>



  <!-- scripts
  ======================================== -->
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/smooth-scroll.min.js"></script>
  <script src="js/main.js"></script>

</body>
</html>
