<cfinclude template="header.cfm">

<cfif isDefined("url.site")>
    <cfif listFindNoCase(cookie.site_no, url.site)>
        <cfset this_site = url.site>
    <cfelse>
        <cflocation url="index.cfm">
    </cfif>
<cfelse>
    <cfset this_site = listFirst(cookie.site_no)>
</cfif>

<cfquery dataSource="MIS" name="station"> 
    SELECT * FROM StnInfo
    WHERE port = #this_site#
</cfquery> 


<cfquery datasource="MIS" name="adsb">
	select top 25 * from adsb_count_hourly
	where site_no = #this_site#
	order by forDate desc,onHour desc
</cfquery>

<cfquery datasource="MIS" name="ais">
    select top 25 * from ais_count_hourly
    where site_no = #this_site#
    order by forDate desc,onHour desc
</cfquery>

<cfif station.laststatpost is not '' and datediff('n',station.laststatpost,now()) gt 10>
    <cfset status_icon = "glyphicon-remove-sign text-danger">
<cfelseif station.laststatpost is not '' and  datediff('n',station.laststatpost,now()) lte 10>
    <cfset status_icon = "glyphicon-ok-sign text-success">
<cfelse>
    <cfset status_icon = "glyphicon-question-sign text-warning">
</cfif>



	<div class="row">
        <div class="col-lg-12">
            <h2 class="page-header"><cfoutput>#station.name# <small><i class="glyphicon #status_icon#" title="Last Connection: <cfif len(station.laststatpost)>#dateformat(station.laststatpost,'m/d/yy')# #timeformat(station.laststatpost,'HH:MM:SS')#<cfelse>None</cfif>"></i></small></cfoutput></h2>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    ADSB Messages per hour, past 24 hours. <small>(All times are in UTC)</small>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div id="adsb-chart"></div>
                </div>
                <!-- /.panel-body -->
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    AIS Messages per hour, past 24 hours. <small>(All times are in UTC)</small>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div id="ais-chart"></div>
                </div>
                <!-- /.panel-body -->
            </div>
        </div>
    </div>

<script type="text/javascript">

$(function() {

    Morris.Area({
        element: 'adsb-chart',
        data: [
    <cfset inc = 0>
    <cfloop query="adsb">
    	<cfif inc>
    		<cfoutput>
	    	{
	            period: '#forDate# #evaluate(onHour+1)#:00',
	            adsb: '#total#'
	        }, 
	        </cfoutput>
    	</cfif>
        <cfset inc++>
    </cfloop>
        ],
        xkey: 'period',
        ykeys: ['adsb'],
        labels: ['ADSB'],
        pointSize: 2,
        hideHover: 'auto',
        resize: true,
        xLabelAngle: 45
    });

    Morris.Area({
        element: 'ais-chart',
        data: [
    <cfset inc = 0>
    <cfloop query="ais">
        <cfif inc>
            <cfoutput>
            {
                period: '#forDate# #evaluate(onHour+1)#:00',
                ais: '#total#'
            }, 
            </cfoutput>
        </cfif>
        <cfset inc++>
    </cfloop>
        ],
        xkey: 'period',
        ykeys: ['ais'],
        labels: ['AIS'],
        pointSize: 2,
        hideHover: 'auto',
        resize: true,
        xLabelAngle: 45
    });

});


</script>

<cfinclude template="footer.cfm">