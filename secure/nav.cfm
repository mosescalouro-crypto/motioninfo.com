<nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/" style="padding: 5px 0 0 0;">
              <img src="//www.motioninfo.net/images/mislogo_aero_smbw.png">
            </a>
          </div>
          <div class="collapse navbar-collapse" id="navbar">
            <ul class="nav navbar-nav">
                <li<cfif listlast(cgi.script_name,"/") eq 'stats.cfm'> class="active"</cfif>><a href="stats.cfm" target="_parent"><big><i class="fa fa-dashboard fa-fw"></i></big> Station Stats</a></li>
                <li<cfif listlast(cgi.script_name,"/") eq 'vrs_nav.cfm'> class="active"</cfif>><a href="/secure/map/"><big><i class="fa fa-plane fa-fw"></i></big> Tracking Map</a></li>
            </ul>

            <!-- Top Navigation: Right Menu -->
            <ul class="nav navbar-right navbar-top-links">
                <li><a href="/secure/logout.html" target="_parent"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
            </ul>
          </div>
        </div>
    </nav>