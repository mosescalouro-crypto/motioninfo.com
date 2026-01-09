</div>
    </div>

</div>

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/css/bootstrap-datepicker.min.css" />
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/js/bootstrap-datepicker.min.js"></script>

<script type="text/javascript">
$(document).ready(function () {
	$("[data-toggle=popover]").popover({
		placement: 'bottom',
		container: '#page-wrapper',
		html: true
	}).on('shown.bs.popover', function () {
        $('#calendar').datepicker({
		    daysOfWeekHighlighted: "0,6",
		    todayHighlight: true,
		    startDate: "<cfoutput>#dateformat(now(),'#application.dateformat_long#')#</cfoutput>"
		}).on('changeDate', function (e) {
		    window.location = "./?d=" + $.datepicker.formatDate('mm/dd/yy', e.date);
		});
    });
});
</script>

</body>
</html>