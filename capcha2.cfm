<cfparam name="FORM.username" default="" type="string" >
<cfparam name="FORM.password" default="" type="string" >

<cfif structKeyExists(FORM,"submit")>
	
	<cfset recaptcha = FORM["g-recaptcha-response"] >
	<cfif len(recaptcha)>
		
		<cfset googleUrl = "https://www.google.com/recaptcha/api/siteverify">
		<cfset secret = "6LeXLB4UAAAAAKo94EEImooeByasH7DXrN3CmBRh">
		<cfset ipaddr = CGI.REMOTE_ADDR>
		<cfset request_url = googleUrl & "?secret=" & secret & "&response=" & recaptcha & "&remoteip" & ipaddr>
		
		<cfhttp url="#request_url#" method="get" timeout="10">
		
		<cfset response = deserializeJSON(cfhttp.filecontent)>
		<cfif response.success eq "YES">123 312 123
		
		<cfdump var=#form#>AAA
			<!--- Start validating the username/password here. --->
		</cfif>	
	</cfif>	
</cfif>		