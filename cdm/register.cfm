<cfif isDefined("form.submit")>
  <cfquery datasource="#application.datasource#" name="exists">
    SELECT reg from users
    where reg = '#form.reg#'
  </cfquery>

  <cfif exists.recordcount>
    <cflocation url="register.cfm?exists">
  <cfelse>
    <cfquery datasource="#application.datasource#" name="user_insert">
      INSERT into users (reg,pin,name,email,phone)
      values(
          '#form.reg#',
          '#form.pin#',
          <cfif isDefined("form.name")>
            '#form.name#',
          <cfelse>
            NULL,
          </cfif>
          <cfif isDefined("form.email")>
            '#form.email#',
          <cfelse>
            NULL,
          </cfif>
          <cfif isDefined("form.phone")>
            '#form.phone#'
          <cfelse>
            NULL
          </cfif>
          );
    </cfquery>

    <cflocation url="register.cfm?thanks">
  </cfif>
</cfif>

<cfinclude template="header.cfm">

	<div class="row">
      <div class="col-lg-12">
          <h2 class="page-header">Delay Mitigation Tool</h2>
      </div>
  </div>

  <div class="row">
      <div class="col-lg-6 col-lg-offset-3">
          <div class="panel panel-default">
            <cfif IsDefined("url.exists")>
              <div class="panel-heading">
                  <h3 class="panel-title">Account Exists</h3>
              </div>
              <!-- /.panel-heading -->
              <div class="panel-body">
                  <h4>An account for the specified tail number has already been created.</h4>
                  <h4>Please <a href="./secure/">proceed to login</a></h4>
              </div>
            <cfelseif IsDefined("url.thanks")>
              <div class="panel-heading">
                  <h3 class="panel-title">Account Created</h3>
              </div>
              <!-- /.panel-heading -->
              <div class="panel-body">
                  <h4><a href="./secure/">Proceed to login</a></h4>
              </div>
            <cfelse>
              <div class="panel-heading">
                  <h3 class="panel-title">Create Your Account</h3>
              </div>
              <!-- /.panel-heading -->
              <div class="panel-body">
                  <cfoutput>
                  <form action="register.cfm" method="POST" role="form" data-toggle="validator">
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <input type="text" name="reg" class="form-control" placeholder="Tail Number" autofocus required>
                        <div class="help-block with-errors" style="font-size:0.8em"></div>
                      </div>
                      <div class="form-group">
                        <input type="password" name="pin" id="pass" placeholder="PIN" data-minlength="4" class="form-control" data-error="PIN must be at least 4 numbers" required>
                        <div class="help-block with-errors" style="font-size:0.8em"></div>
                      </div>
                      <div class="form-group">
                        <input type="password" name="pin_conf" placeholder="Confirm PIN" class="form-control" data-match="##pass" data-match-error="PINs don't match" required>
                        <div class="help-block with-errors" style="font-size:0.8em"></div>
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <input type="text" name="name" class="form-control" placeholder="Name (optional)">
                        <div class="help-block with-errors" style="font-size:0.8em"></div>
                      </div>
                      <div class="form-group">
                        <input type="text" name="email" class="form-control" placeholder="Email (optional)">
                        <div class="help-block with-errors" style="font-size:0.8em"></div>
                      </div>
                      <div class="form-group">
                        <input type="text" name="phone" class="form-control" placeholder="Phone (optional)">
                        <div class="help-block with-errors" style="font-size:0.8em"></div>
                      </div>
                    </div>
                  </div>
                  <input type="submit" name="submit" class="btn btn-primary" value="Submit">
                  </form>
                  </cfoutput> 
              </div>
            </cfif>
              <!-- /.panel-body -->
          </div>
      </div>
  </div>

<script src="/js/validator.js"></script>

<cfinclude template="footer.cfm">