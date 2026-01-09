<cfinclude template="header.cfm">

<form id="billing-form" onsubmit="return false">

  <div class="row">
  	<div class="col-sm-6">
	  <div class="form-group">
	    <label for="exampleInputEmail1">First Name</label>
	    <input type="text" class="form-control" id="firstName">
	  </div>
	</div>
	<div class="col-sm-6">
	  <div class="form-group">
	    <label for="exampleInputEmail1">Last Name</label>
	    <input type="text" class="form-control" id="lastName">
	  </div>
	</div>
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Card Number</label>
    <input type="text" class="form-control" id="cardNo" placeholder="4111 1111 1111 1111">
  </div>
  <div class="row">
  	<div class="col-sm-3">
  		<div class="form-group">
		    <label for="exampleInputEmail1">Exp Month</label>
		    <input type="text" class="form-control" id="expMonth" placeholder="mm">
		  </div>
  	</div>
  	<div class="col-sm-3">
  		<div class="form-group">
		    <label for="exampleInputEmail1">Exp Year</label>
		    <input type="text" class="form-control" id="expYear" placeholder="yy">
		  </div>
  	</div>
  	<div class="col-sm-6">
  		<div class="form-group">
		    <label for="exampleInputEmail1">Card Verification Code</label>
		    <input type="text" class="form-control" id="cvv">
		  </div>
  	</div>
  <button type="submit" class="btn btn-default">Submit Payment</button>
</form>

<script src='https://api.value.io/assets/value.js' type="text/javascript"></script>
<script>
	window.valueio_write_only_token = "0b177613-0e5b-42a4-8b04-c0dba98597a3";
	window.valueio_form_selector = "#billing-form";
	window.valueio_secure_form_title_1 = 'NavPASS Payments';
  	window.valueio_secure_form_title_2 = 'Bahamas Overflight Fee';
	window.valueio_first_name_selector = '#firstName';
  	window.valueio_last_name_selector = '#lastName';
  	window.valueio_secure_number_selector = "#cardNo";
	window.valueio_secure_month_selector = "#expMonth";
	window.valueio_secure_year_selector = "#expYear";
	window.valueio_secure_security_code_selector = "#cvv";
	window.valueio_method = 'secure_field';
	window.valueio_amount = '$1.00';
	//window.valueio_resource= 'credit_card';
	window.valueio_vault='true';
	window.valueio_on_success = function(){
		alert('Your credit card has been saved!');
	};
</script>

<cfinclude template="footer.cfm">