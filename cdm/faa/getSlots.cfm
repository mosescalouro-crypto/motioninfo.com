<cfif isDefined("url.date") and isDefined("url.hr") and isDefined("url.ap")>
	<cfif url.ap eq 'PM' and hr neq 12>
		<cfset hr = evaluate(url.hr + 12)>
	<cfelse>
		<cfset hr = url.hr>
	</cfif>
	<cfquery dataSource="OAG" name="flights"> 
	  SELECT * FROM flights_15Min
	  WHERE ForDate = '#url.date#'
	  and OnHour = #hr#
	  UNION
	  SELECT * FROM reservations_15Min
	  WHERE ForDate = '#url.date#'
	  and OnHour = #hr#
	</cfquery>

	<cfset slots = ArrayNew(1)>
	<cfoutput query="flights">
		<cfif ArrayIsDefined(slots,quarter)>
			<cfset slots["#quarter#"] = evaluate(flightcount + slots["#quarter#"])>
		<cfelse>
			<cfset slots["#quarter#"] = #flightcount#>
		</cfif>
	</cfoutput>

	<cfset inc = 0>
	<cfloop from="1" to="4" index="s">
		<cfoutput>
		<cfif ArrayIsDefined(slots,s)>
			<cfif slots['#s#'] lt 10>
				<label class="btn btn-success tooltip-success" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus" title="No Delay" data-content="#slots['#s#']# of 12 Slots Filled">
					<input type="radio" name="slot" value="#hr#:#numberformat(inc,'00')#" autocomplete="off"> #timeformat("#hr#:#numberformat(inc,'00')#","h:nn tt")#
				</label>
			<cfelseif slots['#s#'] gte 10 and slots['#s#'] lt 12>
				<label class="btn btn-warning tooltip-warning" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus" title="Potential Delay" data-content="#slots['#s#']# of 12 Slots Filled">
					<input type="radio" name="slot" value="#hr#:#numberformat(inc,'00')#" autocomplete="off"> #timeformat("#hr#:#numberformat(inc,'00')#","h:nn tt")#
				</label>
			<cfelse>
				<label class="btn btn-danger tooltip-danger" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus" title="Certain Delay" data-content="#slots['#s#']# of 12 Slots Filled">
					<input type="radio" name="slot" value="#hr#:#numberformat(inc,'00')#" autocomplete="off"> #timeformat("#hr#:#numberformat(inc,'00')#","h:nn tt")#
				</label>
			</cfif>
		<cfelse>
			<label class="btn btn-success tooltip-success" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus" data-content="0 of 12 Slots Filled">
				<input type="radio" name="slot" value="#hr#:#numberformat(inc,'00')#" autocomplete="off"> #timeformat("#hr#:#numberformat(inc,'00')#","h:nn tt")#
			</label>
		</cfif>
		</cfoutput>
	  <cfset inc = evaluate(inc+15)>
	</cfloop>
<cfelse>
	Error.
</cfif>