<cfquery datasource="REPORTS" name="track">
	select (
		SELECT JSON_QUERY(dbo.geometry2json(multipoint.ToString())) as geometry 
			from overflights
			where id = #url.id#
			FOR JSON AUTO
		) as json
</cfquery>

<cfset json = RemoveChars(track.json, 1, 2)>
<cfoutput>
{
  "type": "FeatureCollection",
  "features": [
    {
    	"type": "Feature",
   		#json#}
</cfoutput>