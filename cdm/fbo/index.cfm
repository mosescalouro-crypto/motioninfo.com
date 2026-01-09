<cflocation url="http://cdm.misdevelopment.com/fbo">
<cfif isDefined("url.delete")>
	<cfquery datasource="#application.datasource#" name="delete">
		delete from reservations
		where id = #url.delete#
	</cfquery>
</cfif>

<cfif isDefined("url.sendInfo")>
	<cfquery datasource="#application.datasource#" name="contact">
		SELECT * from users
		where id = '#url.sendInfo#'
	</cfquery>

	<cfoutput query="contact">
		<cfmail to="#email#"
				from="McCarran Departure Management <cdm@mgn.com>"
				subject="Test contact details"
				type="html">
		<cfinclude template="../email_top.cfm">

		<h3 style="font-family: sans-serif; font-size: 20px; font-weight: normal; margin: 0; Margin-bottom: 30px;">Welcome to CDM!</h2>
		<p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Good day<cfif len(name)> #name#</cfif>,</p>
        <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Please use the following credentials to connect to the <a href="http://motioninfo.net/cdm/secure/">McCarran departure management system</a>:</p>
        <ul style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">
			<li>Tail Number: #reg#</li>
			<li>Pin: #pin#</li>
		</ul>
        <table border="0" cellpadding="0" cellspacing="0" class="btn btn-primary" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; box-sizing: border-box; width: 100%;" width="100%">
          <tbody>
            <tr>
              <td align="left" style="font-family: sans-serif; font-size: 14px; vertical-align: top; padding-bottom: 15px;" valign="top">
                <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: auto;">
                  <tbody>
                    <tr>
                      <td style="font-family: sans-serif; font-size: 14px; vertical-align: top; border-radius: 5px; text-align: center; background-color: ##3498db;" valign="top" align="center" bgcolor="##3498db"> <a href="http://motioninfo.net/cdm/secure/" target="_blank" style="border: solid 1px ##3498db; border-radius: 5px; box-sizing: border-box; cursor: pointer; display: inline-block; font-size: 14px; font-weight: bold; margin: 0; padding: 12px 25px; text-decoration: none; text-transform: capitalize; background-color: ##3498db; border-color: ##3498db; color: ##ffffff;">Manage Departure Intentions</a> </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
        <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Thank you for your participation!
    	<br>
    	--Vegas McCarran Departure Management</p>

        <cfinclude template="../email_bottom.cfm">
		</cfmail>

<cfsavecontent variable="sms_body">
Welcome to CDM!

Good day<cfif len(name)> #name#</cfif>,
Please use the following credentials to connect to the McCarran departure management system:
http://motioninfo.net/cdm/secure
Tail Number: #reg#
Pin: #pin#
</cfsavecontent>

		<cfhttp url="https://api.twilio.com/2010-04-01/Accounts/TWILIO_SID_REMOVED/Messages" method="post" resolveurl="no" username="TWILIO_SID_REMOVED" password="TWILIO_TOKEN_REMOVED" result="httpResponse">
	    <cfhttpparam name="To" type="formfield" value="#phone#">
	    <cfhttpparam name="From" type="formfield" value="17023811787">
		<!---
	    <cfhttpparam name="StartTime" type="url" value="2017-12-08">
	    <cfhttpparam name="EndTime" type="url" value="2017-12-09">
		--->
	    <cfhttpparam name="Body" type="formfield" value="#sms_body#">
	  </cfhttp>
	</cfoutput>

	<cflocation url="index.cfm?d=#d#&sent">
</cfif>

