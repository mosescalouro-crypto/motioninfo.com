var page = require("webpage").create(),
	system = require("system"),
	args = system.args;

	page.dpi = 100;

if (args.length === 2) {
	var url = "http://www.motioninfo.com/overflights/map_static.cfm?id=" + args[1];

	function onPageReady() {
		setTimeout(function() {
	        page.render('../static_maps/' + args[1] + '.png');
	        phantom.exit();
	    }, 1000);
	}

	page.open(url, function (status) {
	    function checkReadyState() {
	        setTimeout(function () {
	            var readyState = page.evaluate(function () {
	                return document.readyState;
	            });

	            if ("complete" === readyState) {
	                onPageReady();
	            } else {
	                checkReadyState();
	            }
	        });
	    }
	    checkReadyState();
	});
} else {
	phantom.exit();
}