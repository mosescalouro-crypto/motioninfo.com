<cfcomponent> 
<cfset THIS.name = "CDM Secure">
 
<cffunction name="OnRequestStart">

    <cfargument name = "request" required="true"/> 

    <cfscript>
        application.dateformat = 'mm/dd/yyyy';
        application.timeformat = 'HH:mm';
        application.datasource = 'OAG';
    </cfscript>
 
</cffunction> 
</cfcomponent>