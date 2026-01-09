<cfcomponent> 
<cfset THIS.name = "CDM Secure"> 
<cfset THIS.Sessionmanagement="True"> 
<cfset THIS.ApplicationTimeout = CreateTimeSpan( 7, 0, 0, 0 ) />
<cfset THIS.SessionTimeout = CreateTimeSpan( 7, 0, 0, 0 ) />
<cfset THIS.loginstorage="session">
 
<cffunction name="OnRequestStart">

    <cfargument name = "request" required="true"/> 

    <cfscript>
        application.dateformat = 'mm/dd/yy';
        application.dateformat_long = 'mm/dd/yyyy';
        application.dateformat_verbose = 'ddd, mmmm dd, yyyy';
        application.timeformat = 'HH:mm';
        application.datasource = 'OAG';
    </cfscript>
 
    <cflogin> 
        <cfif NOT IsDefined("cflogin")> 
            <cfinclude template="login.cfm"> 
            <cfabort> 
        <cfelse> 
            <cfif cflogin.name IS "" OR cflogin.password IS ""> 
                <cfoutput> 
                    <h2>You must provide your tail number and PIN. 
                    </h2> 
                </cfoutput>
                <cfinclude template="login.cfm"> 
                <cfabort> 
            <cfelse>
                <cfquery name="loginQuery" dataSource="#application.datasource#"> 
                    SELECT id,reg from users
                    WHERE 
                        reg = '#cflogin.name#' 
                        AND pin = '#cflogin.password#'
                </cfquery> 
                <cfif len(loginQuery.reg)>
                    <cfloginuser name="#cflogin.name#" Password = "#cflogin.password#" 
                        roles="">
                    <cfcookie name="userid" value="#loginquery.id#" expires="never" />
					<!---<cfquery name="loginQuery" dataSource="MIS"> 
                        Update users set datelastlogin = getdate()
                        WHERE username = '#cflogin.name#' 
					</cfquery>--->
                <cfelse> 
                    <cfoutput> 
                        <H2>Your login information is not valid.<br> 
                        Please Try again</H2> 
                    </cfoutput>     
                    <cfinclude template="login.cfm"> 
                    <cfabort> 
                </cfif> 
            </cfif>     
        </cfif> 
    </cflogin> 
 
</cffunction> 
</cfcomponent>