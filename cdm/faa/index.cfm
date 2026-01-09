<cflocation url="http://cdm.misdevelopment.com/faa">
<!----- EXCEL ---->
<cfif isdefined('form.excel') and isdefined('form.report')>

<cffile action="WRITE" file="#application.basepath#/export/report_#dateFormat(d,'ddmmyyyy')#.xls" output="
<cfcontent type='application/ms-excel'>
#form.report#
" addnewline="Yes">

<cflocation url="./export/report_#dateFormat(d,'ddmmyyyy')#.xls">
</cfif>

<cfinclude template="../header.cfm">

<style>
	.btn-xs {
		padding: 2px 5px 0 4px;
	}
</style>

<div class="row">
	<div class="col-lg-12">
		<h2 class="page-header"><cfoutput>Delay Mitigation Tool (Admin)</cfoutput>
		<div class="pull-right">
			<div class="btn-group" role="group" aria-label="...">
			  <a href="index.cfm?d=<cfoutput>#dateFormat(dateAdd('d',d,-1),'#application.dateformat#')#</cfoutput>" class="btn btn-md btn-primary"><i class="fa fa-chevron-left" aria-hidden="true"></i>&nbsp;&nbsp;Prev Day</a>
			  <a href="index.cfm" class="btn btn-md btn-primary">Today</a>
			  <a href="index.cfm?d=<cfoutput>#dateFormat(dateAdd('d',d,1),'#application.dateformat#')#</cfoutput>" class="btn btn-md btn-primary">Next Day&nbsp;&nbsp;<i class="fa fa-chevron-right" aria-hidden="true"></i></a>
			</div>
			<a class="btn btn-md btn-primary" role="button" data-toggle="popover" data-trigger="click" 
            data-placement="bottom" data-container="body" data-html="true" data-content='<div id="popover-content"><div id="calendar"></div></div>'><i class="fa fa-calendar" aria-hidden="true"></i></a>
		</div>
		</h2>
	</div>
</div>

<div class="row">
  <div class="col-lg-12">
      <div class="panel panel-default">
          <div class="panel-heading">
              <h3 class="panel-title">All Scheduled LAS Departures by hour - <cfoutput>#d#</cfoutput></h3>
          </div>
          <!-- /.panel-heading -->
          <div class="panel-body">
              <cfinclude template="../res_chart.cfm">
          </div>
          <!-- /.panel-body -->
      </div>
  </div>
</div>

<cfquery datasource="#application.datasource#" name="reservations">
	SELECT * from reservations r
	inner join users u on r.user_id = u.id
	and departure >= DATEADD(DAY, 0, DATEDIFF(DAY, 0, '#d#'))
	and departure <  DATEADD(DAY, 1, DATEDIFF(DAY, 0, '#d#'))
	and r.archived = 0
	order by fbo_id,departure asc
</cfquery>

<cfsavecontent variable="report">
	<h2><cfoutput>GA Reservation Report for #d#</cfoutput></h2>
	<table>
		<thead>
			<tr>
				<th align=left>Tail No.</th>
				<th align=left>FBO</th>
				<th align=left>Sched. Departure</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="reservations">
				<cfquery datasource="#application.datasource#" name="fbo">
					select name from fbos
					where id = '#fbo_id#'
				</cfquery>
				<tr>
					<td align=left>#reg#</td>
					<td align=left>#fbo.name#</td>
					<td align=left>#timeFormat(departure,'h:mm tt')#</td>
				<tr>
			</cfoutput>
		</tbody>
	</table>
</cfsavecontent>

<div class="row">
	<div class="col-lg-8">
		<div class="panel panel-default">
			<div class="panel-heading">
			  <form method="post">
			  	<input type="hidden" name="report" value="<cfoutput>#report#</cfoutput>">
			  	<!---<input type="submit" name="excel" class="btn btn-sm btn-primary pull-right" value="Export to Excel">--->
			  </form>
			  <h3 class="panel-title">GA Reservations for <cfoutput>#d#</cfoutput></h3>
			</div>
			<table class="table table-responsive table-striped table-bordered table-hover table-condensed">
				<thead>
					<tr>
						<th>Tail No.</th>
						<th>FBO</th>
						<th>Sched. Departure</th>
					</tr>
				</thead>
				<tbody>
					<cfoutput query="reservations">
						<cfquery datasource="#application.datasource#" name="fbo">
							select name from fbos
							where id = '#fbo_id#'
						</cfquery>
						<tr>
							<td>#reg#</td>
							<td>#fbo.name#</td>
							<td>#timeFormat(departure,'h:mm tt')#</td>
						<tr>
					</cfoutput>
				</tbody>
			</table>
		</div>
	</div>
</div>

<cfinclude template="../footer.cfm">