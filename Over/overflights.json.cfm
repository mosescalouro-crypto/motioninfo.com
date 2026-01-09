<cfsetting requesttimeout="60000">

<cfquery datasource="REPORTS" name="flights">
	select (
		SELECT TOP 10 JSON_QUERY(dbo.geometry2json(multipoint.ToString())) as geometry 
		from overflightssolved 
		where OverflightDistance <> 0
		and op = 'overflight' 
		FOR JSON AUTO
		) as json
</cfquery>

<cfset json = RemoveChars(flights.json, 1, 2)>
<cfsavecontent variable="output">
{
  "type": "FeatureCollection",
  "features": [
    {
    	"type": "Feature",
   		<cfoutput>#json#</cfoutput>}
</cfsavecontent>

<cffile action="write"
		file="#application.path#/overflights/json/bahamas_#dateformat(now(),'YYYYMMDD')#.json"
		output="#output#">