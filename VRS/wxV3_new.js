function getCookie(name) {
  var value = "; " + document.cookie;
  var parts = value.split("; " + name + "=");
  if (parts.length == 2) return parts.pop().split(";").shift();
}

function getUserCookie() {
  var value = getCookie('session');
  var parts = value.split("&");
  var username = parts[0].split("=");
  return decodeURIComponent(username[1]);
}

var map;

var layers = [];

layers['mkt_practice_areas'] = new google.maps.KmlLayer('http://motioninfo.com/VRS/KML/mkt_practice_areas.kml', {
      preserveViewport: true
    });

layers['bahamas'] = new google.maps.Data();
layers['mexico'] = new google.maps.Data();

function initLayers() {
  map = window.GoogleMap;

  loadKml = function(opts, map) {
    var layer = new google.maps.KmlLayer();
    opts.preserveViewport = true;
    if (map) {
      opts.map = map;
    }

    google.maps.event.addListener(layer, 'defaultviewport_changed', function() {
      var map = this.getMap(),
        bounds = map.get('kmlBounds') || this.getDefaultViewport();

      bounds.union(this.getDefaultViewport());
      map.set('kmlBounds', bounds);
      map.fitBounds(bounds);
    });
    layer.setOptions(opts);
    return layer;
  };

  // Set the stroke width, and fill color for each polygon
  //map.data.setStyle({
  //  fillColor: 'red',
  //  strokeWeight: 1
  //});

  var existingControlsInTopRight = window.map.controls[google.maps.ControlPosition.TOP_LEFT];
  existingControlsInTopRight.push(document.getElementById("layer_toolbar"));
}

if(getUserCookie() === 'ben.harold@maritimeinfosystems.com')
    google.maps.event.addDomListener(window, 'load', initLayers);

function toggleLayer(i,type) {
  if (layers[i].getMap() == null) {
    if (type === 'zone') {
        layers[i].loadGeoJson('http://motioninfo.com/VRS/zones.cfm?z=' + i);
    }
    layers[i].setMap(map);
  } else {
    layers[i].setMap(null);
  }
}

$('.dropdown li').click(function() {
    $(this).toggleClass('active');
});

