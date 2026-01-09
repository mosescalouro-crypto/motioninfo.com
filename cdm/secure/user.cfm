<cfif isDefined("form.submit")>
	<cfquery datasource="#application.datasource#" name="update">
		update users
		set name = '#form.name#',
			reg = '#form.reg#',
			pin = '#form.pin#',
			email = '#form.email#',
			phone = '#form.phone#'
		where id = #form.user_id#
	</cfquery>
</cfif>

<cfif isDefined("url.user_id")>
	<cfquery datasource="#application.datasource#" name="user">
		select * from users
		where id = #url.user_id#
	</cfquery>

<cfinclude template="../header.cfm">

<cfoutput query="user">
<h2 class="page-header">Manage User Details - #reg#
	<div class="pull-right">
	  <a href="index.cfm" class="btn btn-md btn-primary"><i class="fa fa-chevron-left" aria-hidden="true"></i>&nbsp;&nbsp;Back to Reservations</a>
	</div>
</h2>
<div class="row">
	<div class="col-md-6">
		<form method="POST" role="form" data-toggle="validator">
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
              	<label for="name">Name</label>
                <input type="text" name="name" class="form-control" placeholder="(optional)" value="#name#">
                <div class="help-block with-errors" style="font-size:0.8em"></div>
              </div>
              <div class="form-group">
              	<label for="reg">Tail Number</label>
                <input type="text" name="reg" class="form-control" placeholder="Tail Number" value="#reg#" required>
                <div class="help-block with-errors" style="font-size:0.8em"></div>
              </div>
              <div class="form-group">
              	<label for="pin">Login Pin</label>
                <input type="text" name="pin" id="pass" placeholder="PIN" data-minlength="4" value="#pin#" class="form-control" data-error="PIN must be at least 4 numbers" required>
                <div class="help-block with-errors" style="font-size:0.8em"></div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
              	<label for="email">Email Address</label>
                <input type="text" name="email" class="form-control" placeholder="(optional)" value="#email#">
                <div class="help-block with-errors" style="font-size:0.8em"></div>
              </div>
              <div class="form-group">
              	<label for="phone">Phone Number</label>
                <input type="text" name="phone" class="form-control" placeholder="(optional)" value="#phone#">
                <div class="help-block with-errors" style="font-size:0.8em"></div>
              </div>
            </div>
          </div>
          <input type="hidden" name="user_id" value="#url.user_id#">
          <input type="submit" name="submit" class="btn btn-primary" value="Submit">
        </form>
	</div>
</div>
</cfoutput>

<cfelse>
	<h3>User not specified</h3>
</cfif>

<cfinclude template="../footer.cfm">