<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Create Account</title>

    <!-- Bootstrap -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style>
    @import url(http://fonts.googleapis.com/css?family=Roboto);

    body {
    	background-color: #808080;
    }

	/****** LOGIN MODAL ******/
	.loginmodal-container {
	  padding: 30px;
	  max-width: 350px;
	  width: 100% !important;
	  background-color: #F7F7F7;
	  margin: 0 auto;
	  border-radius: 2px;
	  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
	  overflow: hidden;
	  font-family: roboto;
	}

	.loginmodal-container h1 {
	  text-align: center;
	  font-size: 1.8em;
	  font-family: roboto;
	}

	.loginmodal-container h4 {
	  text-align: center;
	  font-family: roboto;
	}

	.loginmodal-container input[type=submit] {
	  width: 100%;
	  display: block;
	  margin-bottom: 10px;
	  position: relative;
	}

	.loginmodal-container input[type=text], input[type=password] {
	  height: 44px;
	  font-size: 16px;
	  width: 100%;
	  margin-bottom: 10px;
	  -webkit-appearance: none;
	  background: #fff;
	  border: 1px solid #d9d9d9;
	  border-top: 1px solid #c0c0c0;
	  /* border-radius: 2px; */
	  padding: 0 8px;
	  box-sizing: border-box;
	  -moz-box-sizing: border-box;
	}

	.loginmodal-container input[type=text]:hover, input[type=password]:hover {
	  border: 1px solid #b9b9b9;
	  border-top: 1px solid #a0a0a0;
	  -moz-box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
	  -webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
	  box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
	}

	.loginmodal {
	  text-align: center;
	  font-size: 14px;
	  font-family: 'Arial', sans-serif;
	  font-weight: 700;
	  height: 36px;
	  padding: 0 8px;
	/* border-radius: 3px; */
	/* -webkit-user-select: none;
	  user-select: none; */
	}

	.loginmodal-submit {
	  /* border: 1px solid #3079ed; */
	  border: 0px;
	  color: #fff;
	  text-shadow: 0 1px rgba(0,0,0,0.1); 
	  background-color: #4d90fe;
	  padding: 17px 0px;
	  font-family: roboto;
	  font-size: 14px;
	  /* background-image: -webkit-gradient(linear, 0 0, 0 100%,   from(#4d90fe), to(#4787ed)); */
	}

	.loginmodal-submit:hover {
	  /* border: 1px solid #2f5bb7; */
	  border: 0px;
	  text-shadow: 0 1px rgba(0,0,0,0.3);
	  background-color: #357ae8;
	  /* background-image: -webkit-gradient(linear, 0 0, 0 100%,   from(#4d90fe), to(#357ae8)); */
	}

	.loginmodal-container a {
	  text-decoration: none;
	  color: #666;
	  font-weight: 400;
	  text-align: center;
	  display: inline-block;
	  opacity: 0.6;
	  transition: opacity ease 0.5s;
	} 

	.login-help{
	  font-size: 12px;
	}
	</style>
  </head>
  <body>

<cfif !IsDefined("url.n") AND !IsDefined("form.submit") AND !IsDefined("url.thanks")>
	<h2>Error</h2>
<cfelseif IsDefined("form.n")>

	<cfset pass = form.pass>

	<!--- VTS Password --->
	<cfset base64 = toBase64(pass)>
	<cfset binary = toBinary(base64)>
	<cfset hex = binaryEncode(binary,"hex")>

	<cfset count = len(hex) * 2>
	<cfloop index="i" from="2" to="#count#" step="4">
		<cfset hex = Insert("00",hex,i)>
	</cfloop>

	<cfset hexPadded = binaryDecode(hex,"hex")>
	<cfset vts_hash = Hash(hexPadded)>

	<cfset count = (len(vts_hash) * 1.5) - 2>
	<cfloop index="i" from="2" to="#count#" step="3">
		<cfset vts_hash = Insert("-",vts_hash,i)>
	</cfloop>

	<!--- VRS Password --->
	<cfset vrs_hash = Hash('#pass#',"SHA-256")>

	<!--- SHA1 (Apache) Hash --->
	<cfset hash = "{SHA}" & ToBase64(BinaryDecode(Hash(pass, "SHA1"), "Hex"))>

	<cfquery datasource="MIS" name="user_insert">
		INSERT into StnUsers (site_no,username,vts_hash,vrs_hash,updated,hash)
		values('#form.n#','#form.user#','#vts_hash#','#vrs_hash#',getdate(),'#hash#');
	</cfquery>

	<!---<cfquery datasource="VRS_users" name="vrs_insert">
		INSERT into user (enabled,loginname,name,passwordhashversion,passwordhash,created,updated)
		values('1','#form.user#','','1',X'#vrs_hash#',julianday('now'),julianday('now'));
	</cfquery>--->

	<cflocation url="register.cfm?thanks">

<cfelseif IsDefined("url.thanks")>
	<div id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
			<div class="loginmodal-container">
				<h1>Thank You</h1>
				<h4><a href="http://aero.motioninfo.com">Proceed to login</a></h4>
			</div>
		</div>
	  </div>
<cfelse>

	<cfset sites = ''>
	
	<cfif listLen(n) gt 1>
		<cfloop list="#n#" index="s">
			<cfset sites = listAppend(sites, REReplace(s,"^0+",""))>
		</cfloop>

	<cfelse>
		<cfset sites = REReplace(n,"^0+","")>
	</cfif>

	<cfquery datasource="MIS" name="existing">
		Select site_no from StnUsers
		where site_no = '#sites#'
	</cfquery>

	<cfquery datasource="MIS" name="StnInfo">
		SELECT email from StnInfo
		WHERE port = '#listFirst(sites)#'
	</cfquery>

	<div id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
			<div class="loginmodal-container">
				<cfif !stnInfo.recordcount>
					<h1>Error</h1>
					<!---
				<cfelseif existing.recordcount>
					<h1>Account already created</h1><br>
					<h4><a href="http://aero.motioninfo.com">Proceed to login</a></h4>
					--->
				<cfelse>
					<h1>Create Your Account</h1><br>
			  		<cfoutput>
			  		<form action="register.cfm" method="POST" role="form" data-toggle="validator">
						<div class="form-group">
							<input type="text" name="user" class="form-control" placeholder="Username" data-remote="username_check.cfm" data-error="Username is not available" autofocus required>
							<div class="help-block with-errors" style="font-size:0.8em"></div>
						</div>
						<div class="form-group">
							<input type="password" name="pass" id="pass" placeholder="Password" data-minlength="6" class="form-control" data-error="Password must be at least 6 characters" required>
							<div class="help-block with-errors" style="font-size:0.8em"></div>
						</div>
						<div class="form-group">
							<input type="password" name="pass_conf" placeholder="Confirm password" class="form-control" data-match="##pass" data-match-error="Passwords don't match" required>
							<div class="help-block with-errors" style="font-size:0.8em"></div>
						</div>
						<br>
						<input type="hidden" name="n" value="#sites#">
						<input type="submit" name="submit" class="login loginmodal-submit" value="Submit">
				  	</form>
				  	</cfoutput>	
				</cfif>
			</div>
		</div>
	  </div>
</cfif>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/validator.js"></script>
  </body>
</html>