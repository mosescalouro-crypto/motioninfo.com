<cfquery datasource="REPORTS" name="zone">
	select (
		SELECT JSON_QUERY( dbo.geometry2json(polygon.ToString())) as geometry from zones where zonename='#url.z#' FOR JSON AUTO
		) as json
</cfquery>

<cfset json = RemoveChars(zone.json, 1, 2)>
<cfoutput>
{
  "type": "FeatureCollection",
  "features": [
    {
    	"type": "Feature",
   		#json#}
</cfoutput>