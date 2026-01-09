<cfif isDefined("url.id")>
	<cfquery dataSource="OAG" name="status"> 
		select status from reservations
		where id = #url.id#
		and fbo_id = #cookie.fboid#
	</cfquery>

	<cfquery dataSource="OAG" name="update">
		UPDATE reservations
		set status = <cfif status.status>0<cfelse>1</cfif>
		where id = #url.id#
		and fbo_id = #cookie.fboid#
	</cfquery>

	<cfif status.status>
		<button class="btn btn-xs btn-danger res_status" title="Toggle Status" id="<cfoutput>#url.id#</cfoutput>">Not Ready</button>
	<cfelse>
		<button class="btn btn-xs btn-success res_status" title="Toggle Status" id="<cfoutput>#url.id#</cfoutput>">Ready</button>
	</cfif>
<cfelse>
	Error.
</cfif>