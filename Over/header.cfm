<!DOCTYPE html>
<html lang="en">
    
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>NavPASS Bahamas Operations</title>

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

    <link href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.min.css" rel="stylesheet">

    <script type="text/javascript" src="//code.jquery.com/jquery-latest.min.js"></script>

    <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>

    <!-- Latest compiled and minified JavaScript -->
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style>
        .table {
            font-size: 0.85em;
        }

        .ui-widget {
            font-size: 0.9em;
            z-index: 99999;
        }

        .panel-heading .btn-sm {
            margin-top: -6px;
        }

        .button-checkbox i {
            font-size: 1.2em;
        }
        #page-wrapper {
            padding-top: 30px;
        }
    </style>
</head>
<body>

<div id="wrapper">

    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
			<!---
            <a class="navbar-brand" href="/" style="padding: 5px 0 0 0;">
              <img src="http://motioninfo.net/images/mislogo_aero_smbw.png">
            </a>--->
          </div>
          <div class="collapse navbar-collapse" id="navbar">
            <ul class="nav navbar-nav">
                <li<cfif isDefined("url.overflights")> class="active"</cfif>><a href="./?overflights"><i class="fa fa-arrow-circle-up"></i> Overflights</a></li>
                <li<cfif isDefined("url.arrivals")> class="active"</cfif>><a href="./?arrivals"><i class="fa fa-arrow-circle-down"></i> Arrivals</a></li>
                <li<cfif isDefined("url.departures")> class="active"</cfif>><a href="./?departures"><i class="fa fa-clock-o"></i> Departures</a></li>
                <li<cfif isDefined("url.inzone")> class="active"</cfif>><a href="./?inzone"><i class="fa fa-wrench"></i>  In Zone</a></li>
                <li<cfif isDefined("url.all")> class="active"</cfif>><a href="./?all"><i class="glyphicon glyphicon-repeat"></i> All </a></li>
                <li<cfif isDefined("url.stats")> class="active"</cfif>><a href="stats.cfm"><i class="glyphicon glyphicon-check"></i> Stats</a></li>
            </ul><!---
            <form class="navbar-form navbar-right">
              <div class="form-group">
                <input type="text" class="form-control" id="site_search" name="term" placeholder="Site search..." autofocus>
              </div>
            </form>--->
             <ul class="nav navbar-nav navbar-right">
<!---                <li><a href="./?logout">Logout</a></li> ---->
            </ul>
          </div>
        </div>
    </nav>

    <!-- Page Content -->
    <div id="page-wrapper">
        <div class="container-fluid">
