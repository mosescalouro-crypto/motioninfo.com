<!DOCTYPE html>
<html>
<head>
    <title>MotionInfo Network Coverage Map</title>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="https://d19vzq90twjlae.cloudfront.net/leaflet-0.7/leaflet.css" />
    <style>
        body {
            padding: 0;
            margin: 0;
        }
        html, body, #map {
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<body>
    <div id="map"></div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://d19vzq90twjlae.cloudfront.net/leaflet-0.7/leaflet.js"></script>

    <script>
        var map = L.map('map', {
            center: [31,-91],
            zoom: 8,        
            layers: [
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    maxZoom: 18,
                    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                })
            ]
        });

        const markerGreenStyles = `
          background-color: green;
          width: 1rem;
          height: 1rem;
          display: block;
          left: -10px;
          top: -15px;
          position: relative;
          border-radius: 1rem 1rem 0;
          transform: rotate(45deg);
          border: 1px solid #FFFFFF`

        const greenIcon = L.divIcon({
          className: "green-marker",
          iconAnchor: [0, 0],
          popupAnchor: [0, -10],
          html: `<span style="${markerGreenStyles}" />`
        })

        const markerRedStyles = `
          background-color: red;
          width: 1rem;
          height: 1rem;
          display: block;
          left: -10px;
          top: -15px;
          position: relative;
          border-radius: 1rem 1rem 0;
          transform: rotate(45deg);
          border: 1px solid #FFFFFF`

        const redIcon = L.divIcon({
          className: "green-marker",
          iconAnchor: [0, 0],
          popupAnchor: [0, -10],
          html: `<span style="${markerRedStyles}" />`
        })

        const markerOrangeStyles = `
          background-color: orange;
          width: 1rem;
          height: 1rem;
          display: block;
          left: -10px;
          top: -15px;
          position: relative;
          border-radius: 1rem 1rem 0;
          transform: rotate(45deg);
          border: 1px solid #FFFFFF`

        const orangeIcon = L.divIcon({
          className: "green-marker",
          iconAnchor: [0, 0],
          popupAnchor: [0, -10],
          html: `<span style="${markerOrangeStyles}" />`
        })

        $(function() {

            var mis_sites = L.layerGroup();

            $.getScript("https://aero.motioninfo.com/stations_overlay.cfm", function(data) {
                for (var i = 0; i < stations.length; i++) {
                    if ( stations[i][3] == 2 ) {
                        color = redIcon;
                    } else if ( stations[i][3] == 1 ) {
                        color = greenIcon;
                    } else {
                        color = orangeIcon;
                    }

                    markerLoc = L.latLng(stations[i][1], stations[i][2]);
                    
                    marker = new L.marker(markerLoc, {
                          icon: color
                        });
                    mis_sites.addLayer(marker);
                }
            });
            mis_sites.addTo(map);
        });
    </script>
</body>
</html>