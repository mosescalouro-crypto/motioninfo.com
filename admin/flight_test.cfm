<cfif isDefined("url.hour")>
	<cfset hr = url.hour>
<cfelse>
	<cfset hr = 8>
</cfif>

<cfset t='#DateAdd('h',hr,'11/20/2017 00:00')#'>

<cfset dephr='#timeformat(t,'HHMM')#'>
<cfset depdate='#dateformat(t,'yyyymmdd')#'>
<cfset depap='LAS'>

<cfoutput>
<b>#depdate# #dephr# PST</b>
</cfoutput>

<cfhttp url="http://xml.flightview.com/fvmaritimeinfosys/fvxml.exe" method="get">
     <cfhttpparam type="url" name="depap" value="LAS">      
     <cfhttpparam type="url" name="dephr" value="#dephr#">  
     <cfhttpparam type="url" name="depdate" value="#Depdate#">
</cfhttp>

<table>
	<tr>
		<td>Flight</td>
		<td>Sched Dep</td>
	</tr>

<cfset response="#xmlparse(cfhttp.FileContent)#">
<cfdump var=#response#><cfabort>

<cfloop array="#response.FlightViewResults.Flight#" index="i">
	<cfset DepSched = i.departure.DateTime[1].Date.xmltext & " " & i.departure.DateTime[1].Time.XmlAttributes.utc>
	<cfoutput>
		<tr>
			<td>#ListFirst(i.XmlAttributes.FlightId,":")#</td>
			<td>#DepSched# UTC</td>
		</tr>
	</cfoutput>
</cfloop>
</table>