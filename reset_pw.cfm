<cfif isDefined("n")>
    <cfset hash = Hash('#n#',"SHA-256")>
    
    <cfquery name="reset" dataSource="MIS"> 
        SELECT userid from passwordreset
        WHERE ID = '#hash#'
        AND time >= DateAdd("hour",-12,getdate())
    </cfquery>
<cfelse>
    <cfabort>
</cfif>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="Maritime Information Systems">

        <title>MotionInfo - Reset Password</title>

        <!-- Bootstrap Core CSS -->
        <link href="/css/bootstrap.min.css" rel="stylesheet">

        <!-- MetisMenu CSS -->
        <link href="/css/metisMenu.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="/css/startmin.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>

        <div class="container"><br>
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-panel panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Reset Password</h3>
                        </div>
                        <div class="panel-body">
                            <cfif reset.recordcount>
                                <cfif isDefined("url.n")>
                                    <form role="form" method="Post" action="reset_pw.cfm" role="form" data-toggle="validator">
                                        <input type="hidden" name="n" value="<cfoutput>#url.n#</cfoutput>">
                                        <fieldset>
                                            <div class="form-group">
                                                <input type="password" name="pass" id="pass" placeholder="New Password" data-minlength="6" class="form-control" data-error="Password must be at least 6 characters" required autofocus>
                                                <div class="help-block with-errors" style="font-size:0.8em"></div>
                                            </div>
                                            <div class="form-group">
                                                <input type="password" name="pass_conf" placeholder="Confirm New Password" class="form-control" data-match="#pass" data-match-error="Passwords don't match" required>
                                                <div class="help-block with-errors" style="font-size:0.8em"></div>
                                            </div>
                                            <!-- Change this to a button or input when using this as a form -->
                                            <input type="submit" class="btn btn-lg btn-success btn-block" name="reset" value="Reset Password">
                                        </fieldset>
                                    </form>
                                <cfelseif isDefined("form.n")>
                                    <cfset pass = form.pass>

                                    <!--- VTS Password --->
                                    <cfset base64 = toBase64(pass)>
                                    <cfset binary = toBinary(base64)>
                                    <cfset hex = binaryEncode(binary,"hex")>

                                    <cfset count = len(hex) * 2>
                                    <cfloop index="i" from="2" to="#count#" step="4">
                                        <cfset hex = Insert("00",hex,i)>
                                    </cfloop>

                                    <cfset hexPadded = binaryDecode(hex,"hex")>
                                    <cfset vts_hash = Hash(hexPadded)>

                                    <cfset count = (len(vts_hash) * 1.5) - 2>
                                    <cfloop index="i" from="2" to="#count#" step="3">
                                        <cfset vts_hash = Insert("-",vts_hash,i)>
                                    </cfloop>

                                    <!--- VRS Password --->
                                    <cfset vrs_hash = Hash('#pass#',"SHA-256")>

                                    <!--- SHA1 (Apache) Hash --->
                                    <cfset pwhash = "{SHA}" & ToBase64(BinaryDecode(Hash(pass, "SHA1"), "Hex"))>

                                    <cfquery name="update" dataSource="MIS"> 
                                        Update StnUsers
                                        SET hash = '#pwhash#',
                                            vts_hash = '#vts_hash#',
                                            vrs_hash = '#vrs_hash#',
                                            updated = getdate()
                                        WHERE ID = '#reset.userid#'
                                    </cfquery>
                                    
                                    <h3>Password has been reset.</h3>
                                    <p>Please proceed to the <a href="http://secure.motioninfo.net">login page</a>.</p>
                                </cfif>
                            <cfelse>
                                <h3>Link is expired or invalid.</h3>
                            </cfif>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- jQuery -->
        <script src="/js/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="/js/bootstrap.min.js"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="/js/metisMenu.min.js"></script>

        <!-- Custom Theme JavaScript -->
        <script src="/js/startmin.js"></script>

        <script src="/js/validator.js"></script>

    </body>
</html>