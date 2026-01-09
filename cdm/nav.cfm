<nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#" style="padding: 5px 0 0 0;">
              <img src="//motioninfo.net/cdm/images/mccarran_logo.png">
            </a>
          </div>
          <!---<div class="collapse navbar-collapse" id="navbar">
            <ul class="nav navbar-nav">
                <li class="active"><a href=""><big><i class="fa fa-plane fa-fw"></i></big> Example</a></li>
            </ul>--->

            <!-- Top Navigation: Right Menu -->
            <ul class="nav navbar-right navbar-top-links">
              <cfif findNoCase("secure",CGI.SCRIPT_NAME) or findNoCase("fbo",CGI.SCRIPT_NAME) or findNoCase("faa",CGI.SCRIPT_NAME)>
                <li><a href="?logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>     
              <cfelse>
                <li><a href="./secure/"><i class="fa fa-sign-out fa-fw"></i> Login</a></li>
              </cfif>
            </ul>
          </div>
        </div>
    </nav>