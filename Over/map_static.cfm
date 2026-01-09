<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>NavPASS Bahamas - Map</title>
		<style>
		#map {
		  width: 460px;
		  height: 380px;
		}

		html, body {
		  margin: 0;
		  padding: 0;
		}
		</style>
		
	</head>
	<body>

	<cfquery datasource="REPORTS" name="flight">
		select * from overflights
		where id = #url.id#
	</cfquery>


	<div id="map"></div>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD-cxT5GZct0lKCfdG_qjp_b5ESzoW_U3c"></script>

    <script>
		var map;

		airspace = new google.maps.Data();
		track = new google.maps.Data();

		function initMap() {
		  map = new google.maps.Map(document.getElementById('map'), {
		    zoom: 6,
		    center: {lat: 24, lng: -76.5},
		    disableDefaultUI: true,
		    zoomControl: false,
		    mapTypeControl: false,
		    scaleControl: false
		  });

	  		airspace.loadGeoJson('zone.json.cfm?z=bahamas');
	  		airspace.setStyle({
	  						fillColor: 'green',
	  						fillOpacity: .1,
						    strokeColor: 'green',
						    strokeOpacity: 1,
						    strokeWeight: 1
						  });
  			airspace.setMap(map);

	        track.loadGeoJson('track.json.cfm?id=<cfoutput>#url.id#</cfoutput>');

  			track.setStyle({
						    strokeColor: 'red',
						    strokeOpacity: 1,
						    strokeWeight: 2/*,
						    icons: [{
					            icon: lineSymbol,
					            offset: '33%',
					            repeat: '50%'
					          }]*/
						  });
  			track.setMap(map);
		}
		
		google.maps.event.addDomListener(window, 'load', initMap);
	</script>

	</body>
</html>