console.log(getUserCookie());

var layers = [];

layers['mkt_practice_areas'] = new google.maps.KmlLayer('http://motioninfo.com/VRS/KML/mkt_practice_areas.kml', {
  		preserveViewport: true
	});

function initLayers() {
  map = window.GoogleMap;

  layers['mkt_practice_areas'].setMap(map);
}

if(getUserCookie() === 'ben.harold@maritimeinfosystems.com')
    google.maps.event.addDomListener(window, 'load', initLayers);