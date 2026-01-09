<cfif findNoCase("UD=1",cgi.http_cookie)>
    <cflocation url="http://motioninfo.net/secure/">
</cfif>

<cfif isDefined("form.update")>
<cfif form.name IS "" OR form.password IS ""> 
    <cfoutput> 
        <h2>You must enter text in both the User Name and Password fields.</h2> 
    </cfoutput> 
    <cfabort> 
<cfelse>
    <cfset vrs_hash = Hash('#form.password#',"SHA-256")>
    <cfquery name="loginQuery" dataSource="MIS"> 
        SELECT username,site_no,hash
        FROM StnUsers 
        WHERE 
            username = '#form.name#' 
            AND VRS_hash = '#vrs_hash#'
    </cfquery> 
    <cfif len(loginQuery.site_no)>
        <cfif !len(loginQuery.hash)>
            <cfset hash = "{SHA}" & ToBase64(BinaryDecode(Hash(form.password, "SHA1"), "Hex"))>
            <cfquery name="newHash" dataSource="MIS">
                Update StnUsers
                set hash = '#hash#'
                where username = '#loginQuery.username#'
                and site_no = '#loginQuery.site_no#'
            </cfquery>
            <cfcookie name="ud" value="1" expires="never"></cfcookie>
        </cfif>
        <cflocation url="http://motioninfo.net/secure/?error=1">
    <cfelse> 
        <cfoutput> 
            <H2>Your login information is not valid.<br> 
            Please Try again</H2> 
        </cfoutput>
    </cfif> 
</cfif>
</cfif>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="Maritime Information Systems">

        <title>MotionInfo - Please Sign In</title>

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
                            <h3 class="panel-title">Please Sign In</h3>
                        </div>
                        <div class="panel-body">
                            <div class="alert alert-danger hide" id="error"></div>
                            <form role="form" method="Post" action="">
                                <fieldset>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Username" name="name" type="text" autofocus>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Password" name="password" type="password" value="">
                                    </div>
                                    <p class="help-block"><a href="/forgot_password.cfm">Forgot your password?</a></p>
                                    <!-- Change this to a button or input when using this as a form -->
                                    <input type="submit" class="btn btn-lg btn-success btn-block" name="update" value="Login">
                                </fieldset>
                            </form>
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

    </body>
</html>