

<cfif structKeyExists(FORM,"submit")>
	
		<cfif (parameterexists(form.human) and form.human eq 'SYUWCY') or parameterexists(form.locid)>
		
			<cfmail to='mjc@mgn.com' from='mjc@mgn.com' subject='Motion Info ADS-B Contact Form: #fname# #lname# #company#'>			
			Name: #fname# #lname#
			Email: #email#
			Phone: #phone#
			Company: #company# <cfif parameterexists(form.locid)>(#form.locid#)</cfif>
			Comments: #comments# 
			Reason: #reason#
			</cfmail>			
			
			<cfquery datasource='MIS' name='contactform'>
			insert into motioninfo_contactform(first_name,last_name,Email,Phone,Company,LocationID,Comments,Reason)
			values('#fname#','#lname#','#email#','#phone#','#company#','<cfif parameterexists(form.locid)>#form.locid#</cfif>','#comments#','#reason#')
			</cfquery>		
			
			<cflocation url='index.cfm?contactform##contact'>
		<cfelse>
			<h3>Captcha invalid, please go back and try again</h3>
		</cfif>
</cfif>		


	
				
		