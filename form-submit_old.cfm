

<cfif structKeyExists(FORM,"submit")>
	
	<cfset recaptcha = FORM["g-recaptcha-response"] >
	<cfif len(recaptcha)>
		
		<cfset googleUrl = "https://www.google.com/recaptcha/api/siteverify">
		<cfset secret = "6Ld1DzEUAAAAALk_yV0CXr22JaW8ZPYhWRY0ZAOl">
		<cfset ipaddr = CGI.REMOTE_ADDR>
		<cfset request_url = googleUrl & "?secret=" & secret & "&response=" & recaptcha & "&remoteip" & ipaddr>
		
		<cfhttp url="#request_url#" method="get" timeout="10">
		
		<cfset response = deserializeJSON(cfhttp.filecontent)>
		<cfif response.success eq "YES">
		
			<cfmail to='mjc@mgn.com' bcc='ben@mgn.com' from='mjc@mgn.com' subject='Motion Info ADS-B Contact Form: #fname# #lname# #company#'>			
			Name: #fname# #lname#
			Email: #email#
			Phone: #phone#
			Company: #company#
			Facility: #facility#
			State: #state#
			Comments: #comments# 
			</cfmail>
			

			<cflocation url='index.cfm?contactform##contact'>
			
			<!--- Start validating the username/password here. --->
		</cfif>	
	</cfif>	
</cfif>		


	
				
		