// ------- WX code ---------
function loadSeries(id, sdata) {
    for (var x = 0; x < sdata.seriesNames.length; x++) {
        var series = sdata.seriesNames[x];
        document.maxZoom[series] = eval("sdata.seriesInfo." + series + ".maxZoom");
        document.seriesDate[series] = eval("sdata.seriesInfo." + series + ".series[0].unixDate")
    }
    document.seriesData = sdata.seriesInfo;
    return true
}
function getTileOverlay(e, t) {
    var n = {
        minZoom: 1,
        maxZoom: document.maxZoom[e],
        isPng: true,
        opacity: t,
        tileSize: new google.maps.Size(256, 256)
    };
    n.myBaseURL = "http://g%.imwx.com/TileServer/imgs/" + e + "/u" + document.seriesDate[e] + "/";
    //if (e == "satrad") {console.log("satrad seriesDate: " + document.seriesDate[e]);}
    n.getTileUrl = function(e, t) {
        if (t > this.maxZoom)
            return "";
        var n = this.myBaseURL;
        var r = [0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288];
        for (var i = t; i > 0; i--) {
            var s = (r[i] & e.x) == 0 ? 0: 1;
            var o = (r[i] & e.y) == 0 ? 0: 2;
            n = n + (s + o)
        }
        if (golgotha.maps.multiHost) {
            var u = n.charAt(n.length - 1);
            var a = n.indexOf("%");
            if (a>-1)
                n = n.substr(0, a) + u + n.substr(a + 1)
        }
        return n + ".png"
    };
    var r = new google.maps.ImageMapType(n);
    r.getTileUrl = n.getTileUrl;
    r.layerName = e;
    r.layerDate = new Date(parseInt(document.seriesDate[e]));
    document.wxLayers[e] = r;
    return r
}
function WXOverlayControl(e, t) {
    this.buttonTitle = e;
    this.layerNames = t;
    this.container = document.createElement("div");
    var n = document.createElement("div");
    this.setButtonStyle(n);
    this.container.appendChild(n);
    n.appendChild(document.createTextNode(this.buttonTitle));
    n.layerNames = this.layerNames;
    google.maps.event.addDomListener(n, "click", this.updateMap);
    return this.container
}
function WXClearControl() {
    this.container = document.createElement("div");
    var e = document.createElement("div");
    this.setButtonStyle(e);
    this.container.appendChild(e);
    e.appendChild(document.createTextNode("Clear wx"));
    e.layerName = this.layerName;
    google.maps.event.addDomListener(e, "click", clearWX);
    return this.container
}
function clearWX() {
    var e = document.getElementById("ffSlices");
    if (e)
        e.style.visibility = "hidden";
	if (typeof window.GoogleMap.wxData === "undefined") {
		return false;
		}
    if (!window.GoogleMap.wxData)
        return false;
    if (window.GoogleMap.wxData instanceof Array) {
        for (var t = 0; t < GoogleMap.wxData.length; t++)
            window.GoogleMap.removeWeather(GoogleMap.wxData[t])
    } else 
        window.GoogleMap.removeWeather(GoogleMap.wxData);
    try {
        if (animateSlices) {
            for (var t = 0; t < animateSlices.length; t++)
                window.GoogleMap.removeWeather(animateSlices[t])
            }
    } catch (n) {}
    delete window.GoogleMap.wxData;
    delete window.GoogleMap.ffLayer;
    return true
}
function fmtDate(e) {
    var t = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return e.getDate() + "-" + t[e.getMonth()] + "-" + e.getFullYear() + "  " + e.getHours() + ":" + (e.getMinutes() < 10 ? "0" + e.getMinutes() : e.getMinutes())
}
document.maxZoom = [];
document.wxLayers = [];
document.seriesDate = [];
var golgotha = {
    maps: {
        IMG_PATH: "img",
        API: 3,
        tileHost: "g%.imwx.com",
        multiHost: true,
        seriesData: {}
    }
};
var GMTOffset = (new Date).getTimezoneOffset() * 6e4;
google.maps.Map.prototype.addWeather = function(e) {
    this.overlayMapTypes.insertAt(0, e)
};
google.maps.Map.prototype.removeWeather = function(e) {
    for (var t = 0; t < this.overlayMapTypes.getLength(); t++) {
        var n = this.overlayMapTypes.getAt(t);
        if (n == e) {
            this.overlayMapTypes.removeAt(t);
            return true
        }
    }
    return false
};
WXOverlayControl.prototype.updateMap = function() {
    clearWX();
    var e = this.layerNames instanceof Array;
    if (e) {
        window.GoogleMap.wxData = [];
        var t = [];
        for (var n = 0; n < this.layerNames.length; n++) {
            var r = document.wxLayers[this.layerNames[n]];
            window.GoogleMap.wxData.push(r);
            window.GoogleMap.addWeather(r);
            t.push(r.layerName + " (" + fmtDate(new Date(r.layerDate.getTime() - GMTOffset)) + ")")
        }
    } else {
        var r = document.wxLayers[this.layerNames];
        window.GoogleMap.wxData = r;
        window.GoogleMap.addWeather(r)
    }
    delete window.GoogleMap.ffLayer;
    return true
};
WXOverlayControl.prototype.updateMap2 = function() {
    clearWX();
	var wxSelect = document.getElementById("weather_menu_pulldown");
	var e = wxSelect.options[wxSelect.selectedIndex].value;
    this.layerNames = e;
    var e = this.layerNames instanceof Array;
    if (e) {
        window.GoogleMap.wxData = [];
        var t = [];
        for (var n = 0; n < this.layerNames.length; n++) {
            var r = document.wxLayers[this.layerNames[n]];
            window.GoogleMap.wxData.push(r);
            window.GoogleMap.addWeather(r);
            t.push(r.layerName + " (" + fmtDate(new Date(r.layerDate.getTime() - GMTOffset)) + ")")
        }
    } else {
        var r = document.wxLayers[this.layerNames];
        document.getElementById("weather_legend_img").src="../../images/" + this.layerNames + ".png";
        if (this.layerNames = "none" && this.layerNames != "sat" && this.layerNames != "windspeed") {
	        $("#weather_legend").show();
	        }
	    else {
	    	$("#weather_legend").hide();
	    	}
        window.GoogleMap.wxData = r;
        window.GoogleMap.addWeather(r)
    }
    delete window.GoogleMap.ffLayer;
    return true
};

WXOverlayControl.prototype.setButtonStyle = function(e) {
    e.style.color = "#303030";
    e.style.backgroundColor = "white";
    e.style.font = "small Arial";
    e.style.fontSize = "10px";
    e.style.border = "1px solid black";
    e.style.padding = "2px";
    e.style.marginTop = "6px";
    e.style.marginBottom = "12px";
    e.style.textAlign = "center";
    e.style.cursor = "pointer";
    if (!this.buttonTitle)
        e.style.width = "6em";
    else if (this.buttonTitle.length > 11)
        e.style.width = "8em";
    else if (this.buttonTitle.length > 9)
        e.style.width = "7em";
    else 
        e.style.width = "6em"
};
WXClearControl.prototype.setButtonStyle = WXOverlayControl.prototype.setButtonStyle
