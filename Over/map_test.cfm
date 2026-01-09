<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>NavPASS Bahamas - Map</title>
		<style>
		#map {
		  height: 100%;
		}
		/* Optional: Makes the sample page fill the window. */
		html, body {
		  height: 100%;
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
		var map,
			airspace,
			track,
			cachedGeoJson;

		//airspace = new google.maps.Data();
		//track = new google.maps.Data();

		function initMap() {
		  map = new google.maps.Map(document.getElementById('map'), {
		    zoom: 7,
		    minZoom: 6,
		    maxZoom: 14,
		    center: {lat: 24, lng: -76},
		    disableDefaultUI: true,
		    zoomControl: true,
		    mapTypeControl: true,
		    scaleControl: true
		  });


  			/*var lineSymbol = {
	          path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
	          //strokeColor: '#00F'
	          fillOpacity: 1
	        };*/

	        // Load GeoJSON.
			map.data.loadGeoJson("track.json.cfm?id=<cfoutput>#url.id#</cfoutput>");
  			
			map.data.addListener('addfeature', function (o) {
		        console.log(o.feature.getGeometry().getAt(1));
		    });

  			<cfoutput query="flight">
			<cfquery datasource='reports' name='d'>
			select codeiataairport,nameairport,namecountry  from airports where codeicaoairport = '#departurepoint#'
			</cfquery>
			<cfquery datasource='reports' name='a'>
			select codeiataairport,nameairport,namecountry  from airports where codeicaoairport = '#arrivalpoint#'
			</cfquery>
  			var contentString = '<div id="content">'+
            '<div id="bodyContent">'+
            '<b>Callsign:</b> #callsign#<br>'+
            '<b>Tail No:</b> #reg#<br>'+
            '<b>ICAO:</b> #icao#<br>'+
            '<b>From:</b> #d.nameairport#,#d.namecountry# (#departurepoint#/#d.codeiataairport#)<br>'+			
            '<b>To:</b> #a.nameairport#,#a.namecountry# (#arrivalpoint#/#a.codeiataairport#)<br>'+			
            '<b>Distance:</b> #overflightdistance#<br>'+
            '<b>Fee:</b> $#fee#<br>'+
            '<b>When:</b> #datetimeformat(optime)# UTC'+
            '</div>'+
            '</div>';
            </cfoutput>

        	var infowindow = new google.maps.InfoWindow({
          		content: contentString,
          		position: {lat: 25.5, lng: -75},
        	});
        	infowindow.open(map);
		}
		
		google.maps.event.addDomListener(window, 'load', initMap);
	</script>

	</body>
</html>