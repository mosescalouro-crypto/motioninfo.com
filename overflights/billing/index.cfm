<cfinclude template="header.cfm">

<form id="billing-form">
  <button type="submit" class="btn btn-default">Add new payment card</button>
</form>

<script src='https://api.value.io/assets/value.js' type="text/javascript"></script>
<script>
	window.valueio_write_only_token = "0b177613-0e5b-42a4-8b04-c0dba98597a3";
	window.valueio_form_selector = "#billing-form";
  	window.valueio_secure_form_collect_name = 'true';
  	window.valueio_secure_form_collect_zip = 'true';
	window.valueio_resource= 'credit_card';
	window.valueio_vault='true';
</script>

<cfinclude template="footer.cfm">