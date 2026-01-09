<cfif isDefined("url.res_id")>
	<cfquery dataSource="OAG" name="res"> 
	  SELECT * FROM reservations
	  where id = #url.res_id#
	</cfquery>

	<cfif res.recordcount>
		<cfset date = dateFormat(res.departure, "yyyy-mm-dd")>
		<cfset hr = dateFormat(res.departure, "H")>
		<cfset currentSlot = evaluate(evaluate(timeFormat(res.departure, "n") / 15) + 1)>
	<cfelse>
		Error.
		<cfabort>
	</cfif>
<cfelseif isDefined("url.date") and isDefined("url.hr") and isDefined("url.ap")>
	<cfif url.ap eq 'PM' and hr neq 12>
		<cfset hr = evaluate(url.hr + 12)>
	<cfelse>
		<cfset hr = url.hr>
	</cfif>
	<cfset date = '#url.date#'>
	<cfset currentSlot = 0>
<cfelse>
	Error.
	<cfabort>
</cfif>

<cfquery dataSource="OAG" name="flights"> 
  SELECT * FROM flights_15Min
  WHERE ForDate = '#date#'
  and OnHour = #hr#
  UNION
  SELECT * FROM reservations_15Min
  WHERE ForDate = '#date#'
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
			<label class="slot btn btn-success tooltip-success<cfif s eq currentSlot> active</cfif>" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus" title="No Delay" data-content="#slots['#s#']# of 12 Slots Filled">
				<input type="radio" name="slot" value="#hr#:#numberformat(inc,'00')#" autocomplete="off"<cfif s eq currentSlot> checked</cfif> required> #timeformat("#hr#:#numberformat(inc,'00')#","h:nn tt")#
			</label>
		<cfelseif slots['#s#'] gte 10 and slots['#s#'] lt 12>
			<label class="slot btn btn-warning tooltip-warning<cfif s eq currentSlot> active</cfif>" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus" title="Potential Delay" data-content="#slots['#s#']# of 12 Slots Filled">
				<input type="radio" name="slot" value="#hr#:#numberformat(inc,'00')#" autocomplete="off"<cfif s eq currentSlot> checked</cfif> required> #timeformat("#hr#:#numberformat(inc,'00')#","h:nn tt")#
			</label>
		<cfelse>
			<label class="slot btn btn-danger tooltip-danger<cfif s eq currentSlot> active</cfif>" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus" title="Certain Delay" data-content="#slots['#s#']# of 12 Slots Filled">
				<input type="radio" name="slot" value="#hr#:#numberformat(inc,'00')#" autocomplete="off"<cfif s eq currentSlot> checked</cfif> required> #timeformat("#hr#:#numberformat(inc,'00')#","h:nn tt")#
			</label>
		</cfif>
	<cfelse>
		<label class="slot btn btn-success tooltip-success<cfif s eq currentSlot> active</cfif>" data-container="body" data-toggle="popover" data-placement="top" data-trigger="focus" data-content="0 of 12 Slots Filled">
			<input type="radio" name="slot" value="#hr#:#numberformat(inc,'00')#" autocomplete="off"<cfif s eq currentSlot> checked</cfif> required> #timeformat("#hr#:#numberformat(inc,'00')#","h:nn tt")#
		</label>
	</cfif>
	</cfoutput>
  <cfset inc = evaluate(inc+15)>
</cfloop>