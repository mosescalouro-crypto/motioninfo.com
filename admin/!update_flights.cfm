<cfsetting requestTimeOut = "800000">   

<cfset depap='LAS'>

<cfoutput>

<h3>Airport: #depap#</h3>
<h4>Fetching flights for:</h4>

<cfloop from='1' to='14' index="day">
    <cfloop list="0100,0500,0900,1300,1700,2100" index="dephr">

        <cfset depdate = dateformat(DateAdd('d',day,now()),'yyyymmdd')>

        <cfhttp url="http://xml.flightview.com/fvmaritimeinfosys/fvxml.exe" method="get">
             <cfhttpparam type="url" name="depap" value="#depap#">      
             <cfhttpparam type="url" name="dephr" value="#dephr#">  
             <cfhttpparam type="url" name="depdate" value="#depdate#">
        </cfhttp>       

        <cfset response="#xmlparse(cfhttp.FileContent)#">
        
        #depdate# #dephr#<br>
            
            <cfif isDefined("response.FlightViewResults.Flight")>
            
                <cfset results='#arraylen(response.FlightViewResults.Flight)#'>
                                    
                <cfloop array="#response.FlightViewResults.Flight#" index="i">
                    <cfset DepSched = i.departure.DateTime[1].Date.xmltext & " " & i.departure.DateTime[1].Time.XmlText>
                    <!---<cfif arraylen(i.departure.DateTime) gt 1>
                        <cfset DepActual = i.departure.DateTime[2].Date.xmltext & " " & i.departure.DateTime[2].Time.XmlAttributes.utc>
                    <cfelse>
                        
                    </cfif>--->
                    <cfset DepActual = DepSched>
                    <!---<cfset DepOnTime = DateDiff('n',DepSched,DepActual)>--->

                    <cfset ArrSched = i.arrival.DateTime[1].Date.xmltext & " " & i.arrival.DateTime[1].Time.XmlText>
                    <!---<cfif arraylen(i.arrival.DateTime) gt 1>
                        <cfset ArrActual = i.arrival.DateTime[2].Date.xmltext & " " & i.arrival.DateTime[2].Time.XmlAttributes.utc>
                    <cfelse>
                        
                    </cfif>--->
                    <cfset ArrActual = ArrSched>
                    <!---<cfset ArrOnTime = DateDiff('n',ArrSched,ArrActual)>--->

                    <cfquery datasource='OAG' name='exists'>
                        select flightid from flights
                        where (flightid = '#ListFirst(i.XmlAttributes.FlightId,":")#' 
                                or registration = <cfif isDefined("i.Aircraft.TailNumber.XmlText")>'#i.Aircraft.TailNumber.XmlText#'<cfelse>'-1'</cfif>)
                        and departuredatetime = '#DepActual#'
                    </cfquery>

                    <cfif !exists.recordcount>
                        <cfquery datasource='OAG' name='insert'>
                            insert into flights (
                                    flightid,
                                    registration,
                                    departureairport,
                                    departuredatetime,
                                    arrivalairport,
                                    arrivaldatetime,
                                    departuregate,
                                    arrivalgate
                                )
                            values(
                                    '#ListFirst(i.XmlAttributes.FlightId,":")#',
                                    <cfif isDefined("i.Aircraft.TailNumber.XmlText")>'#i.Aircraft.TailNumber.XmlText#'<cfelse>NULL</cfif>,
                                    '#i.Departure.Airport.AirportId.AirportCode.XmlText#',
                                    '#DepActual#',
                                    '#i.Arrival.Airport.AirportId.AirportCode.XmlText#',
                                    '#ArrActual#',
                                    <cfif isDefined("i.Departure.Airport.Gate.XmlText")>'#i.Departure.Airport.Gate.XmlText#'<cfelse>NULL</cfif>,
                                    <cfif isDefined("i.Arrival.Airport.Gate.XmlText")>'#i.Arrival.Airport.Gate.XmlText#'<cfelse>NULL</cfif>
                                )
                        </cfquery>
                    </cfif>
                </cfloop>
            </cfif>

    </cfloop>
</cfloop>

</cfoutput>