<cfif isDefined("form.reg") and isDefined("form.slot")>
	<cfquery datasource="#application.datasource#" name="who">
		select name from fbos
		where id = '#cookie.fboid#'
	</cfquery>
	<cfset whodunnit = who.name>

	<cfset edit_res = form.edit_id>
	<cfset edit_user = form.user_id>

	<cfquery datasource="#application.datasource#" name="existing">
		SELECT top 1 r.id,r.user_id,r.departure,r.status,u.reg from reservations r
		inner join users u on r.user_id = u.id
		where u.reg = '#ucase(form.reg)#'
		and r.departure >= getdate()
		and r.archived = 0
		order by departure asc
	</cfquery>

	<cfif existing.recordcount>
		<cfset edit_res = existing.id>
		<cfset edit_user = existing.user_id>
	</cfif>

	<cfif len(edit_res)>
		<cfquery datasource="#application.datasource#" name="archive">
			update reservations
			set archived = 1
			where id = '#edit_res#'
		</cfquery>
		<cfset user_id = edit_user>
	</cfif>

	<cfif len(form.pin)>
		<cfset pin = form.pin>
	<cfelse>
		<cfset pin = RandRange(1000, 9999, "SHA1PRNG")>
	</cfif>

	<cfif !len(form.user_id)>
		<cfquery datasource="#application.datasource#" result="newuser">
			INSERT into users (reg,pin)
			VALUES ('#ucase(form.reg)#',
					'#pin#')
		</cfquery>

		<cfset user_id = newuser.generatedkey>
	<cfelse>
		<cfset user_id = form.user_id>
	</cfif>

	<cfquery datasource="#application.datasource#" name="insert">
		INSERT into reservations (user_id,fbo_id,departure,ip,entered_by)
		VALUES (#user_id#,
				#cookie.fboid#,
				'#form.d# #form.slot#',
				'#CGI.REMOTE_ADDR#',
				'#whodunnit#')
	</cfquery>

	<cfquery datasource="#application.datasource#" name="userUpdate">
		update users
		set name = '#form.name#',
			phone = '#form.phone#',
			email = '#form.email#',
			pin = '#pin#'
		where id = '#user_id#'
	</cfquery>

<cfelseif isDefined("form.submit")>
	<script>alert("You must choose a departure window and an aircraft");</script>
</cfif>

<!----- EXCEL ---->
<cfif isdefined('form.excel') and isdefined('form.report')>

<cffile action="WRITE" file="#application.basepath#/export/report_#dateFormat(d,'ddmmyyyy')#.xls" output="
<cfcontent type='application/ms-excel'>
#form.report#
" addnewline="Yes">

<cflocation url="./export/report_#dateFormat(d,'ddmmyyyy')#.xls">
</cfif>

<cfquery datasource="#application.datasource#" name="fbo">
	select * from fbos
	where id = #cookie.fboid#
</cfquery>

<cfinclude template="../header.cfm">

<style>
	.btn-xs {
		padding: 2px 5px 0 4px;
	}
</style>

<div class="row">
	<div class="col-lg-12">
		<h2 class="page-header"><cfoutput>LAS Departure Manager for FBO #fbo.name#</cfoutput>
		<div class="pull-right">
			<div class="btn-group" role="group" aria-label="...">
			  <a href="index.cfm?d=<cfoutput>#dateFormat(dateAdd('d',d,-1),'#application.dateformat#')#</cfoutput>" class="btn btn-md btn-primary"><i class="fa fa-chevron-left" aria-hidden="true"></i>&nbsp;&nbsp;Prev Day</a>
			  <a href="index.cfm?d=<cfoutput>#dateFormat(now(),'#application.dateformat#')#</cfoutput>" class="btn btn-md btn-primary">Today</a>
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
              <h3 class="panel-title">All Scheduled LAS Departures by hour - <cfoutput>#dateformat(d,'#application.dateFormat_verbose#')#</cfoutput></h3>
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
	where r.fbo_id = #cookie.fboid#
	and departure >= DATEADD(DAY, 0, DATEDIFF(DAY, 0, '#d#'))
	and departure <  DATEADD(DAY, 1, DATEDIFF(DAY, 0, '#d#'))
	and r.archived = 0
	order by departure asc
</cfquery>

