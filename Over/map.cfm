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
		var map;

		airspace = new google.maps.Data();
		track = new google.maps.Data();

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

	  		airspace.loadGeoJson('zone.json.cfm?z=bahamas');
	  		airspace.setStyle({
	  						fillColor: 'green',
	  						fillOpacity: .1,
						    strokeColor: 'green',
						    strokeOpacity: 1,
						    strokeWeight: 1
						  });
  			airspace.setMap(map);

  			/*var lineSymbol = {
	          path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
	          //strokeColor: '#00F'
	          fillOpacity: 1
	        };*/

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

<cfif CGI.REMOTE_ADDR eq '96.89.236.106'>
track.addListener('addfeature', function (o) {
	setMarker(map, o.feature);
});
</cfif>

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

		function setMarker(map, feature) {
		    var start_latLng = feature.getGeometry().getAt(0);
		    var length = feature.getGeometry().getLength();
		    var end_latLng = feature.getGeometry().getAt(length-1);
		    var startMarker = new google.maps.Marker({
		        position: start_latLng,
		        icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
		        map: map
		    });
		    var endMarker = new google.maps.Marker({
		        position: end_latLng,
		        icon: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png',
		        map: map
		    });
		}
	</script>

	</body>
</html>