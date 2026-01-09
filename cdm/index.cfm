<cflocation url="http://cdm.misdevelopment.com">
<cfif !isDefined("url.noAuthView")>
    <cflocation url="./secure/">
</cfif>

<cfinclude template="header.cfm">

  <div class="row">
      <div class="col-lg-12">
          <h2 class="page-header">Delay Mitigation Tool</h2>
      </div>
  </div>

  <div class="row">
	  <div class="col-lg-12">
	      <div class="panel panel-default">
	          <div class="panel-heading">
	              <h3 class="panel-title">Reservations by hour for <cfoutput>#d#</cfoutput></h3>
	          </div>
	          <!-- /.panel-heading -->
	          <div class="panel-body">
	              <cfinclude template="res_chart.cfm">
	          </div>
	          <!-- /.panel-body -->
	      </div>
	  </div>
	</div>

<cfinclude template="footer.cfm">