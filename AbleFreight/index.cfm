<!DOCTYPE html>
<html lang="en">
    
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>MIS Station Info</title>

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

    <!-- Custom Fonts -->
    <link href="../css/font-awesome.min.css" rel="stylesheet" type="text/css">

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

        .popover {
            min-width: 444px !important;
        }
    </style>
</head>
<body>

<!-- Page Content -->
<div id="page-wrapper">
    <div class="container-fluid">
<br>
    <div class="panel panel-default">
        <div class="panel-heading"><h3 class="panel-title">Flight Tracking</h3></div>
        <cfif !isDefined("form.flights")>
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-8">
                        <form method="post">
                          <div class="form-group">
                            <label for="flights">Input flight numbers (comma separated):</label>
                            <textarea name="flights" class="form-control" rows="3"></textarea>
                          </div>
                          <div class="form-group">
                              <button type="submit" class="btn btn-default">Track Flights</button>
                          </div>
                        </form>
                    </div>
                </div>
            </div>
        <cfelse>
            <cfif form.flights eq "test file">
                <cffile action="read" file="#ExpandPath('./able_flights.csv')#" variable="csv">
                <cfset inc = 0>
                <cfsavecontent variable="flights">
                    <cfloop list="#csv#" delimiters="#Chr(13) & Chr(10)#" index="i">
                        <cfoutput>#i#,</cfoutput>
                        <cfset inc++>
                        <cfif inc gte 25>
                            <cfbreak>
                        </cfif>
                    </cfloop>
                </cfsavecontent>
                <cfset form.flights = reReplace(flights, "[[:space:]]", "", "ALL") />
            </cfif>
            <cfset LoginName = "fvxmldemoNovo3">
            <cfset PWord = "Ty$rhNovo77">

            <cfhttp url="http://xml.flightview.com/fvDemoConsOOOI/fvxml.exe" method="get">
                <cfhttpparam type="url" name="a" value="#LoginName#">
                <cfhttpparam type="url" name="b" value="#PWord#">
                <cfhttpparam type="url" name="ARRDATE" value="#DateFormat(Now(),'yyyymmdd')#">
                <cfhttpparam type="url" name="ACID" value="#form.flights#">
            </cfhttp>
                
            <cfset response="#xmlparse(cfhttp.FileContent)#">

            <cfoutput>
            <table class="table table-condensed table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Flight</th>
                        <th>Airframe</th>
                        <th>Tail ##</th>
                        <th>Departure</th>
                        <th>Arrival</th>
                        <th>Gate</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <cfif isDefined("response.FlightViewResults.Flight")>
                    <cfloop array="#response.FlightViewResults.Flight#" index="i">
                        <cfset DepSched = i.departure.DateTime[1].Date.xmltext & " " & i.departure.DateTime[1].Time.XmlAttributes.utc>
                        <cfif arraylen(i.departure.DateTime) gt 1>
                            <cfset DepActual = i.departure.DateTime[2].Date.xmltext & " " & i.departure.DateTime[2].Time.XmlAttributes.utc>
                        <cfelse>
                            <cfset DepActual = DepSched>
                        </cfif>
                        <cfset DepOnTime = DateDiff('n',DepSched,DepActual)>

                        <cfset ArrSched = i.arrival.DateTime[1].Date.xmltext & " " & i.arrival.DateTime[1].Time.XmlAttributes.utc>
                        <cfif arraylen(i.arrival.DateTime) gt 1>
                            <cfset ArrActual = i.arrival.DateTime[2].Date.xmltext & " " & i.arrival.DateTime[2].Time.XmlAttributes.utc>
                        <cfelse>
                            <cfset ArrActual = ArrSched>
                        </cfif>
                        <cfset ArrOnTime = DateDiff('n',ArrSched,ArrActual)>

                        <cfset map = ''>
                        <cfif isDefined("i.map.xmlText")>
                            <cfset map = i.map.xmlText>
                        </cfif>
                        <tr>
                            <td>#ListFirst(i.XmlAttributes.FlightId,":")#</td>
                            <td>#i.Aircraft.AircraftType.XmlText#</td>
                            <td><cfif isDefined("i.Aircraft.TailNumber.XmlText")>#i.Aircraft.TailNumber.XmlText#</cfif></td>
                            <td>#i.Departure.Airport.AirportName.XmlText# (#i.Departure.Airport.AirportId.AirportCode.XmlText#) @ #timeFormat(DepActual,'H:mm')# UTC on #dateFormat(DepActual,'d-mmm')# <cfif DepOnTime gt 0><b class="text-danger">(#DepOnTime# min delay)</b><cfelse>(On Time)</cfif></td>
                            <td>#i.Arrival.Airport.AirportName.XmlText# (#i.Arrival.Airport.AirportId.AirportCode.XmlText#) @ #timeFormat(ArrActual,'H:mm')# UTC on #dateFormat(ArrActual,'d-mmm')# <cfif ArrOnTime gt 0><b class="text-danger">(#ArrOnTime# min late)</b><cfelse>(On Time)</cfif></td>
                            <td><cfif isDefined("i.Arrival.Airport.Gate.XmlText")>#i.Arrival.Airport.Gate.XmlText#</cfif></td>
                            <td><cfif len(map)>Airborne<!---<nobr>&nbsp;</nobr><a tabindex="0" class="btn btn-xs btn-primary" role="button" data-toggle="popover" data-placement="left" data-trigger="focus" title="Flight Status Map" data-img="#map#">Map</a>---><cfelse>Not&nbsp;Airborne</cfif></td>
                        </tr>
                    </cfloop>
                <cfelse>
                    <tr><td><b class="text-danger">Lookup failed</b></td></tr>
                </cfif>
                </tbody>
            </table>
            </cfoutput>
        </cfif>

    </div>
	</div>
</div>

</div>

<script>
$(function () {
  $('[data-toggle="popover"]').popover({
      html: true,
      content: function(){return '<img src="'+$(this).data('img') + '" width="412" height="320" />';}
    });
})
</script>
<cfmail to='mjc@mgn.com' from='ab@mgn.com' subject='AbleFreight'>
Date/Time: #dateformat(now(),'m/d/yyyy')# #timeformat(now(),'HH"MM:SS')#
IP: #cgi.remote_addr#

<cfif parameterexists(Flights)>
Flights:

#flights#
</cfif>

</cfmail>
</body>
</html>