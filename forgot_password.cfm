<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="Maritime Information Systems">

        <title>MotionInfo - Forgot Password</title>

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

    <cfif isDefined("form.username")>
        <cfquery name="userid" dataSource="MIS"> 
            SELECT id from StnUsers
            where username = '#form.username#'
        </cfquery>

        <cfif userid.recordcount>
            <cfset UUID = CreateUUID()>
            <cfset hash = Hash('#UUID#',"SHA-256")>

            <cfquery name="pwreset" dataSource="MIS"> 
                INSERT INTO PasswordReset (ID,userid)
                VALUES ('#hash#','#userid.id#')
            </cfquery> 

            <cfsavecontent variable="msg">Good Day,
<br><br>
Thank you for hosting with MIS. 
<br><br>
At your request, here is a link which will allow you to reset your password:
<br>
<a href="http://motioninfo.net/reset_pw.cfm?n=<cfoutput>#UUID#</cfoutput>">Reset Password</a>
<br><br>
Please copy and paste this address into your browser's address bar if the link above doesn't work:<br>
http://motioninfo.net/reset_pw.cfm?n=<cfoutput>#UUID#</cfoutput>
<br>
Please note: this link is only valid for 12 hours.
<br><br>
Do not hesitate to contact me if you have any questions, concerns or need any help logging in to your ADS-B account. As always, I am here to help.
<br><br>
Have a wonderful day!!
<br>
<br><br>
Thank you,
 <br><br>
Debi Robinson<br>
Director of Marketing & Network Support<br>
M.I.S.,Inc.<br>
Tel:  +1 401-247-7780 x1<br>
Email: debi.robinson@maritimeinfosystems.com<br>
http://www.motioninfo.net</cfsavecontent>

            <cfmail to = "#form.username#"
                    from = "Debi Robinson <debi.robinson@maritimeinfosystems.com>"
                    subject = "Reset your password" 
                    type="text/html">
                        
                #msg#
            </cfmail>
        <cfelse>
            <h2>User not found</h2><cfabort>
        </cfif>
    </cfif>

        <div class="container"><br>
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-panel panel panel-default">
                        <div class="panel-heading">
                            <cfif isDefined("form.reset")>
                                <h3 class="panel-title">Request Sent</h3>
                            <cfelse>
                                <h3 class="panel-title">Request Password Reset</h3>
                            </cfif>
                        </div>
                        <div class="panel-body">
                            <cfif isDefined("form.reset")>
                            	<h3>Please check your email.</h3><br>
                                <p>If you have not received our email within an hour, please call support at +1 401-247-7780</p>
                            <cfelse>
                                <div class="alert alert-danger hide" id="error"></div>
                                <form role="form" method="Post" action="">
                                    <fieldset>
                                        <div class="form-group">
                                            <input class="form-control" placeholder="E-mail" name="username" type="email" autofocus>
                                        </div>
                                        <!-- Change this to a button or input when using this as a form -->
                                        <input type="submit" class="btn btn-lg btn-success btn-block" name="reset" value="Reset Password">
                                    </fieldset>
                                </form>
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

        <script>
        	$(document).ready(function() {
			   if(location.search.indexOf('error=')>=0) {
			   	$("#error").append("Please check your credentials and try again.");
			   	$("#error").removeClass("hide");
			   }
			});
        </script>

    </body>
</html>