<cfif isDefined("url.user")>
	<cfif len(url.user) gte 6>
		<cfquery datasource="MIS" name="usercheck">
			SELECT username from StnUsers
			where username = '#url.user#'
		</cfquery>
		<cfif usercheck.recordcount>
			<cfthrow>
		</cfif>
	<cfelse>
		<cfthrow>
	</cfif>
</cfif>