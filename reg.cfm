
<!---
<cfoutput>
URL: #url.l#
</cfoutput>
<cfabort>
--->

<cfif !IsDefined("url.l") and url.port is not null>
	<h2>Error</h2>
<cfelse>


			<cfquery datasource='MIS' name='loc'>
			select top 1 isnull(port,0) port from stninfo where locationid='#ltrim(url.l)#' and status in (1,3) order by id
			</cfquery>
			<cfset sites=#loc.port#>	
			
			<cflocation url='/register.cfm?n=#sites#'>
			
			
</cfif>
