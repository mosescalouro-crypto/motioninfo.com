<cfinclude template=header.cfm>
<cfquery datasource='REPORTS' name='ops'>
select op,count(*) as total from overflights
group by op
</cfquery>

<cfquery datasource='REPORTS' name='topoperators'>
use reports
select top 10 isnull(operator,'UNKNOWN') as operator,count(*) as total from overflights 
where operator is not null and operator > '1'
group by operator
order by total desc
</cfquery>

<cfquery datasource='REPORTS' name='topoperatorsbydistance'>
select top 10 isnull(operator,'UNKNOWN') as operator,sum(overflightdistance) as total from overflights
where operator is not null and operator > '1'
group by operator
order by total desc
</cfquery>
<cfquery datasource='REPORTS' name='opsperhour'>
select datepart(hh,optime)+1 as hour ,count(*) as total
from overflights
group by datepart(hh,optime) 
order by datepart(hh,optime) 
</cfquery>


<br>&nbsp;
<br>
<table><tr><td>
<cfchart format="html" type="bar" showlegend="false" chartHeight="300" chartWidth="400" title="Bahamian Operations" show3d="true">
    <cfchartseries>
	<cfoutput query=ops>
        <cfchartdata item="#op#" value=#total#>
</cfoutput>
		</cfchartseries>
</cfchart>
</td><td>
<cfchart format="html" type="bar" showlegend="false" chartHeight="300" chartWidth="400" title="Top 10 Operators" show3d="true">
    <cfchartseries>
	<cfoutput query=topoperators>
        <cfchartdata item="#operator#" value=#total#>
</cfoutput>
		</cfchartseries>
</cfchart>
</td></tr>
<tr><td>
<cfchart format="html" type="bar" showlegend="false" chartHeight="300" chartWidth="400" title="Top 10 Operators by Distance" show3d="true">
    <cfchartseries>
	<cfoutput query=topoperatorsbydistance>
        <cfchartdata item="#operator#" value=#total#>
</cfoutput>
		</cfchartseries>
</cfchart>
</td><td>
<cfchart format="html" type="bar" showlegend="false" chartHeight="300" chartWidth="400" title="Operations By Hour (UTC)" show3d="true">
    <cfchartseries>
	<cfoutput query=opsperhour>
        <cfchartdata item="#hour#" value=#total#>
</cfoutput>
		</cfchartseries>
</cfchart>
</td></tr>

</table>


<cfinclude template=footer.cfm>

<!---
<cfquery name="qEmployee" datasource="cfdocexamples" maxRows="6">
    SELECT FirstName, LastName, Salary FROM EMPLOYEE
</cfquery>
<cfchart format="html" pieslicestyle="solid" chartWidth="600" chartHeight="400">
    <cfchartseries query="qEmployee" type="pie" serieslabel="Salary Details 2016" valuecolumn="Salary" itemcolumn="FirstName">
    </cfchartseries>
</cfchart>
--->