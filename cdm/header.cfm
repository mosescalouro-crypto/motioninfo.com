<!DOCTYPE html>
<html lang="en">

<cfif IsDefined("url.logout")> 
    <cfscript>
        StructClear(Session);
        StructClear(url);
    </cfscript>
    <cflocation url="index.cfm">
</cfif>

<cfif isDefined("cookie.userid")>
    <cfquery datasource="#application.datasource#" name="existing">
        SELECT top 1 * from reservations 
        where user_id = #cookie.userid#
        and departure >= dateadd(hour,-8,getdate())
        and archived = 0
        order by departure asc
    </cfquery>

    <cfif existing.recordcount>
        <cfset existingDate = dateFormat(existing.departure,'#application.dateFormat#')>
    </cfif>
</cfif>

<cfif isDefined("url.d")>
    <cfset d = url.d>
<cfelseif isDefined("existingDate")>
    <cfset d = existingDate>
<cfelse>
    <cfset d = dateFormat(now(),"#application.dateformat#")>
</cfif>
    
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Delay Mitigation Tool</title>

    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- Optional theme -->
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/css/startmin.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <link href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.min.css" rel="stylesheet">

    <script src="//code.jquery.com/jquery-latest.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.bundle.min.js"></script>

    <script src="//cdnjs.cloudflare.com/ajax/libs/mouse0270-bootstrap-notify/3.1.5/bootstrap-notify.min.js"></script>
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

        .panel-title {
            font-weight: bold;
        }

        .button-checkbox i {
            font-size: 1.2em;
        }

        .popover-title {
            font-weight: bold;
        }

        #page-wrapper .popover.bottom .arrow {
            left:90% !important;
        }

        #page-wrapper .popover { 
            margin-left: -210px;
        }

        #chart {
          cursor: pointer;
        }

        .navbar-inverse {
          background-color: #122f57;
          background-image: linear-gradient(to bottom,#122f57 0,#0b1e38 100%);
        }

        .navbar-inverse a {
            color: #aaa !important;
        }

        .navbar-inverse a:hover,
        .navbar-inverse a:focus {
            background-color: #0b1e38 !important;
            color: #ccc !important;
        }

        .btn-danger {
            color: #fff !important;
        }

        #resTable tr {
            cursor: pointer;
        }
    </style>

</head>
<body>
<div id="wrapper">
    <cfinclude template="nav.cfm">
    <!-- Page Content -->
    <div id="page-wrapper">
        <div class="container-fluid">