<cfsavecontent variable="report">
	<h2><cfoutput>Reservation Report for FBO #fbo.name# - #d#</cfoutput></h2>
	<table>
		<thead>
			<tr>
				<th align=left>Tail No.</th>
				<th align=left>Pilot</th>
				<th align=left>Phone</th>
				<th align=left>Email</th>
				<th align=left>Sched. Departure</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="reservations">
				<tr>
					<td align=left>#reg#</td>
					<td align=left>#name#</td>
					<td align=left>#phone#</td>
					<td align=left>#email#</td>
					<td align=left>#timeFormat(departure)#</td>
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
			  	<input type="submit" name="excel" class="btn btn-sm btn-primary pull-right" value="Export to Excel">
			  </form>
			  <h3 class="panel-title"><cfoutput>#fbo.name#</cfoutput> Reservations</h3>
			</div>
			<table class="table table-responsive table-striped table-bordered table-hover table-condensed" id="resTable">
				<thead>
					<tr>
						<th>Tail No.</th>
						<th>Pilot</th>
						<th>Phone</th>
						<th>Email</th>
						<th>Sched. Departure</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<cfoutput query="reservations">
						<tr>
							<td onClick="goEdit('#id#','#user_id#','#reg#','#name#','#phone#','#email#','#pin#'); $(this).parent().addClass('info');">#reg#</td>
							<td onClick="goEdit('#id#','#user_id#','#reg#','#name#','#phone#','#email#','#pin#'); $(this).parent().addClass('info');">#name#</td>
							<td onClick="goEdit('#id#','#user_id#','#reg#','#name#','#phone#','#email#','#pin#'); $(this).parent().addClass('info');">#phone#</td>
							<td onClick="goEdit('#id#','#user_id#','#reg#','#name#','#phone#','#email#','#pin#'); $(this).parent().addClass('info');"><a href="mailto:#email#" title="Compose Email">#email#</a></td>
							<td onClick="goEdit('#id#','#user_id#','#reg#','#name#','#phone#','#email#','#pin#'); $(this).parent().addClass('info');">#timeFormat(departure)#</td>
							<td align="right">
								<nowrap>
									<a title="Edit" onClick="goEdit('#id#','#user_id#','#reg#','#name#','#phone#','#email#','#pin#');" class="btn btn-xs btn-success"><i class="glyphicon glyphicon-pencil" aria-hidden="true"></i></a>
									<a href="?d=#d#&sendInfo=#user_id#" title="Send text/email" class="btn btn-xs btn-warning"><i class="fa fa-paper-plane" aria-hidden="true"></i></a>
									<button class="btn btn-xs btn-danger" title="Delete" data-href="?d=#d#&delete=#id#" data-toggle="modal" data-target="##confirm-delete"><i class="glyphicon glyphicon-trash" aria-hidden="true"></i></button>
								</nowrap>
							</td>
						<tr>
					</cfoutput>
				</tbody>
			</table>
		</div>
	</div>
	<div class="col-lg-4">
		<div id="res_panel" class="panel panel-default">
			<div class="panel-heading">
			<h3 class="panel-title">New Reservation</h3>
			</div>
			<div class="panel-body">
				<form role="form" method="post" id="resForm">
					<input type="hidden" name="d" value="<cfoutput>#d#</cfoutput>">
					<fieldset>
					<div class="form-group">
					    <label class="control-label" for="departure">Departure Window</label>
						<div class="alert alert-info" style="margin-bottom:0; padding:10px;" role="alert" id="slotPlaceholder"><b>Note:</b> Click on your desired time-slot in the chart above, then refine your selection with the quarter-hour buttons that appear here.</div>
						<div id="slotButtons" class="btn-group btn-group-justified" data-toggle="buttons"></div>
					</div>
					<div class="form-group">
						<label class="control-label">Tail Number <small>(Select from dropdown if present)</small></label>
						<input type="text" class="form-control" id="reg" name="reg" placeholder="Begin typing a tail number" required>
					</div>
					<span id="helpBlock" class="help-block"><b>Contact Details:</b></span>
					<div class="row">
						<div class="col-lg-8">
							<div class="form-group">
								<label for="name">Pilot</label>
								<input type="text" name="name" id="name" class="form-control" placeholder="(optional)" >
								<div class="help-block with-errors" style="font-size:0.8em"></div>
							</div>
						</div>
						<div class="col-lg-4">
							<div class="form-group">
								<label for="pin">Acct Pin</label>
								<input type="text" name="pin" id="pin" placeholder="4+ digits" data-minlength="4" class="form-control" data-error="PIN must be at least 4 numbers">
								<div class="help-block with-errors" style="font-size:0.8em"></div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-6">
							<div class="form-group">
								<label for="email">Email</label>
								<input type="text" name="email" id="email" class="form-control" placeholder="(optional)">
								<div class="help-block with-errors" style="font-size:0.8em"></div>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="form-group">
								<label for="phone">Phone</label>
								<input type="text" name="phone" id="phone" class="form-control" placeholder="(optional)">
								<div class="help-block with-errors" style="font-size:0.8em"></div>
							</div>
						</div>
					</div>
					<input type="hidden" name="user_id" id="user_id">
					<input type="hidden" name="edit_id" id="edit_id">
					<input type="submit" name="submit" class="btn btn-md btn-primary btn-block" disabled>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Confirm Delete</h4>
            </div>
        
            <div class="modal-body">
                <p>You are about to delete this reservation, this procedure is irreversible.</p>
                <p>Do you want to proceed?</p>
                <p class="debug-url"></p>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <a class="btn btn-danger btn-ok">Delete</a>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/bootstrap-multiselect.js"></script>
