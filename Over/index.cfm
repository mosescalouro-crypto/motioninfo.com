<cfinclude template="header.cfm">

<style>
.statusIcon {
    font-size:1.3em;
}

.statusIcon span {
    display: none;
}

.pagination { margin: 0 !important;}

.dataTable_wrapper { padding: 10px; }
</style>

<cfquery datasource="reports" name="ops">
    select * from overflights
where 0=0 
--and overflightdistance <> 0
		<cfif isDefined("url.overflights")>
       and op =  'overflight'
        <cfelseif isDefined("url.arrivals")>
       and op =  'arrival'
        <cfelseif isDefined("url.departures")>
       and op =  'departure'
        <cfelseif isDefined("url.inzone")>
      and op =  'in zone'
        <cfelseif isDefined("url.all")>	  
		</cfif>
		order by optime,icao
</cfquery>

	<div class="row">
                    <div class="col-lg-12">
                        <h2 class="page-header"><cfif isDefined("url.inzone")>In Zone <cfelseif isDefined("url.all")>All <cfelseif isDefined("url.arrivals")>Arrival <cfelseif isDefined("url.departures")>Departure <cfelseif isDefined("url.overflights")>Overflight </cfif> Operations</h2>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                              Total: <cfoutput>#ops.recordcount#</cfoutput>
                            </div>
                            <!-- /.panel-heading -->
                            <div class="dataTable_wrapper table-responsive">
                                <table class="table table-condensed table-striped table-bordered table-hover" id="dataTable">
                                    <thead>								
										<tr>
    										<th>UTC</th>
    										<th>LOCAL</th>
    										<th>OP</th>
    										<th>REG</th>
											<!---
    										<th>ICAO</th>
    										<th>ICAO24</th>
											--->
											<th>FROM</th>
											<th>TO</th>
    										<th>MFR</th>
    										<th>MODEL</th>	
    										<th>CALL SIGN</th>
    										<th>OPERATOR</th>
                                            <th>FEE</th>
											<th>DIST.</th>
                                            <th></th>
										</tr>
                                    </thead>
                                    <tbody>
									
									  <cfoutput query=ops>
									   <tr class="gradeA">
									    <td class="center">#dateformat(OPTIME)# #timeformat(optime,'HH:MM')#</td>
	    <td class="center">#dateformat(dateadd('h',-5,OPTIME))# #timeformat(dateadd('h',-5,OPTIME),'HH:MM')#
		<!---#dateformat(dateadd('h',-5,OPTIME),'D-MMM')# #timeformat(dateadd('h',-5,OPTIME),'HH:MM')#---></td>
										<td class="center">#op#</td>
										<td class="center">#reg#</td>
										<!---
										<td class="center">#icao#</td>
										<td class="center">#icao24#</td>
										---->
										<td class="center">#departurepoint#</td>
										<td class="center">#arrivalpoint#</td>
										<td class="center">#left(MFR,15)#</td>
										<td class="center">#left(MODEL,15)#</td>
										<td class="center">#CALLSIGN#</td>
										<td class="center"><cfif len(operator) lte 3>#OPERATOR#</cfif></td>
										<td class="center">$#fee#</td>
										<td class="center">#overflightdistance#</td>
									      <td class="center">
										  <cfif overflightdistance gt 0><a href="map.cfm?id=#id#"><i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i> Map</a></cfif></td>
										</tr>
									  </cfoutput>
									  
                                    </tbody>
                                </table>
                            </div>                             
                        </div>
                        <!-- /.panel -->
                    </div>
                    <!-- /.col-lg-12 -->
                </div>

<!-- DataTables JavaScript -->
<script src="/js/dataTables/jquery.dataTables.min.js"></script>
<script src="/js/dataTables/dataTables.bootstrap.min.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $('#dataTable').DataTable({
                responsive: true,
                "iDisplayLength": 50,
                "aaSorting": [],
                dom: "<'row'<'col-sm-4'l><'col-sm-4'f><'col-sm-4'p>>" +
                        "<'row'<'col-sm-12'tr>>" +
                    "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        });
    });
</script>

</body>
</html>