<link rel="stylesheet" href="/css/bootstrap-multiselect.css" type="text/css"/>

<script>
$(window).load(function(){
    $.widget('custom.mcautocomplete', $.ui.autocomplete, {
        _create: function () {
            this._super();
            this.widget().menu("option", "items", "> :not(.ui-widget-header)");
        },
        _renderMenu: function (ul, items) {
            var self = this,
                thead;
            if (this.options.showHeader) {
                table = $('<div class="ui-widget-header" style="width:100%; border:none; border-bottom:1px solid ##999"></div>');
                $.each(this.options.columns, function (index, item) {
                    table.append('<span style="padding:4px 0 3px 8px;float:left;width:' + item.width + ';">' + item.name + '</span>');
                });
                table.append('<div style="clear: both;"></div>');
                ul.append(table);
            }
            $.each(items, function (index, item) {
                self._renderItem(ul, item);
            });
        },
        _renderItem: function (ul, item) {
            var t = '',
                result = '';
            $.each(this.options.columns, function (index, column) {
                t += '<span style="padding:0 4px;float:left;width:' + column.width + ';">' + item[column.valueField ? column.valueField : index] + '</span>'
            });
            result = $('<li></li>')
                .data('ui-autocomplete-item', item)
                .append('<a class="mcacAnchor">' + t + '<div style="clear: both;"></div></a>')
                .appendTo(ul);
            return result;
        }
    });
    $("#reg").mcautocomplete({
    	position: { my : "right top", at: "right bottom" },
        showHeader: true,
        columns: [{
            name: 'Tail No.',
            width: '80px',
            valueField: 'reg'
        },{
            name: 'Pilot',
            width: '240px',
            valueField: 'name'
        }],
        select: function (event, ui) {
		    	this.value = (ui.item ? ui.item.reg : '');
		    	$('#name').val(ui.item.name);
		    	$('#pin').val(ui.item.pin);
		    	$('#email').val(ui.item.email);
		    	$('#phone').val(ui.item.phone);
		        $('#user_id').val(ui.item.user_id);
		        return false;
		},
        minLength: 1,
        autoFocus: true,
        delay: 0,
        source: "getUser.cfm"
    }).keydown(function() {
    	$('#user_id').val('');
    });

    <cfif isDefined("url.sent")>
	    $.notify({
	      title: '<strong>Sent!</strong>',
	      icon: 'fa fa-paper-plane',
	      message: "User will receive an email and/or text message."
	    },{
	      type: 'success',
	      animate: {
			    enter: 'animated fadeInUp',
	        exit: 'animated fadeOutRight'
	      },
	      placement: {
	        from: "top",
	        align: "center"
	      },
	      offset: 20,
	      spacing: 10,
	      z_index: 1031,
	    });

	    window.history.replaceState({}, document.title, "" + "?d=<cfoutput>#d#</cfoutput>");
	</cfif>
});

$('#confirm-delete').on('show.bs.modal', function(e) {
    $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
});

function goEdit(res_id,user_id,reg,name,phone,email,pin) {
	// Get time slots buttons
	$("#slotPlaceholder").remove();
    $("#slotButtons").load("../getSlots.cfm?res_id=" + res_id, function() {
      $('[data-toggle="popover"]').popover();
    });

    // Populate form fields
    $('#reg').val(reg);
    $('#name').val(name);
	$('#pin').val(pin);
	$('#email').val(email);
	$('#phone').val(phone);
    $('#user_id').val(user_id);
    $('#edit_id').val(res_id);

    // Panel to edit-mode
    $('#res_panel').switchClass('panel-default', 'panel-primary', 0);
    $('#res_panel .panel-title').html('<a href="?d=<cfoutput>#d#</cfoutput>" class="btn btn-sm btn-danger btn-ok pull-right">Cancel</a><b>Editing Reservation</b>');
    $('#reg').prop("readonly", true);
}

$("#slotButtons").click(function(){
    $(':input[type="submit"]').prop('disabled', false);
});

</script>

<cfinclude template="../footer.cfm">